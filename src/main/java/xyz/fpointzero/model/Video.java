package xyz.fpointzero.model;

import org.apache.ibatis.session.SqlSession;
import xyz.fpointzero.mapper.VideoMapper;
import xyz.fpointzero.util.MyBatisUtil;

public class Video {
    private String videoPath;
    private String coverPath;
    private String title;
    private String subtitle;
    private String likeNumber;

    public boolean search(){
        try (SqlSession sqlSession = MyBatisUtil.getSqlSessionFactory().openSession()) {
            VideoMapper mapper = sqlSession.getMapper(VideoMapper.class);
            Video video = null;
            video = mapper.getByTitle("%"+title+"%");
            if (video == null){
                return false;
            } else {
                setVideo(video);
                return true;
            }

        }catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private void setVideo(Video video) {
        this.videoPath = video.videoPath;
        this.coverPath = video.coverPath;
        this.title = video.title;
        this.subtitle = video.subtitle;
        this.likeNumber = video.likeNumber;
    }

    public String getVideoPath() {
        return videoPath;
    }

    public void setVideoPath(String videoPath) {
        this.videoPath = videoPath;
    }

    public String getCoverPath() {
        return coverPath;
    }

    public void setCoverPath(String coverPath) {
        this.coverPath = coverPath;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getLikeNumber() {
        return likeNumber;
    }

    public void setLikeNumber(String likeNumber) {
        this.likeNumber = likeNumber;
    }
}
