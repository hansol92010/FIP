package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Sboard;
import com.icia.web.model.SboardComment;
import com.icia.web.model.SboardLike;
import com.icia.web.model.SboardProductInfoNo;


@Repository("sboardDao")
public interface SboardDao {
	
	//총 스타일 수 조회 민정
		public int allStyleCount(Sboard sboard);
		
		//스타일게시물 리스트 민정
		public List<Sboard> allStyleList(Sboard sboard);
		
		//총 브랜드 별 수 조회 민정
		public int styleBrandCount(String brandCode);
		
		// 브랜드 별 상품 조회 민정
		public List<Sboard> styleBrandSelect(Sboard sboard);
		
		//****스타일 게시물 조회** 민정
		public Sboard sboardSelect(int sboardNo);
		
		//스타일 게시물 조회수 증가 민정
		public void sboardReadCountPlus(int sboardNo);
		

		/********************게시물 삭제***************************************/
		//***게시물 삭제*** 민정
		public int sboardDelete(int sboardNo);
		
		//해당 게시글에 있는 모든 좋아요 삭제 미지
		public int sboardLikeDelete(int sboardNo);
		
		//게시물 삭제시 모든 댓글 삭제
		public int styleAllReplyDelete(int sboardNo);
		
		//댓글조회
		public SboardComment styleAllReplySelect(int sboardNo);
		
		//스타일상세에서 상품 정보 삭제
		public int sboardProductDelete(int sboardNo);

		//게시물 등록(스타일 글쓰기페이지)이연 writeForm
		public int boardInsert(Sboard sBoard);
		
		//스타일 시퀀스 이연
		public int styleSeq(Sboard sboard);
		
		
		
		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		//댓글 리스트
		public List<SboardComment> styleReplyList(int sboardCommentNo);
		
		//댓글 등록
		public int styleReplyInsert(SboardComment sboardComent);
		
		//댓글 삭제
		public int styleReplyDelete(int sboardCommentNo);
		
		//댓글 조회
		public SboardComment styleReplySelect(int sboardCommentNo);
		
		
		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		//스타일 좋아요순 조회	(메인)용구
		public List<Sboard> sboardBest(Sboard sboard);
		
		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		//해당스타일에 내가 누른 좋아요 조회 미지
		public List<SboardLike> likeSelect(SboardLike sboardLike);
		
		//좋아요 눌렀는지 안눌렀는지 미지//1이 오면 좋아요 취소를 보여주고 0이면 좋아요를 보여주자
		public int likeCheck(SboardLike sboardLike);

		//좋아요 추가 미지
		public int likeInsert(SboardLike sboardLike);
		//좋아요 수 +1 업뎃
		public int likeUpUpdate(int sboardNo);
		
		//좋아요 삭제 미지
		public int likeDelete(SboardLike sboardLike);
		//좋아요 수 -1 업뎃
		public int likeDownUpdate(int sboardNo);
		
		//스타일게시글 상품정보 insert : 양진구
		public int sboardProductInfoNoInsert(SboardProductInfoNo sboardProductInfoNo);
		
		//스타일 상세 상품정보 조회
		public List<SboardProductInfoNo> sboardProductSelect(int sboardNo);
		
		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		//게시물 총 수 이연(관리자)
		public int boardListCount(Sboard sboard);
						

		//게시물 리스트 이연(관리자)
		public List<Sboard> boardList(Sboard sboard);
}
