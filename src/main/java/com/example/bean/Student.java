package com.example.bean;

/**
 * 数据封装类
 * 
 */
public class Student {
	
	private String sid;
	private String sname;
	private String age;

    public String getSid() {
        return sid;
    }
    public void setSid(String sid) {
        this.sid = sid;
    }
    public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}

    @Override
    public String toString() {
        return "Student{" +
                "sid='" + sid + '\'' +
                ", sname='" + sname + '\'' +
                ", age='" + age + '\'' +
                '}';
    }

    public Student() {
    }

    public Student(String sid, String sname, String age) {
        this.sid = sid;
        this.sname = sname;
        this.age = age;
    }


}
