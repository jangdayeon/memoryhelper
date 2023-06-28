package javabean;

import java.util.Date;
public class testBean {
	private Date Tid;
	private Date Twhen;
	private int Tscore;
	private long Ttesting;
	public Date getTid() {
		return Tid;
	}
	public void setTid(Date tid) {
		Tid = tid;
	}
	public Date getTwhen() {
		return Twhen;
	}
	public void setTwhen(Date twhen) {
		Twhen = twhen;
	}
	public int getTscore() {
		return Tscore;
	}
	public void setTscore(int tscore) {
		Tscore = tscore;
	}
	public long getTtesting() {
		return Ttesting;
	}
	public void setTtesting(long ttesting) {
		Ttesting = ttesting; //분단위로 연산해서 setting
	}
	
	
}
