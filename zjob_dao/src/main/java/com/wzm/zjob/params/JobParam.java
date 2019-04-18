package com.wzm.zjob.params;

public class JobParam {
    private String positionName;

    private String companyName;

    private Double positionSalaryStart;
    private Double positionSalaryEnd;

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

    public Double getPositionSalaryStart() {
        return positionSalaryStart;
    }

    public void setPositionSalaryStart(Double positionSalaryStart) {
        this.positionSalaryStart = positionSalaryStart;
    }

    public Double getPositionSalaryEnd() {
        return positionSalaryEnd;
    }

    public void setPositionSalaryEnd(Double positionSalaryEnd) {
        this.positionSalaryEnd = positionSalaryEnd;
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
