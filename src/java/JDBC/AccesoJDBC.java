package JDBC;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author alumno
 */
public class AccesoJDBC {
    
    private Connection conn;
    
    public AccesoJDBC(){
        try{
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            this.conn = DriverManager.getConnection
            ("jdbc:oracle:thin:@localhost:1521:XE","system","javaoracle");
        } catch (Exception e){
            e.printStackTrace();
        }
    }
    
    public ResultSet consDept(){
        ResultSet res = null;
        try{
            Statement stmt = conn.createStatement();
            res = stmt.executeQuery("SELECT * FROM Dept");
        } catch (Exception e){
            e.printStackTrace();
        }
        return res;
    }
    
    public ResultSet selPorOficio(String oficio){
        ResultSet res = null;
        try{
            PreparedStatement ps = conn.prepareStatement
                ("SELECT emp_no,apellido,oficio,nvl(dir,0) dir,fecha_alt,salario,"
                        + "nvl(comision,0) comision,dept_no FROM emp WHERE oficio = ?");
            ps.setString(1, oficio);
            res = ps.executeQuery();
        } catch (Exception e){
            e.printStackTrace();
        }        
        return res;
    }
    
    public ResultSet getOficios(){
        ResultSet res = null;
        try{
            Statement stmt = conn.createStatement();
            res = stmt.executeQuery("SELECT DISTINCT oficio FROM emp");
        } catch (Exception e){
            e.printStackTrace();
        }        
        return res;
    }
    
    public ResultSet getHospitales(){
        ResultSet res = null;
        try{
            Statement stmt = conn.createStatement();
            res = stmt.executeQuery("SELECT hospital_cod, nombre FROM hospital");
        } catch (Exception e){
            e.printStackTrace();
        }        
        return res;
    }
    
    public ResultSet selDoctHosp(String[] cod){
        ResultSet res = null;
        try{
            String aux = cod[0];
            for (int i = 1; i < cod.length; i++){
                aux += ","+cod[i];
            }
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
            res = stmt.executeQuery("SELECT * FROM doctor WHERE hospital_cod in ("+aux+")");
        } catch (Exception e){
            e.printStackTrace();
        }        
        return res;
    }
    
    public ResultSet getEmpPaginado(int pagina, int numRegPag){
        ResultSet res = null;
        try {
            Statement stmt = conn.createStatement();
            res = stmt.executeQuery(
                    "SELECT "
                        + "emp_no, "
                        + "apellido, "
                        + "oficio, "
                        + "dir, "
                        + "fecha_alt, "
                        + "salario, "
                        + "comision, "
                        + "dept_no "
                    + "FROM "
                        + "("
                        + "SELECT "
                            + "emp_no, "
                            + "apellido, "
                            + "oficio, "
                            + "nvl(dir,0) dir, "
                            + "fecha_alt, "
                            + "salario, "
                            + "nvl(comision,0) comision, "
                            + "dept_no, "
                            + "rownum r "
                        + "FROM "
                            + "emp "
                        + "WHERE "
                            + "ROWNUM <= "+pagina*numRegPag+""
                        + ") aux "
                    + "WHERE "
                        + "r > "+(pagina-1)*numRegPag
            );
        } catch (Exception e){
            e.printStackTrace();
        }
        return res;
    }
    
    public int numEmp(){
        int res = 0;
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT count(*) FROM emp");
            rs.next();
            res = rs.getInt(1);
        } catch (Exception e){
            e.printStackTrace();
        }
        return res;
    }
    
    public ResultSet getEmpleados(){
        ResultSet res = null;
        try {
            Statement stmt = conn.createStatement();
            res = stmt.executeQuery("SELECT emp_no, apellido FROM emp");
        } catch (Exception e){
            e.printStackTrace();
        }
        return res;
    }
    
    public ResultSet getEmpleado(int emp_no){
        ResultSet res = null;
        try{
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT "
                        + "emp_no, "
                        + "apellido, "
                        + "oficio, "
                        + "fecha_alt, "
                        + "salario, "
                        + "nvl(comision,0) comision "
                    + "FROM "
                        + "emp "
                    + "WHERE "
                        + "emp_no=?"
            );
            ps.setInt(1, emp_no);
            res = ps.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }
    
    public ResultSet getDepartamentos(){
        ResultSet res = null;
        try{
            Statement stmt = conn.createStatement();
            res = stmt.executeQuery("SELECT DISTINCT Dept_no, dNombre FROM dept");
        } catch (Exception e){
            e.printStackTrace();
        }        
        return res;
    }
    
    public ResultSet getEmpDept(String dept){
        ResultSet res = null;
        try{
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT "
                        + "EMP_NO, "
                        + "APELLIDO, "
                        + "OFICIO, "
                        + "nvl(DIR,0) DIR, "
                        + "FECHA_ALT, "
                        + "SALARIO, "
                        + "nvl(COMISION,0) COMISION, "
                        + "DEPT_NO "
                    + "FROM emp WHERE dept_no = ?",
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY
            );
            ps.setInt(1, Integer.parseInt(dept));
            res = ps.executeQuery();
        } catch (Exception e){
            e.printStackTrace();
        }        
        return res;
    }
}