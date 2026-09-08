package com.campusconnect.model;

import java.sql.Date;

public class Application {

    private int appId;
    private int studentId;
    private int oppId;

    private String status; // PENDING, ACCEPTED, REJECTED

    private Date appliedDate;

    private String studentName;

    // Student profile details
    private String skills;
    private String education;
    private String resumePath;
    private String opportunityTitle;
    private String companyName;

 // --------------------------------------------------
 // OPPORTUNITY TITLE
 // --------------------------------------------------

 public String getOpportunityTitle() {
     return opportunityTitle;
 }

 public void setOpportunityTitle(String opportunityTitle) {
     this.opportunityTitle = opportunityTitle;
 }


 // --------------------------------------------------
 // COMPANY NAME
 // --------------------------------------------------

 public String getCompanyName() {
     return companyName;
 }

 public void setCompanyName(String companyName) {
     this.companyName = companyName;
 }


    // --------------------------------------------------
    // DEFAULT CONSTRUCTOR
    // --------------------------------------------------
    public Application() {
    }


    // --------------------------------------------------
    // CONSTRUCTOR
    // --------------------------------------------------
    public Application(int appId, int studentId, int oppId,
                       String status, Date appliedDate) {

        this.appId = appId;
        this.studentId = studentId;
        this.oppId = oppId;
        this.status = status;
        this.appliedDate = appliedDate;
    }


    // --------------------------------------------------
    // APP ID
    // --------------------------------------------------
    public int getAppId() {
        return appId;
    }

    public void setAppId(int appId) {
        this.appId = appId;
    }


    // --------------------------------------------------
    // STUDENT ID
    // --------------------------------------------------
    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }


    // --------------------------------------------------
    // OPPORTUNITY ID
    // --------------------------------------------------
    public int getOppId() {
        return oppId;
    }

    public void setOppId(int oppId) {
        this.oppId = oppId;
    }


    // --------------------------------------------------
    // STATUS
    // --------------------------------------------------
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    // --------------------------------------------------
    // APPLIED DATE
    // --------------------------------------------------
    public Date getAppliedDate() {
        return appliedDate;
    }

    public void setAppliedDate(Date appliedDate) {
        this.appliedDate = appliedDate;
    }


    // --------------------------------------------------
    // STUDENT NAME
    // --------------------------------------------------
    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }


    // --------------------------------------------------
    // SKILLS
    // --------------------------------------------------
    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }


    // --------------------------------------------------
    // EDUCATION
    // --------------------------------------------------
    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }


    // --------------------------------------------------
    // RESUME PATH
    // --------------------------------------------------
    public String getResumePath() {
        return resumePath;
    }

    public void setResumePath(String resumePath) {
        this.resumePath = resumePath;
    }
}