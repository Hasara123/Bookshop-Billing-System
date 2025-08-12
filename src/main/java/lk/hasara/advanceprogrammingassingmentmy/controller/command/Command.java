package lk.hasara.advanceprogrammingassingmentmy.controller.command;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

public interface Command {
    void execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException;
}
