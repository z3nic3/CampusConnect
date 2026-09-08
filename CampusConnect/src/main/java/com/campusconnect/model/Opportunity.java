package com.campusconnect.model;

import java.sql.Date;

public class Opportunity {
    private int oppId;
    private int companyId;
    private String title;
    private String type; // JOB or INTERNSHIP
    private String skillRequired;
    private String location;
    private String description;
    private Date postedDate;
    private String companyName;

    public Opportunity() {}

    public Opportunity(int oppId, int companyId, String title, String type, String skillRequired,
                        String location, String description, Date postedDate) {
        this.oppId = oppId;
        this.companyId = companyId;
        this.title = title;
        this.type = type;
        this.skillRequired = skillRequired;
        this.location = location;
        this.description = description;
        this.postedDate = postedDate;
    }

    public int getOppId() { return oppId; }
    public void setOppId(int oppId) { this.oppId = oppId; }

    public int getCompanyId() { return companyId; }
    public void setCompanyId(int companyId) { this.companyId = companyId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getSkillRequired() { return skillRequired; }
    public void setSkillRequired(String skillRequired) { this.skillRequired = skillRequired; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getPostedDate() { return postedDate; }
    public void setPostedDate(Date postedDate) { this.postedDate = postedDate; }
    
    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }
}
