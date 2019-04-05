package com.wzm.zjob.params;

public class JobParam {
    private String positionName;

    private String companyName;

    private Double positionSalary;

    private String positionEdu;

    private Integer isValid;

    public String getPositionName() {
        return positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public Double getPositionSalary() {
        return positionSalary;
    }

    public void setPositionSalary(Double positionSalary) {
        this.positionSalary = positionSalary;
    }

    public String getPositionEdu() {
        return positionEdu;
    }

    public void setPositionEdu(String positionEdu) {
        this.positionEdu = positionEdu;
    }

    public Integer getIsValid() {
        return isValid;
    }

    public void setIsValid(Integer isValid) {
        this.isValid = isValid;
    }
}
