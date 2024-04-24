package org.ea.service;

import java.io.*;
import java.net.*;

public class SimpleServer {
    public static void main(String[] args) {
        int port = 8080; // Порт, на котором будет работать сервер
        ServerSocket serverSocket = null;

        try {
            serverSocket = new ServerSocket(port);
            System.out.println("Сервер запущен на порту " + port + "...");

            while (true) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("Подключился клиент: " + clientSocket.getInetAddress());

                // Создаем поток для обработки запроса от клиента
                Thread thread = new Thread(new ClientHandler(clientSocket));
                thread.start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (serverSocket != null) {
                try {
                    serverSocket.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // Класс для обработки запросов от клиентов
    private static class ClientHandler implements Runnable {
        private final Socket clientSocket;

        public ClientHandler(Socket clientSocket) {
            this.clientSocket = clientSocket;
        }

        @Override
        public void run() {
            try {
                BufferedReader in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                PrintWriter out = new PrintWriter(clientSocket.getOutputStream(), true);

                // Читаем первую строку запроса (обычно это строка запроса GET)
                String request = in.readLine();
                if (request != null) {
                    System.out.println("Запрос: " + request);

                    // Проверяем, запрашивает ли клиент index.html
                    if (request.contains("GET /index.html")) {
                        // Отправляем содержимое index.html
                        sendFile(out, "index.html", "text/html");
                    } else if (request.contains("GET /style.css")) {
                        // Отправляем содержимое style.css
                        sendFile(out, "style.css", "text/css");
                    } else {
                        // Если клиент запрашивает другой ресурс, отправляем ошибку 404
                        out.println("HTTP/1.1 404 Not Found");
                        out.println("Content-Type: text/plain");
                        out.println();
                        out.println("404 Not Found");
                    }
                }

                // Закрываем потоки
                in.close();
                out.close();
                clientSocket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // Метод для отправки содержимого файла клиенту
        private void sendFile(PrintWriter out, String fileName, String contentType) throws IOException {
            File file = new File(fileName);
            if (file.exists()) {
                BufferedReader reader = new BufferedReader(new FileReader(file));
                out.println("HTTP/1.1 200 OK");
                out.println("Content-Type: " + contentType);
                out.println();
                String line;
                while ((line = reader.readLine()) != null) {
                    out.println(line);
                }
                reader.close();
            } else {
                out.println("HTTP/1.1 404 Not Found");
                out.println("Content-Type: text/plain");
                out.println();
                out.println("404 Not Found");
            }
        }
    }
}
