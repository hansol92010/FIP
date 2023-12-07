package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.common.util.FileUtil;
import com.icia.web.dao.SboardDao;
import com.icia.web.dao.UserDao;
import com.icia.web.model.Product;
import com.icia.web.model.Sboard;
import com.icia.web.model.SboardComment;
import com.icia.web.model.SboardLike;
import com.icia.web.model.SboardProductInfoNo;

@Service("sboardService")
public class SboardService {
	
	private static Logger logger = LoggerFactory.getLogger(SboardService.class);
	
	@Autowired
	private SboardDao sboardDao;
	
	//회원정보 가져오기
	@Autowired
	private UserDao userDao;

	//썸네일 저장 경로
	@Value("#{env['upload.save.dir1']}")
	private String UPLOAD_SAVE_DIR_THUM;

	//상세 이미지 저장 경로
	@Value("#{env['upload.save.dir2']}")
	private String UPLOAD_SAVE_DIR_DETAIL;
	
	//리스트 이미지 저장 경로
	@Value("#{env['upload.save.dir3']}")
	private String UPLOAD_SAVE_DIR_LIST;
	
	
	
	//총 스타일 수 조회 민정
		public int allStyleCount(Sboard sboard)
		{
			int count = 0;
			
			try
			{
				
				count = sboardDao.allStyleCount(sboard);
				
				if(count < 0)
				{
					logger.debug("[sboardService] allStyleCount count : " + count);
				}
				
			}
			catch(Exception e)
			{
				logger.error("[SboardService] allStyleCount Exception", e);
			}
			
			return count;
		}
		
		//스타일 게시판 조회 민정
		public List<Sboard> allStyleList(Sboard sboard)
		{
			List<Sboard> list = null;
			
			try
			{
				list = sboardDao.allStyleList(sboard);
			}
			catch(Exception e)
			{
				logger.error("[SboardService] allStyleList Exception", e);
			}
			
			return list;
		}

		//브랜드 별 총 스타일 수 민정
		public int styleBrandCount(String brandCode)
		{
			int count = 0;
			
			try
			{
				count = sboardDao.styleBrandCount(brandCode);
			}
			catch(Exception e)
			{
				logger.error("[sboardService] styleBrandCount Exception", e);
			}
			return count;
		}
		
		//브랜드 별 스타일 조회 민정
		public List<Sboard> styleBrandSelect(Sboard sboard)
		{
			List<Sboard> list = null;
			
			try
			{
				list = sboardDao.styleBrandSelect(sboard);
			}
			catch(Exception e)
			{
				logger.error("[sboardService] styleBrandSelect Exception ",e);
			}
			
			return list;
		}
		
		//스타일 게시물 조회 민정
		public Sboard sboardSelect(int sboardNo)
		{
			Sboard sboard = null;
			
			try
			{
				sboard = sboardDao.sboardSelect(sboardNo);
			}
			catch(Exception e)
			{
				logger.error("[SboardService] sboardSelect Exception", e);
			}
			return sboard;
		}
			
		//스타일 게시물 보기(조회수 증가) 민정
		public Sboard sboardView(int sboardNo)
		{
			Sboard sboard = null;
			
			try
			{
				sboard = sboardDao.sboardSelect(sboardNo);
				
				if(sboard != null)
				{
					//조회수 증가
					sboardDao.sboardReadCountPlus(sboardNo);
					
				}
			}
			catch(Exception e)
			{
				logger.error("[SboardService] sboardView Exception", e);
			}
			
			return sboard;
		}

		
		//게시물 삭제시 댓글 삭제
		public int styleAllReplyDelete(int sboardNo)
		{
			int count = 0;
			
			try
			{
				count = sboardDao.styleAllReplyDelete(sboardNo);
			}
			catch(Exception e)
			{
				logger.error("[SboardService] styleAllReplyDelete Exception", e);
			}
			
			return count;
		}
		
		
		//스타일 게시물 삭제민정
		@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
		public int sboardDelete(int sboardNo) throws Exception
		{
			int count = 0;
			
			Sboard sboard = sboardDao.sboardSelect(sboardNo);
			SboardLike sboardLike = new SboardLike();
			List<SboardLike> list = sboardDao.likeSelect(sboardLike);
			SboardComment sboardComment = sboardDao.styleAllReplySelect(sboardNo);

			if(sboard != null)
			{
				count = sboardDao.sboardDelete(sboardNo);
				
				if(count > 0)
				{					
					
					if(sboardComment != null)
					{	
						if(sboardDao.styleAllReplyDelete(sboardNo) > 0)
						{
							//좋아요 여부
							if(list != null)
							{
								sboardDao.sboardLikeDelete(sboardNo);
								
							}
						
							//이미지 삭제
			                FileUtil.deleteFile(UPLOAD_SAVE_DIR_THUM + FileUtil.getFileSeparator() + sboardNo + ".jpg");
							
							//상품 삭제
			                sboardDao.sboardProductDelete(sboardNo);
						}

					}
					else
					{
						//좋아요 여부
						if(list != null)
						{
							sboardDao.sboardLikeDelete(sboardNo);
							
						}
						
						//이미지 삭제
		                FileUtil.deleteFile(UPLOAD_SAVE_DIR_THUM + FileUtil.getFileSeparator() + sboardNo + ".jpg");
						
						//상품 삭제
		                sboardDao.sboardProductDelete(sboardNo);
					}
				
				
				}
				
			}
			
			
			return count;
		}
		
		
		//style 글쓰기게시판 이연 writeForm
		
		public int boardInsert(Sboard sboard) 
		{	
			int count = sboardDao.boardInsert(sboard);  
			
			return count;
		}
		//스타일 시퀀스 조회
		public int styleSeq(Sboard sboard)
		{
			int count = 0;
			
			try
			{
				count = sboardDao.styleSeq(sboard);
			}
			catch(Exception e)
			{
				logger.error("[sboardService] styleSeq Exception", e);
			}
			return count;
		}
			

		
			//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			
			//판매량 높은 상품 조회	용구
			public List<Sboard> sboardBest(Sboard sboard)
			{
				List<Sboard> list = null;
				try
				{
					list = sboardDao.sboardBest(sboard);
				}
				catch(Exception e)
				{
					logger.error("[SboardService] sboardBest Exception", e);
				}
				
				return list;
			}
			
			//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			
			//댓글 리스트
			public List<SboardComment> styleReplyList(int sboardCommentNo)
			{
				List<SboardComment> list = null;
				
				try
				{
					list = sboardDao.styleReplyList(sboardCommentNo);
				}
				catch(Exception e)
				{
					logger.error("[SboardService] styleReplyList Exception", e);
				}
				
				
				return list;
			}
			
			//댓글 등록
			public int styleReplyInsert(SboardComment sboardComent)
			{
				int count = 0;
				
				try
				{
					count = sboardDao.styleReplyInsert(sboardComent);
				}
				catch(Exception e)
				{
					logger.error("[SboardService] styleReplyInsert Exception", e);
				}
				
				return count;
			}
			
			//댓글 삭제
			public int styleReplyDelete(int sboardCommentNo)
			{
				int count = 0;
				
				SboardComment sboardComment = sboardDao.styleReplySelect(sboardCommentNo);
				
				if(sboardComment != null)
				{
					count = sboardDao.styleReplyDelete(sboardCommentNo);
					
					
				}

				return count;
			}
			
			//댓글 조회
			public SboardComment styleReplySelect(int sboardCommentNo)
			{
				SboardComment sboardComment = new SboardComment();
				
				try
				{
					
					sboardComment = sboardDao.styleReplySelect(sboardCommentNo);
				}
				catch(Exception e)
				{
					logger.error("[SboardService] styleReplySelect Exception", e);
				}
				
				return sboardComment;
			}
			
			//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			
			//내 아이디로 누른 좋아요 있는지 확인용 미지
			public List<SboardLike> likeSelect(SboardLike sboardLike)
			{
				List<SboardLike> list = null;
				
				try
				{
					list = sboardDao.likeSelect(sboardLike);
				}
				catch(Exception e)
				{
					logger.error("[sboardService] likeSelect Exception", e);
				}
				
				return list;
				
			}
		
			//좋아요 눌렀는지 안눌렀는지 체크(셀렉트 카운트) 미지
			public int likeCheck(SboardLike sboardLike)
			{
				int count = 0;
				
				try 
				{
					count = sboardDao.likeCheck(sboardLike);
				}
				catch(Exception e)
				{
					logger.error("[sboardService] likeCheck Exception", e);
				}
				
				return count;
			}

			
			//좋아요 인서트 미지
			public int likeInsert(SboardLike sboardLike)
			{
				int count = 0;
				
				try
				{
					count = sboardDao.likeInsert(sboardLike);
				}
				catch(Exception e)
				{
					logger.error("[sboardService] likeInsert Exception", e);
				}
				return count;
			}
			
			//좋아요 +1 미지
			public int likeUpUpdate(int sboardNo)
			{
				int count= 0;
				
				try
				{
					count = sboardDao.likeUpUpdate(sboardNo);
				}
				catch(Exception e)
				{
					logger.error("[sboardService] likeInsert Exception", e);
				}
				return count;
			}
		
			//좋아요 삭제 미지
			public int likeDelete(SboardLike sboardLike)
			{
				int count = 0;
				
				try
				{
					count = sboardDao.likeDelete(sboardLike);
				}
				catch(Exception e)
				{
					logger.error("[sboardService] likeInsert Exception", e);
				}
				return count;
			}
			
			//좋아요 -1 미지
			public int likeDownUpdate(int sboardNo)
			{
				int count= 0;
				
				try
				{
					count = sboardDao.likeDownUpdate(sboardNo);
				}
				catch(Exception e)
				{
					logger.error("[sboardService] likeInsert Exception", e);
				}
				
				return count;
			}	
		
		//sboard게시글 등록후 게시글에 들어갈 상품정보 insert : 양진구
		public int sboardProductInfoNo(SboardProductInfoNo param) 
		{
			int count = 0;
			
			try {
				count = sboardDao.sboardProductInfoNoInsert(param);
			}catch(Exception e) {
				logger.error("[sboardService] sboardProductInfoNo Exception", e);
			}
			return count;
		}
		
		//스타일 상세에서 상품 불러오기
		public List<SboardProductInfoNo> sboardProductSelect(int sboardNo)
		{
			List<SboardProductInfoNo> list = null;
			
			try
			{
				list = sboardDao.sboardProductSelect(sboardNo);
			}
			catch(Exception e)
			{
				logger.error("[sboardService] sboardProductInfoNoSelect Exception", e);
			}
			
			return list;
		}
		
		//관리자 게시물 총 수 이연
		public int boardListCount(Sboard sboard)
		{
			int count = 0;
			
			try
			{
				count = sboardDao.boardListCount(sboard);
			}
			catch(Exception e)
			{
				logger.error("[SboardService]boardListCount Exception", e);
			}
			
			return count;
		}
		
		//게시물 리스트 이연 ,관리자
		public List<Sboard> boardList(Sboard sboard)
		{
			List<Sboard> list = null;
			
			try
			{
				list = sboardDao.boardList(sboard);
				
				logger.debug("=============================");
				logger.debug("=============================");
				logger.debug("=============================");
				logger.debug("=============================");
				logger.debug("=============================");
				logger.debug("=============================");
			}
			catch(Exception e)
			{
				logger.error("[HiBoardService] boardList Exception", e);
			}
			
			return list;
		}	
}
