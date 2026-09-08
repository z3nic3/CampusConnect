package com.campusconnect.model;

public class Company {

    private int companyId;
    private int userId;

    private String companyName;
    private String industry;
    private String description;
    private String location;
    private String website;
    private String companyEmail;
    private String contactNumber;
    private String logoPath;
    private Integer foundedYear;
    private String companySize;
    private String linkedinUrl;

    public Company() {
    }

    public Company(int companyId, int userId, String companyName,
                   String industry, String description, String location,
                   String website, String companyEmail,
                   String contactNumber, String logoPath,
                   Integer foundedYear, String companySize,
                   String linkedinUrl) {

        this.companyId = companyId;
        this.userId = userId;
        this.companyName = companyName;
        this.industry = industry;
        this.description = description;
        this.location = location;
        this.website = website;
        this.companyEmail = companyEmail;
        this.contactNumber = contactNumber;
        this.logoPath = logoPath;
        this.foundedYear = foundedYear;
        this.companySize = companySize;
        this.linkedinUrl = linkedinUrl;
    }

    public int getCompanyId() {
        return companyId;
    }

    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getCompanyEmail() {
        return companyEmail;
    }

    public void setCompanyEmail(String companyEmail) {
        this.companyEmail = companyEmail;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getLogoPath() {
        return logoPath;
    }

    public void setLogoPath(String logoPath) {
        this.logoPath = logoPath;
    }

    public Integer getFoundedYear() {
        return foundedYear;
    }

    public void setFoundedYear(Integer foundedYear) {
        this.foundedYear = foundedYear;
    }

    public String getCompanySize() {
        return companySize;
    }

    public void setCompanySize(String companySize) {
        this.companySize = companySize;
    }

    public String getLinkedinUrl() {
        return linkedinUrl;
    }

    public void setLinkedinUrl(String linkedinUrl) {
        this.linkedinUrl = linkedinUrl;
    }
}