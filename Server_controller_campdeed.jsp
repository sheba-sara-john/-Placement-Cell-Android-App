<%-- 
    Document   : server_controller
    Created on : 4 Oct, 2023, 3:32:37 PM
    Author     : Admin
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Iterator"%>
<%@page import="Connection.dbconnection"%>

<%
  dbconnection db = new dbconnection();
   String key = request.getParameter("requestType").trim();
   System.out.print(key);
   
   
   
// LOGIN

 if (key.equals("userlog")) {
        String ln = request.getParameter("fulnam");
        String lp = request.getParameter("pass");
        String st = "SELECT * from login where l_name='" + ln + "' and l_pass='" + lp + "' AND status='1'";
        Iterator it = db.getData(st).iterator();
        if (it.hasNext()) {
            Vector v = (Vector) it.next();
            String ress = v.get(1) + "#" + v.get(4)+"#";
            out.print(ress);
            System.out.println("ss"+ress);
        } else {
            out.print("failed");
             System.out.println("No"+st);
        }
    }
   
//   STUDENT SESSION
// student register

 if (key.equals("studreg")) {
        String fn=request.getParameter("fulnam");
        String a = request.getParameter("age");
        String e = request.getParameter("email");
        String pa = request.getParameter("pass");
        String ph = request.getParameter("phone");
        String c = request.getParameter("college");
        String co = request.getParameter("course");
        String g = request.getParameter("grad");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String jt = request.getParameter("jobtype");
        String sk = request.getParameter("skill");
        String l = request.getParameter("locat");
        String pr = request.getParameter("pref");
        String i=request.getParameter("image");
        String r=request.getParameter("pdf");
        System.out.println("IMAG==="+i);
          String insertQry = "SELECT COUNT(*) FROM stud_reg WHERE `s_email`='"+e+"' OR `s_phon`='"+ph+"'";
        System.out.println(insertQry);
         Iterator it = db.getData(insertQry).iterator();
        System.out.println("heloooooooooooooooooo");
        if (it.hasNext()) {
            Vector vec = (Vector)it.next();
            int max_vid = Integer.parseInt(vec.get(0).toString());
            System.out.println(max_vid);
             if (max_vid == 0) {
                String sq = "INSERT into stud_reg(s_name,age,s_email,s_paswd,s_phon,s_clg,s_cou,s_loctn,s_gdate,s_skills,s_job_ty,s_jobpre,s_img,resume)values('"+fn+"','"+a+"','" + e + "','" + pa + "','" + ph + "','"+c+"','" + co + "','"+l+"','" + g + "','"+sk+"','"+jt+"','"+pr+"','"+i+"','"+r+"')";
                 String sq1 = "INSERT into login(u_id,l_name,l_pass,type,status)values((select max(s_id) from stud_reg),'" + e + "','" + pa + "','student','1')";
                System.out.println(sq + "\n" + sq1);

                if (db.putData(sq) > 0 && db.putData(sq1) > 0) {

                      System.out.println("Registerd");
                    out.println("Registerd");

                } else {
                     System.out.println("Registration failed");
                    out.println("failed");
                }

            } else {
                System.out.println("Already Exist");
                out.println("Already Exist");
            }
        } else {
            out.println("failed");
        }

    }

 
 
 //stud_view_comp
 
if (key.equals("stud_view_comp")) {
        String str3 = "SELECT *FROM `cmpy_reg`";
        Iterator itr = db.getData(str3).iterator();
        JSONArray jsonarray = new JSONArray();
        if (itr.hasNext()) {
            while (itr.hasNext()) {
                Vector v = (Vector) itr.next();
                JSONObject jsonobj = new JSONObject();
                jsonobj.put("cid", v.get(0).toString());
                jsonobj.put("cname", v.get(1).toString());
                jsonobj.put("cloc", v.get(6).toString());
                jsonobj.put("cdes", v.get(11).toString());
                 jsonobj.put("cimg", v.get(12).toString());
                jsonarray.add(jsonobj);   
            }
            out.print(jsonarray);

            System.out.print(jsonarray);

        } else {
            out.println("failed");
        }
    }

//stud_profile

if (key.equals("stud_profile")) {
    String cid = request.getParameter("id");
        String st = "SELECT *FROM `stud_reg` WHERE s_id='"+cid+"'";
        Iterator it = db.getData(st).iterator();
        if (it.hasNext()) {
            Vector v = (Vector) it.next();
            String ress = v.get(0) + "#" + v.get(1)+"#"+ v.get(2)+"#"+ v.get(3)+"#"+ v.get(4)+"#"+ v.get(5)+"#"+ v.get(6)+"#"+ v.get(7)+"#"+ v.get(8)+"#"+ v.get(9)+"#"+ v.get(10)+"#"+ v.get(11)+"#"+ v.get(12)+"#"+ v.get(13)+"#";
            out.print(ress);
            System.out.println("ss"+ress);
        } else {
            out.print("failed");
             System.out.println("No"+st);
        }
    }

//student edit profile

if (key.equals("stud_edit_pro")) {
        String id=request.getParameter("stu_id");
        String fn=request.getParameter("fulnam");
        String a = request.getParameter("age");
        String e = request.getParameter("email");
        String pa = request.getParameter("pass");
        String ph = request.getParameter("phone");
        String c = request.getParameter("college");
        String co = request.getParameter("course");
        String g = request.getParameter("grad");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String jt = request.getParameter("jobtype");
        String sk = request.getParameter("skill");
        String l = request.getParameter("locat");
        String pr = request.getParameter("pref");
        String i=request.getParameter("image");
        System.out.println("IMAG==="+i);
        String sq5 = "UPDATE `stud_reg` SET s_name='"+fn+"',age='"+a+"',s_email='"+e+"',s_paswd='"+pa+"',s_phon='"+ph+"',s_clg='"+c+"',s_cou='"+co+"',s_loctn='"+l+"',s_gdate='"+g+"',s_skills='"+sk+"',s_job_ty='"+jt+"',s_jobpre='"+pr+"',s_img='"+i+"' WHERE s_id='"+id+"'";
       System.out.println("EEE"+sq5);
        int res6 = db.putData(sq5);
        if (res6 > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }

 //stud_homepage
 
if (key.equals("stud_home")) {
        String str3 = "SELECT *FROM `jobpost` WHERE status='0'";
        Iterator itr = db.getData(str3).iterator();
        JSONArray jsonarray = new JSONArray();
        if (itr.hasNext()) {
            while (itr.hasNext()) {
                Vector v = (Vector) itr.next();
                JSONObject jsonobj = new JSONObject();
                jsonobj.put("j_id", v.get(0).toString());
                jsonobj.put("cid", v.get(1).toString());
                jsonobj.put("j_title", v.get(2).toString());
                jsonobj.put("j_des", v.get(3).toString());
                jsonobj.put("j_typ", v.get(4).toString());
                 jsonobj.put("salary", v.get(5).toString());
                 jsonobj.put("qual", v.get(6).toString());
                 jsonobj.put("dedlin", v.get(7).toString());
                jsonarray.add(jsonobj);   
            }
            out.print(jsonarray);

            System.out.print(jsonarray);

        } else {
            out.println("failed");
        }
    }


//STUDENT SEARCH JOB
if (key.equals("getSearchResult")) {
        System.out.println("heloo");
        String searchText = request.getParameter("searchValue").trim();
        String text = "%" + searchText + "%";
        String qry = "select * from `jobpost` where j_title like '" + text + "'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator itr = db.getData(qry).iterator();
        JSONArray jsonarray = new JSONArray();
        if (itr.hasNext()) {
            while (itr.hasNext()) {
                Vector v = (Vector) itr.next();
                JSONObject jsonobj = new JSONObject();
                 jsonobj.put("j_id", v.get(0).toString());
                jsonobj.put("cid", v.get(1).toString());
                jsonobj.put("j_title", v.get(2).toString());
                jsonobj.put("j_des", v.get(3).toString());
                jsonobj.put("j_typ", v.get(4).toString());
                 jsonobj.put("salary", v.get(5).toString());
                 jsonobj.put("qual", v.get(6).toString());
                 jsonobj.put("dedlin", v.get(7).toString());
       
                jsonarray.add(jsonobj);   
            }
            out.print(jsonarray);

            System.out.print(jsonarray);

        } else {
            out.println("failed");
        }
    }


// student apply for job

 if (key.equals("studapplyjob")) {
        String cid=request.getParameter("c_id");
        System.out.println(cid);
        String jid = request.getParameter("j_id");
        String sid = request.getParameter("s_id");
         //String sq1 = "INSERT into applied_jobs(u_id,c_id,j_id,status)values('" + sid + "','" + cid + "','"+jid+"','applied')";
         String sql="INSERT INTO `applied_jobs`(`u_id`,`c_id`,`j_id`,`status`)VALUES('" + sid + "','" + cid + "','"+jid+"','applied')";
        int res2 = db.putData(sql);
        if (res2 > 0) {
            out.print("success");
        } else {
            out.print("failed");

        }
       
    }
 //get Status
 if (key.equals("getstatus")) {
        String cid = request.getParameter("c_id");
        String jid = request.getParameter("j_id");
        String sid = request.getParameter("s_id");
        
        String st = "SELECT `applied_jobs`.`status`,`applied_jobs`.`ap_id` FROM `applied_jobs` WHERE `applied_jobs`.`c_id`='"+cid+"' AND `applied_jobs`.`j_id`='"+jid+"' AND `applied_jobs`.`u_id`='"+sid+"'";
        System.out.println(st); 
        Iterator it = db.getData(st).iterator();
        if (it.hasNext()) {
            Vector v = (Vector) it.next();
            String ress = v.get(0) + "#" + v.get(1)+"#";
            out.print(ress);
            System.out.println("ss"+ress);
        } else {
            out.print("failed");
             System.out.println("No"+st);
        }
    }
 
// Student view req

 if (key.equals("stud_view_req")) {
     String id = request.getParameter("sid");
        String str3="SELECT `jobpost`.`j_id`,jobpost.j_title, jobpost.j_des, jobpost.j_typ, jobpost.salary, jobpost.qual, jobpost.app_dedlin, applied_jobs.status,`cmpy_reg`.`c_id`, cmpy_reg.c_name FROM jobpost INNER JOIN applied_jobs ON jobpost.j_id = applied_jobs.j_id INNER JOIN cmpy_reg ON jobpost.u_id = cmpy_reg.c_id WHERE applied_jobs.u_id ='"+id+"'";
        Iterator itr = db.getData(str3).iterator();
        JSONArray jsonarray = new JSONArray();
        if (itr.hasNext()) {
            while (itr.hasNext()) {
                Vector v = (Vector) itr.next();
                JSONObject jsonobj = new JSONObject();
                jsonobj.put("j_id", v.get(0).toString());
                jsonobj.put("cid", v.get(8).toString());
                jsonobj.put("j_title", v.get(1).toString());
                jsonobj.put("j_des", v.get(2).toString());
                jsonobj.put("j_typ", v.get(3).toString());
                 jsonobj.put("salary", v.get(4).toString());
                 jsonobj.put("qual", v.get(5).toString());
                 jsonobj.put("dedlin", v.get(6).toString());
                 jsonobj.put("ap_stat", v.get(7).toString());
                 jsonobj.put("cname", v.get(9).toString());
                jsonarray.add(jsonobj);   
            }
            out.print(jsonarray);

            System.out.print(jsonarray);

        } else {
            out.println("failed");
        }
    }
 
 //get company name
 if (key.equals("getcnam")) {
        String cid = request.getParameter("c_id");
        String jid = request.getParameter("j_id");
        String sid = request.getParameter("s_id");
         String st = "SELECT `cmpy_reg`.`c_name` FROM `cmpy_reg` INNER JOIN `jobpost` ON `jobpost`.`u_id`=`cmpy_reg`.`c_id` WHERE `jobpost`.`j_id`='"+jid+"'";

        System.out.println(st); 
        Iterator it = db.getData(st).iterator();
        if (it.hasNext()) {
            Vector v = (Vector) it.next();
            String ress = v.get(0) + "#" ;
            out.print(ress);
            System.out.println("ss"+ress);
        } else {
            out.print("failed");
             System.out.println("No"+st);
        }
    }
 
// Stud sent feedback


 if (key.equals("stud_send_feedback")) {
        String sid=request.getParameter("s_id");
        String jid=request.getParameter("j_id");
        String cid=request.getParameter("c_id");
        String s = request.getParameter("subject");
        String d = request.getParameter("descr");
        String r = request.getParameter("rating");
       
        String sq4 = "INSERT into stud_feedback(u_id,c_id,j_id,subj,des,rating)values('"+sid+"','"+jid+"','"+cid+"','"+s+"','"+d+"','"+r+"')";
        System.out.println(sq4);
        int res5 = db.putData(sq4);
        if (res5 > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }

 
// student view events

if (key.equals("stud_events")) {
        String str3 = "SELECT *FROM `events`";
        Iterator itr = db.getData(str3).iterator();
        JSONArray jsonarray = new JSONArray();
        if (itr.hasNext()) {
            while (itr.hasNext()) {
                Vector v = (Vector) itr.next();
                JSONObject jsonobj = new JSONObject();
                jsonobj.put("e_id", v.get(0).toString());
                jsonobj.put("cid", v.get(1).toString());
                jsonobj.put("e_name", v.get(2).toString());
                jsonobj.put("e_des", v.get(3).toString());
                 jsonobj.put("e_type", v.get(4).toString());
                 jsonobj.put("e_date", v.get(5).toString());
                 jsonobj.put("e_time", v.get(6).toString());
                 jsonobj.put("e_loc", v.get(7).toString());
                jsonarray.add(jsonobj);   
            }
            out.print(jsonarray);

            System.out.print(jsonarray);

        } else {
            out.println("failed");
        }
    }

// COMPANY SESSION
// company register

 if (key.equals("compreg")) {
        String na=request.getParameter("cnam");
        System.out.println(na);
        String we = request.getParameter("comeweb");
        String e = request.getParameter("cemail");
        String pa = request.getParameter("cpass");
        String ph = request.getParameter("cphon");
        String l = request.getParameter("clocatn");
        String in = request.getParameter("indus");
        String wh = request.getParameter("wrkhrs");
        String jb = request.getParameter("jobtype");
        String ed = request.getParameter("educlvl");
        String d = request.getParameter("cdes");
        String i=request.getParameter("image");
        System.out.println("IMAG==="+i);
        String sq = "INSERT into cmpy_reg(c_name,c_web,c_email,c_pass,c_phon,c_loc,c_ind,c_wrkhr,c_jobtyp,edlvl,c_des,c_img)values('"+na+"','"+we+"','" + e + "','" + pa + "','" + ph + "','"+l+"','" + in + "','" + wh + "','"+jb+"','"+ed+"','"+d+"','"+i+"')";
         String sq1 = "INSERT into login(u_id,l_name,l_pass,type,status)values((select max(c_id) from cmpy_reg),'" + e + "','" + pa + "','company','0')";
        int res = db.putData(sq);
        int res2 = db.putData(sq1);
        if (res > 0 && res2 > 0) {
            out.print("success");
        } else {
            out.print("failed");

        }
       
    }
 
 
// company_add_job

 if (key.equals("compaddjob")) {
        String id = request.getParameter("comp_id");
        String jt = request.getParameter("jtit");
         String jd = request.getParameter("jdes");
          String sa = request.getParameter("sal");
           String ty = request.getParameter("jobtype");
            String q = request.getParameter("quali");
             String dl = request.getParameter("ded");
        String sq5 = "INSERT into jobpost(u_id,j_title,j_des,j_typ,salary,qual,app_dedlin,status)values('"+id+"','"+jt+"','"+jd+"','"+ty+"','"+sa+"','"+q+"','"+dl+"','0')";
       System.out.println("EEE"+sq5);
        int res6 = db.putData(sq5);
        if (res6 > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }
 

 
 //comp_view_job
 
if (key.equals("comp_view_job")) {
    
     String id = request.getParameter("id");
        String str3 = "SELECT * FROM `jobpost` WHERE STATUS='0' AND `u_id`='"+id+"' ";
        Iterator itr = db.getData(str3).iterator();
        JSONArray jsonarray = new JSONArray();
        if (itr.hasNext()) {
            while (itr.hasNext()) {
                Vector v = (Vector) itr.next();
                JSONObject jsonobj = new JSONObject();
                jsonobj.put("j_id", v.get(0).toString());
                jsonobj.put("j_title", v.get(2).toString());
                jsonobj.put("j_des", v.get(3).toString());
                jsonobj.put("j_typ", v.get(4).toString());
                 jsonobj.put("salary", v.get(5).toString());
                 jsonobj.put("qual", v.get(6).toString());
                 jsonobj.put("dedlin", v.get(7).toString());
                jsonarray.add(jsonobj);   
            }
            out.print(jsonarray);

            System.out.print(jsonarray);

        } else {
            out.println("failed");
        }
    }

//comp_edit_job

 if (key.equals("compeditjob")) {
        String id = request.getParameter("comp_id");
        String jid = request.getParameter("job_id");
        String jt = request.getParameter("jtit");
         String jd = request.getParameter("jdes");
          String sa = request.getParameter("sal");
           String ty = request.getParameter("jobtype");
            String q = request.getParameter("quali");
             String dl = request.getParameter("ded");
        String sq5 = "UPDATE `jobpost` SET j_title='"+jt+"',j_des='"+jd+"',j_typ='"+ty+"',salary='"+sa+"',qual='"+q+"',app_dedlin='"+dl+"',status='0' WHERE j_id='"+jid+"'";
       System.out.println("EEE"+sq5);
        int res6 = db.putData(sq5);
        if (res6 > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }

//comp_del_job

if (key.equals("deljob")) {
        String  id=request.getParameter("jid");
        String sqll = "UPDATE jobpost SET status='2' WHERE j_id='"+id+"'";
                System.out.println(sqll);

        int resu = db.putData(sqll);
        if (resu > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }

//Compny home
//comp_view_streq

if (key.equals("comp_view_req")) {
     String  id=request.getParameter("cid");
     System.out.println(id);
        String str3 = "SELECT `jobpost`.*,`applied_jobs`.*, `stud_reg`.* FROM `jobpost`,`applied_jobs`,`stud_reg` WHERE `applied_jobs`.`j_id`=`jobpost`.`j_id` AND `applied_jobs`.`u_id`=`stud_reg`.`s_id` AND `jobpost`.`u_id`='"+id+"'";
        Iterator itr = db.getData(str3).iterator();
        JSONArray jsonarray = new JSONArray();
        if (itr.hasNext()) {
            while (itr.hasNext()) {
                Vector v = (Vector) itr.next();
                JSONObject jsonobj = new JSONObject();
                jsonobj.put("j_id", v.get(0).toString());
                jsonobj.put("cid", v.get(1).toString());
                jsonobj.put("j_title", v.get(2).toString());
                jsonobj.put("j_des", v.get(3).toString());
                jsonobj.put("j_typ", v.get(4).toString());
                jsonobj.put("salary", v.get(5).toString());
                jsonobj.put("qual", v.get(6).toString());
                jsonobj.put("dedlin", v.get(7).toString());
                jsonobj.put("j_status", v.get(8).toString());
                jsonobj.put("ap_id", v.get(9).toString());
                jsonobj.put("ap_uid", v.get(10).toString());
                jsonobj.put("ap_sid", v.get(11).toString());
                jsonobj.put("ap_jid", v.get(12).toString());
                 jsonobj.put("ap_stat", v.get(13).toString());
                 jsonobj.put("st_id", v.get(14).toString());
                jsonobj.put("st_name", v.get(15).toString());
                jsonobj.put("st_age", v.get(16).toString());
                jsonobj.put("st_email", v.get(17).toString());
                jsonobj.put("st_pass", v.get(18).toString());
                jsonobj.put("st_phn", v.get(19).toString());
                jsonobj.put("st_clg", v.get(20).toString());
                jsonobj.put("st_cour", v.get(21).toString());
                jsonobj.put("st_loc", v.get(22).toString());
                jsonobj.put("st_grad", v.get(23).toString());
                jsonobj.put("st_skills", v.get(24).toString());
                jsonobj.put("st_jobty", v.get(25).toString());
                jsonobj.put("st_jobpre", v.get(26).toString());
                 jsonobj.put("st_img", v.get(27).toString());
                 jsonobj.put("resume", v.get(28).toString());
                jsonarray.add(jsonobj);   
            }
            out.print(jsonarray);

            System.out.print(jsonarray);

        } else {
            out.println("failed");
        }
    }

//comp_rej_req

if (key.equals("comprejreq")) {
        String  id=request.getParameter("stu_id");
        String sqll = "UPDATE `applied_jobs` SET `status`='rejected' WHERE u_id='"+id+"'";
                System.out.println(sqll);

        int resu = db.putData(sqll);
        if (resu > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }

//comp_approve_req

if (key.equals("compapprreq")) {
        String  id=request.getParameter("stu_id");
        String sqll = "UPDATE `applied_jobs` SET `status`='approved' WHERE u_id='"+id+"'";
                System.out.println(sqll);

        int resu = db.putData(sqll);
        if (resu > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }

//comp send mail to student

 if (key.equals("getemail")) {
     String sid = request.getParameter("id");
        String st = "SELECT `s_email` FROM `stud_reg` WHERE `s_id`='"+sid+"'";
        Iterator it = db.getData(st).iterator();
        if (it.hasNext()) {
            Vector v = (Vector) it.next();
            String ress = v.get(3) + "#";
            out.print(ress);
            System.out.println("ss"+ress);
        } else {
            out.print("failed");
             System.out.println("No"+st);
        }
    }
 
 
// Comp_add_events

if (key.equals("compaddevent")) {
        String id = request.getParameter("comp_id");
        String na = request.getParameter("e_name");
         String de = request.getParameter("e_des");
          String ty = request.getParameter("e_type");
           String da = request.getParameter("e_date");
            String ti = request.getParameter("e_time");
             String lo = request.getParameter("location");
        String sq5 = "INSERT into events(c_id,e_name,e_des,e_type,e_date,e_time,e_loc)values('"+id+"','"+na+"','"+de+"','"+ty+"','"+da+"','"+ti+"','"+lo+"')";
       System.out.println("EEE"+sq5);
        int res6 = db.putData(sq5);
        if (res6 > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }




if (key.equals("comp_view_event")) {
    String  id=request.getParameter("cid");
        String str3 = "SELECT *FROM `events` WHERE c_id='"+id+"'";
        Iterator itr = db.getData(str3).iterator();
        JSONArray jsonarray = new JSONArray();
        if (itr.hasNext()) {
            while (itr.hasNext()) {
                Vector v = (Vector) itr.next();
                JSONObject jsonobj = new JSONObject();
                jsonobj.put("e_id", v.get(0).toString());
                jsonobj.put("cid", v.get(1).toString());
                jsonobj.put("e_name", v.get(2).toString());
                jsonobj.put("e_des", v.get(3).toString());
                 jsonobj.put("e_type", v.get(4).toString());
                 jsonobj.put("e_date", v.get(5).toString());
                 jsonobj.put("e_time", v.get(6).toString());
                 jsonobj.put("e_loc", v.get(7).toString());
                jsonarray.add(jsonobj);   
            }
            out.print(jsonarray);

            System.out.print(jsonarray);

        } else {
            out.println("failed");
        }
    }
//comp_profile
//if (key.equals("comp_profile")) {
//      String cid = request.getParameter("id");
//        String str3 = "SELECT *FROM `cmpy_reg` WHERE c_id='"+cid+"'";
//        Iterator itr = db.getData(str3).iterator();
//        JSONArray jsonarray = new JSONArray();
//        if (itr.hasNext()) {
//            while (itr.hasNext()) {
//                Vector v = (Vector) itr.next();
//                JSONObject jsonobj = new JSONObject();
//                jsonobj.put("cid", v.get(0).toString());
//                jsonobj.put("cname", v.get(1).toString());
//                jsonobj.put("cweb", v.get(2).toString());
//                jsonobj.put("cemail", v.get(3).toString());
//                jsonobj.put("cpass", v.get(4).toString());
//                jsonobj.put("cphon", v.get(5).toString());
//                jsonobj.put("cloc", v.get(6).toString());
//                jsonobj.put("cind", v.get(7).toString());
//                jsonobj.put("cwrkhr", v.get(8).toString());
//                jsonobj.put("cjobty", v.get(9).toString());
//                jsonobj.put("cedlvl", v.get(10).toString());
//                jsonobj.put("cdes", v.get(11).toString());
//                 jsonobj.put("cimg", v.get(12).toString());
//                jsonarray.add(jsonobj);   
//            }
//            out.print(jsonarray);
//
//            System.out.print(jsonarray);
//
//        } else {
//            out.println("failed");
//        }
//    }

 
if (key.equals("comp_profile")) {
    String cid = request.getParameter("id");
        String st = "SELECT *FROM `cmpy_reg` WHERE c_id='"+cid+"'";
        Iterator it = db.getData(st).iterator();
        if (it.hasNext()) {
            Vector v = (Vector) it.next();
            String ress = v.get(0) + "#" + v.get(1)+"#"+ v.get(2)+"#"+ v.get(3)+"#"+ v.get(4)+"#"+ v.get(5)+"#"+ v.get(6)+"#"+ v.get(7)+"#"+ v.get(8)+"#"+ v.get(9)+"#"+ v.get(10)+"#"+ v.get(11)+"#"+ v.get(12)+"#";
            out.print(ress);
            System.out.println("ss"+ress);
        } else {
            out.print("failed");
             System.out.println("No"+st);
        }
    }


//company edit profile

 if (key.equals("comp_edit_pro")) {
      String id=request.getParameter("comp_id");
        String na=request.getParameter("cnam");
        System.out.println(na);
        String we = request.getParameter("comeweb");
        String e = request.getParameter("cemail");
        String pa = request.getParameter("cpass");
        String ph = request.getParameter("cphon");
        String l = request.getParameter("clocatn");
        String in = request.getParameter("indus");
        String wh = request.getParameter("wrkhrs");
        String jb = request.getParameter("jobtype");
        String ed = request.getParameter("educlvl");
        String d = request.getParameter("cdes");
        String i=request.getParameter("image");
        System.out.println("IMAG==="+i);
        String sq5 = "UPDATE `cmpy_reg` SET c_name='"+na+"',c_web='"+we+"',c_email='"+e+"',c_pass='"+pa+"',c_phon='"+ph+"',c_loc='"+l+"',c_ind='"+in+"',c_wrkhr='"+wh+"',c_jobtyp='"+jb+"',edlvl='"+ed+"',c_des='"+d+"',c_img='"+i+"' WHERE c_id='"+id+"'";
       System.out.println("EEE"+sq5);
        int res6 = db.putData(sq5);
        if (res6 > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
       
    }

 

// ADMIN SECTION
//admin_view_comp
if (key.equals("admin_view_comp")) {
        String str3 = "SELECT *FROM `cmpy_reg`";
        Iterator itr = db.getData(str3).iterator();
        JSONArray jsonarray = new JSONArray();
        if (itr.hasNext()) {
            while (itr.hasNext()) {
                Vector v = (Vector) itr.next();
                JSONObject jsonobj = new JSONObject();
                jsonobj.put("cid", v.get(0).toString());
                jsonobj.put("cname", v.get(1).toString());
                jsonobj.put("cweb", v.get(2).toString());
                jsonobj.put("cemail", v.get(3).toString());
                jsonobj.put("cpass", v.get(4).toString());
                jsonobj.put("cphon", v.get(5).toString());
                jsonobj.put("cloc", v.get(6).toString());
                jsonobj.put("cind", v.get(7).toString());
                jsonobj.put("cwrkhr", v.get(8).toString());
                jsonobj.put("cjobty", v.get(9).toString());
                jsonobj.put("cedlvl", v.get(10).toString());
                jsonobj.put("cdes", v.get(11).toString());
                 jsonobj.put("cimg", v.get(12).toString());
                jsonarray.add(jsonobj);   
            }
            out.print(jsonarray);

            System.out.print(jsonarray);

        } else {
            out.println("failed");
        }
    }



//admin_view_stud
if (key.equals("admin_view_stud")) {
        String str3 = "SELECT *FROM `stud_reg`";
        Iterator itr = db.getData(str3).iterator();
        JSONArray jsonarray = new JSONArray();
        if (itr.hasNext()) {
            while (itr.hasNext()) {
                Vector v = (Vector) itr.next();
                JSONObject jsonobj = new JSONObject();
                jsonobj.put("st_id", v.get(0).toString());
                jsonobj.put("st_name", v.get(1).toString());
                jsonobj.put("st_age", v.get(2).toString());
                jsonobj.put("st_email", v.get(3).toString());
                jsonobj.put("st_pass", v.get(4).toString());
                jsonobj.put("st_phn", v.get(5).toString());
                jsonobj.put("st_clg", v.get(6).toString());
                jsonobj.put("st_cour", v.get(7).toString());
                jsonobj.put("st_loc", v.get(8).toString());
                jsonobj.put("st_grad", v.get(9).toString());
                jsonobj.put("st_skills", v.get(10).toString());
                jsonobj.put("st_jobty", v.get(11).toString());
                jsonobj.put("st_jobpre", v.get(12).toString());
                 jsonobj.put("st_img", v.get(13).toString());
                jsonarray.add(jsonobj);   
            }
            out.print(jsonarray);

            System.out.print(jsonarray);

        } else {
            out.println("failed");
        }
    }

//admin accept company
if (key.equals("acceptcomp")) {
        String  id=request.getParameter("comp_id");
        String sqll = "UPDATE login SET status='1' WHERE u_id='"+id+"'";
                System.out.println(sqll);

        int resu = db.putData(sqll);
        if (resu > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }


//admins_view feedback
if (key.equals("admin_view_feedback")) {
   
        String str3 = "SELECT *FROM `stud_feedback`";
        System.out.println(str3);
        Iterator itr = db.getData(str3).iterator();
        JSONArray jsonarray = new JSONArray();
        if (itr.hasNext()) {
            while (itr.hasNext()) {
                Vector v = (Vector) itr.next();
                JSONObject jsonobj = new JSONObject();
                jsonobj.put("f_id", v.get(0).toString());
                jsonobj.put("f_sub", v.get(4).toString());
                jsonobj.put("f_des", v.get(5).toString());
                jsonobj.put("rating", v.get(6).toString());
                jsonarray.add(jsonobj);   
            }
            out.print(jsonarray);

            System.out.print(jsonarray);

        } else {
            out.println("failed");
        }
    }
%>