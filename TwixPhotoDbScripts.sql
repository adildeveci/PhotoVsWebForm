USE [master]
GO
/****** Object:  Database [twixphoto]    Script Date: 15.05.2016 20:13:54 ******/
CREATE DATABASE [twixphoto] ON  PRIMARY 
( NAME = N'twixphoto', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\twixphoto.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'twixphoto_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\twixphoto_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [twixphoto] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [twixphoto].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [twixphoto] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [twixphoto] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [twixphoto] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [twixphoto] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [twixphoto] SET ARITHABORT OFF 
GO
ALTER DATABASE [twixphoto] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [twixphoto] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [twixphoto] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [twixphoto] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [twixphoto] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [twixphoto] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [twixphoto] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [twixphoto] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [twixphoto] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [twixphoto] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [twixphoto] SET  DISABLE_BROKER 
GO
ALTER DATABASE [twixphoto] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [twixphoto] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [twixphoto] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [twixphoto] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [twixphoto] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [twixphoto] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [twixphoto] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [twixphoto] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [twixphoto] SET  MULTI_USER 
GO
ALTER DATABASE [twixphoto] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [twixphoto] SET DB_CHAINING OFF 
GO
USE [twixphoto]
GO
/****** Object:  StoredProcedure [dbo].[editProfil]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[editProfil]
@kullaniciId int,	@kullaniciAdi nvarchar(20),@ad nvarchar(15), @soyad nvarchar(15), @hakkinda nvarchar(250),@profilPhotoUrl nvarchar(50)
AS
BEGIN
	update kullanicilar set kullaniciAdi=@kullaniciAdi, ad=@ad,soyad=@soyad,hakkinda=@hakkinda, profilPhotoUrl=@profilPhotoUrl
	where kullaniciId=@kullaniciId
END


GO
/****** Object:  StoredProcedure [dbo].[emailDegistir]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[emailDegistir]
	@kullaniciId int, @email nvarchar(50),@sonuc bit OUTPUT
AS
BEGIN
	 
	SET NOCOUNT ON;
	--kullanıcı email bilgisini güncellemek istediğinde

	--bu emaili kullanan kullanıcı sayısını al
  declare @emailSayisi int
  select @emailSayisi=COUNT(*) from kullanicilar where email=@email

  --eğer bu emaili başka kullanıcı kullanmıyorsa
  if(@emailSayisi=0)
    begin
	 --kullanıcının email bilgisini güncelle
     update kullanicilar set email=@email where kullaniciId=@kullaniciId
	--sonucu degisti olarak bildir
	 SET  @sonuc=1
    end
  else
     begin
      --sonucun degismediğini bildir 
      set @sonuc=0
     end
   

END

GO
/****** Object:  StoredProcedure [dbo].[favlaBirak]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[favlaBirak] 
	@kullaniciId int,
	@gonderiId int,
	@sonuc bit OUTPUT

AS
BEGIN
    --bi gönderiyi favladığında son durumu döndürcek
    DECLARE @count int
	select @count= COUNT(*) from favoriGonderiler 
	where kullaniciId=@kullaniciId and gonderiId=@gonderiId
	--zaten favori ise bunu favlıktan çıkar
	IF @Count!=0
	   begin
	    delete from favoriGonderiler 
	    where kullaniciId=@kullaniciId and gonderiId=@gonderiId
	    SET  @sonuc=0
	   end
	--favorilerinde yoksa favorilerine ekle
	else
	   begin
	     insert into favoriGonderiler(kullaniciId,gonderiId,favoriTarihi) values(@kullaniciId,@gonderiId, GETDATE())
	     SET  @sonuc=1
	   end
END


GO
/****** Object:  StoredProcedure [dbo].[getBildirim]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getBildirim] 
	@kullaniciId int, @topCount int
AS
BEGIN 
	SET NOCOUNT ON;
select top(@topCount) b.*, k.kullaniciAdi,k.profilPhotoUrl from bildirimler b
join kullanicilar k on k.kullaniciId=b.kullaniciIdBildiren
where b.kullaniciIdBildirilen=@kullaniciId
order by b.bildirimId desc
END


GO
/****** Object:  StoredProcedure [dbo].[getExpressBegeniSayisi]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getExpressBegeniSayisi]
@gonderiId int, @begeniSagSol bit, @sonuc int output
AS
BEGIN  
if(@begeniSagSol=0) 
    begin
    declare @al int
	select @al=solBegeniSayisi from gonderiler where gonderiId=@gonderiId 
	set @sonuc=@al
    end
else
    begin
	select @al=sagBegeniSayisi from gonderiler where gonderiId=@gonderiId 
    set @sonuc=@al
    end
END


GO
/****** Object:  StoredProcedure [dbo].[getGonderilerDunyaCapinda]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getGonderilerDunyaCapinda] 
@kullaniciId int ,@topCount int
AS
BEGIN  
--gonderi bilgilerini getir
select top(@topCount) 
k.kullaniciId, k.kullaniciAdi, k.profilPhotoUrl,
g.gonderiId,  g.aciklama,  g.etiketSol,
ksol.kullaniciAdi as [etiketSolKullaniciAdi],
ksag.kullaniciAdi as [etiketSagKullaniciAdi],
g.etiketSag,   g.foto1url, g.foto2url, g.gonderiTarihi, g.gonderiTuru, g.sagBegeniSayisi,g.solBegeniSayisi 
,b.begeniSolSag,
f.kullaniciId [favlayanKullaniciId]
from gonderiler g 
--gonderinin kullanıcı bilgilerini getir ve varsa etiket ve fav bilgilerini getirt
left join kullanicilar k on k.kullaniciId=g.kullaniciId
left join kullanicilar ksol on g.etiketSol=ksol.kullaniciId
left join kullanicilar ksag on g.etiketSag=ksag.kullaniciId 
left join begeniler b on b.gonderiId=g.gonderiId and b.kullaniciId=@kullaniciId
left join favoriGonderiler f on f.gonderiId=g.gonderiId and f.kullaniciId=@kullaniciId
order by g.gonderiId desc
END


GO
/****** Object:  StoredProcedure [dbo].[getGonderilerEtiket]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getGonderilerEtiket] 
@kullaniciId int, @kullaniciIdAktif  int
--aktifkullanıcıId istekte bulunan kullanıcıyı temsil etmekte. favlama ve beğeni bilgisini buna dikkate alarak yap
--aynı zamanda aktif kullanıcı ıd kullanıcııd ye de eşit olabilir ozaman adam kendi profiline bakıyo demektir
AS
BEGIN  
--gonderi bilgilerini getir
select  
k.kullaniciId, k.kullaniciAdi, k.profilPhotoUrl,
g.gonderiId,  g.aciklama,  g.etiketSol,
ksol.kullaniciAdi as [etiketSolKullaniciAdi],
ksag.kullaniciAdi as [etiketSagKullaniciAdi],
g.etiketSag,   g.foto1url, g.foto2url, g.gonderiTarihi, g.gonderiTuru, g.sagBegeniSayisi,g.solBegeniSayisi 
,b.begeniSolSag
,f.kullaniciId [favlayanKullaniciId] 
from gonderiler g 
--gonderinin kullanıcı bilgilerini getir ve varsa etiket ve fav bilgilerini getirt
left join kullanicilar k on k.kullaniciId=g.kullaniciId
left join kullanicilar ksol on g.etiketSol=ksol.kullaniciId
left join kullanicilar ksag on g.etiketSag=ksag.kullaniciId
--aktifkullanıcının beğeni durumunu getir 
left join begeniler b on b.gonderiId=g.gonderiId and b.kullaniciId=@kullaniciIdAktif
--aktifkullanıcının favori durumunu getir
left join favoriGonderiler f on f.gonderiId=g.gonderiId and f.kullaniciId=@kullaniciIdAktif
--sadece etiketlendiği gönderiler
where g.etiketSag=@kullaniciId or g.etiketSol=@kullaniciId
order by g.gonderiId desc
END


GO
/****** Object:  StoredProcedure [dbo].[getGonderilerFavori]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[getGonderilerFavori] 
@kullaniciId int, @kullaniciIdAktif  int, @topCount int
--aktifkullanıcıId istekte bulunan kullanıcıyı temsil etmekte. favlama ve beğeni bilgisini buna dikkate alarak yap
--aynı zamanda aktif kullanıcı ıd kullanıcııd ye de eşit olabilir ozaman adam kendi profiline bakıyo demektir
AS
BEGIN  
--gonderi bilgilerini getir
select top(@topCount) 
k.kullaniciId, k.kullaniciAdi, k.profilPhotoUrl,
g.gonderiId,  g.aciklama,  g.etiketSol,
ksol.kullaniciAdi as [etiketSolKullaniciAdi],
ksag.kullaniciAdi as [etiketSagKullaniciAdi],
g.etiketSag,   g.foto1url, g.foto2url, g.gonderiTarihi, g.gonderiTuru, g.sagBegeniSayisi,g.solBegeniSayisi 
,b.begeniSolSag
,f.kullaniciId [favlayanKullaniciId] 
from gonderiler g 
--gonderinin kullanıcı bilgilerini getir ve varsa etiket ve fav bilgilerini getirt
left join kullanicilar k on k.kullaniciId=g.kullaniciId
left join kullanicilar ksol on g.etiketSol=ksol.kullaniciId
left join kullanicilar ksag on g.etiketSag=ksag.kullaniciId 
--aktifkullanıcının beğeni durumunu getir
left join begeniler b on b.gonderiId=g.gonderiId and b.kullaniciId=@kullaniciIdAktif
--aktifkullanıcının favori durumunu getir
join favoriGonderiler f on f.gonderiId=g.gonderiId and f.kullaniciId=@kullaniciIdAktif
order by g.gonderiId desc
END


GO
/****** Object:  StoredProcedure [dbo].[getGonderilerTakipEttiklerim]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[getGonderilerTakipEttiklerim] 
@kullaniciId int, @topCount int
AS
BEGIN  
--gonderi bilgilerini getir
select top(@topCount) 
k.kullaniciId, k.kullaniciAdi, k.profilPhotoUrl,
g.gonderiId,  g.aciklama,  g.etiketSol,
ksol.kullaniciAdi as [etiketSolKullaniciAdi],
ksag.kullaniciAdi as [etiketSagKullaniciAdi],
g.etiketSag,   g.foto1url, g.foto2url, g.gonderiTarihi, g.gonderiTuru, g.sagBegeniSayisi,g.solBegeniSayisi 
,b.begeniSolSag,
f.kullaniciId [favlayanKullaniciId]
from gonderiler g 
--gonderinin kullanıcı bilgilerini getir ve varsa etiket ve fav bilgilerini getirt
left join kullanicilar k on k.kullaniciId=g.kullaniciId
left join kullanicilar ksol on g.etiketSol=ksol.kullaniciId
left join kullanicilar ksag on g.etiketSag=ksag.kullaniciId 
left join begeniler b on b.gonderiId=g.gonderiId and b.kullaniciId=@kullaniciId
left join favoriGonderiler f on f.gonderiId=g.gonderiId and f.kullaniciId=@kullaniciId
where g.kullaniciId in (select takipEdilenId from takiplesme t2 where t2.takipEdenId=@kullaniciId )

order by g.gonderiId desc
END


GO
/****** Object:  StoredProcedure [dbo].[getGonderilerTumu]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getGonderilerTumu] 
@kullaniciId int, @kullaniciIdAktif  int, @topCount int
--aktifkullanıcıId istekte bulunan kullanıcıyı temsil etmekte. favlama ve beğeni bilgisini buna dikkate alarak yap
--aynı zamanda aktif kullanıcı ıd kullanıcııd ye de eşit olabilir ozaman adam kendi profiline bakıyo demektir
AS
BEGIN  
--bir profile ait tüm gonderi bilgilerini getir etiketlenile. favlar şimdilik yok
select  top(@topCount)
k.kullaniciId, k.kullaniciAdi, k.profilPhotoUrl,
g.gonderiId,  g.aciklama,  g.etiketSol,
ksol.kullaniciAdi as [etiketSolKullaniciAdi],
ksag.kullaniciAdi as [etiketSagKullaniciAdi],
g.etiketSag,   g.foto1url, g.foto2url, g.gonderiTarihi, g.gonderiTuru, g.sagBegeniSayisi,g.solBegeniSayisi 
,b.begeniSolSag
,f.kullaniciId [favlayanKullaniciId] 
from gonderiler g 
--gonderinin kullanıcı bilgilerini getir ve varsa etiket ve fav bilgilerini getirt
left join kullanicilar k on k.kullaniciId=g.kullaniciId
left join kullanicilar ksol on g.etiketSol=ksol.kullaniciId
left join kullanicilar ksag on g.etiketSag=ksag.kullaniciId 
--aktifkullanıcının beğeni durumunu getir
left join begeniler b on b.gonderiId=g.gonderiId and b.kullaniciId=@kullaniciIdAktif
--aktifkullanıcının favori durumunu getir
left join favoriGonderiler f on f.gonderiId=g.gonderiId and f.kullaniciId=@kullaniciIdAktif
where g.kullaniciId=@kullaniciId or g.etiketSag=@kullaniciId or g.etiketSol=@kullaniciId 
order by g.gonderiId desc
END


GO
/****** Object:  StoredProcedure [dbo].[getProfilxBilgi]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProfilxBilgi] 
	 @kullaniciId int , @kullaniciIdAktif int
AS
BEGIN
	select k.*, t.takipEdenId from kullanicilar k
left join takiplesme t on t.takipEdilenId=k.kullaniciId and t.takipEdenId=@kullaniciIdAktif
where  k.kullaniciId=@kullaniciId
END


GO
/****** Object:  StoredProcedure [dbo].[gonderiSil]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gonderiSil]
	@gonderiId int
AS
BEGIN
--gonderiler tablosundan kaydı sil
 delete from gonderiler where gonderiId=@gonderiId
 --o gonderiye ait tüm beğenileri sil
 delete from begeniler where gonderiId=@gonderiId
 --bu gönderiyle ilgili tüm bildirimleri sil
 delete from bildirimler where bildirimKey=@gonderiId and (bildirimTuru='begeni' or bildirimTuru='favori')  
END


GO
/****** Object:  StoredProcedure [dbo].[likeSolSag]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[likeSolSag]
	 @kullaniciId int, @gonderiId int , @begeniSolSag bit, 
	@sonuc bit OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    
    --önce daha önce beğenmişmi bak 
   
	declare @oncekiBegeni bit
	
	select  @oncekiBegeni=begeniSolSag from begeniler 
	where gonderiId=@gonderiId and kullaniciId=@kullaniciId
	
	
	--beğendiği bi gönderiyi tekrar beğene basarak beğenmekten vazgeçti kaydını sil
	 if( @oncekiBegeni=@begeniSolSag)
	 begin
	    delete from begeniler
	    where gonderiId=@gonderiId and kullaniciId=@kullaniciId
	    --
	    SET  @sonuc=null
	 end
	--bu sefer diğer fotoyu beğendi update yap
	else if( @oncekiBegeni!=@begeniSolSag)
      begin
         update begeniler set begeniSolSag=@begeniSolSag , begeniTarihi=GETDATE()
         where gonderiId=@gonderiId and kullaniciId=@kullaniciId  
         SET  @sonuc=@begeniSolSag
      end 
      --ilk defa beğeniyorsa direk beğeniler tablosuna ekle
	else
	 begin
	      insert into begeniler(kullaniciId,gonderiId,begeniSolSag,begeniTarihi) values (@kullaniciId,@gonderiId,@begeniSolSag,GETDATE())
	      SET  @sonuc=@begeniSolSag    
	 end
	
END


GO
/****** Object:  StoredProcedure [dbo].[searchUser]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[searchUser]
@kullaniciId int, @arama nvarchar(50), @topCount int
AS
BEGIN

select  top(@topCount)
k.kullaniciId,k.kullaniciAdi, k.ad, k.soyad,k.hakkinda,k.profilPhotoUrl, t.takipEdenId 
 from kullanicilar k
left join takiplesme t on t.takipEdilenId=k.kullaniciId and t.takipEdenId=@kullaniciId 
where k.kullaniciAdi like '%'+ @arama +'%' or k.ad like '%'+@arama +'%' or k.soyad like '%'+@arama +'%' or k.hakkinda like '%'+@arama +'%'

END


GO
/****** Object:  StoredProcedure [dbo].[sifreDegistir]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sifreDegistir]
	@kullaniciId int,@mevcutSifre nvarchar(50), @yeniSifre nvarchar(50),@sonuc bit OUTPUT
AS
BEGIN
	 
	SET NOCOUNT ON;
	declare @eskiSifre nvarchar(50)
    select @eskiSifre=sifre from kullanicilar where kullaniciId=@kullaniciId
	
	--eğer girilen mevcur şifre kendi şifresi ile eşlesiyorsa
	if(@eskiSifre=@mevcutSifre)
	 begin 
	   --güncelle
	   update kullanicilar set sifre=@yeniSifre where kullaniciId=@kullaniciId
	   SET  @sonuc=1
	 end

	 --eğer sifre eslesmiyorsa degisme
	else
	 begin 
	 SET  @sonuc=0
	 end
END

GO
/****** Object:  StoredProcedure [dbo].[sikayetEt]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sikayetEt]
 @kullaniciId int, @gonderiId int
AS
BEGIN 
--gonderiler sikayet edecegiz
declare @sikayetSayisi int 
--bu kullanıcının bu gonderiyle ilgili sikayet sayisina bak
select @sikayetSayisi=COUNT(*) from sikayetler where kullaniciId=@kullaniciId and gonderiId=@gonderiId
--eğer bir daha once hic sikayet etmemise kayıtı ekle sikayeti varsa bisey yapma
if(@sikayetSayisi=0)
   begin
           INSERT INTO [dbo].[sikayetler]
           ([kullaniciId]
           ,[gonderiId]
           ,[sikayetTarihi])
            VALUES
           (@kullaniciId
           ,@gonderiId	
           ,GETDATE())
        
    end
end
GO
/****** Object:  StoredProcedure [dbo].[takipEtBirak]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[takipEtBirak] 
	@kullaniciId int,
	@takipEdilenId int,
	@sonuc bit OUTPUT

AS
BEGIN
    --birine takip isteği attığımız zaman son durumu döndürecek
    DECLARE @count int
	select @count= COUNT(*) from takiplesme t 
	where t.takipEdenId=@kullaniciId and t.takipEdilenId=@takipEdilenId
	--eğertakip ediyor ise takibi bırak ve geri 0 döndür
	IF @Count!=0
	begin
	delete from takiplesme where takipEdenId=@kullaniciId and takipEdilenId=@takipEdilenId
	SET  @sonuc=0
	end
	--eğer takip etmiyorsa takip etmeye başla ve 1 döndür
	else
	begin
	insert into takiplesme(takipEdenId,takipEdilenId,takipTarihi) values(@kullaniciId,@takipEdilenId, GETDATE())
	
	SET  @sonuc=1
	end
END


GO
/****** Object:  StoredProcedure [dbo].[upload1photo]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[upload1photo]
	 @kullaniciId int, @gonderiTuru nvarchar(10), @aciklama nvarchar(50),@etiketSol nvarchar(20), @etiketSag nvarchar(20), @foto1url nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


declare @solKullaniciId int,@sagKullaniciId int
select @solKullaniciId=kullaniciId from kullanicilar where kullaniciAdi=@etiketSol
select @sagKullaniciId=kullaniciId from kullanicilar where kullaniciAdi=@etiketSag

   insert into gonderiler (kullaniciId, gonderiTuru, aciklama, etiketSol, etiketSag, foto1url, gonderiTarihi) 
   values(@kullaniciId,@gonderiTuru,@aciklama,@solKullaniciId,@sagKullaniciId,@foto1url,GETDATE())
END


GO
/****** Object:  Table [dbo].[begeniler]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[begeniler](
	[begeniIid] [int] IDENTITY(1,1) NOT NULL,
	[gonderiId] [int] NULL,
	[kullaniciId] [int] NULL,
	[begeniSolSag] [bit] NULL,
	[begeniTarihi] [datetime] NULL,
 CONSTRAINT [PK_begeniler] PRIMARY KEY CLUSTERED 
(
	[begeniIid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bildirimler]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bildirimler](
	[bildirimId] [int] IDENTITY(1,1) NOT NULL,
	[kullaniciIdBildirilen] [int] NULL,
	[kullaniciIdBildiren] [int] NULL,
	[bildirimTarihi] [datetime] NULL,
	[listelendi] [bit] NULL,
	[okundu] [bit] NULL,
	[bildirimTuru] [nvarchar](20) NULL,
	[aciklama] [nvarchar](50) NULL,
	[yonlendirmeURL] [nvarchar](50) NULL,
	[bildirimResimUrl] [nvarchar](50) NULL,
	[bildirimKey] [int] NULL,
 CONSTRAINT [PK_bildirimler] PRIMARY KEY CLUSTERED 
(
	[bildirimId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[duelloTeklifleri]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[duelloTeklifleri](
	[teklifId] [int] IDENTITY(1,1) NOT NULL,
	[teklifEdenId] [int] NULL,
	[teklifAlanId] [int] NULL,
	[teklifEdenFotoUrl] [nvarchar](50) NULL,
	[teklifAlanFotoUrl] [nvarchar](50) NULL,
	[yanit] [bit] NULL,
	[yanitTarihi] [date] NULL,
	[teklifTarihi] [date] NULL,
 CONSTRAINT [PK_duelloTeklifleri] PRIMARY KEY CLUSTERED 
(
	[teklifId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[engellemeler]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[engellemeler](
	[engellemeId] [int] IDENTITY(1,1) NOT NULL,
	[kullaniciId] [int] NULL,
	[engellenenKullaniciId] [int] NULL,
	[engellemeTarihi] [date] NULL,
 CONSTRAINT [PK_engellemeler] PRIMARY KEY CLUSTERED 
(
	[engellemeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[favoriGonderiler]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[favoriGonderiler](
	[favoriId] [int] IDENTITY(1,1) NOT NULL,
	[gonderiId] [int] NULL,
	[kullaniciId] [int] NULL,
	[favoriTarihi] [datetime] NULL,
 CONSTRAINT [PK_favoriGonderiler] PRIMARY KEY CLUSTERED 
(
	[favoriId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[gonderiler]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gonderiler](
	[gonderiId] [int] IDENTITY(1,1) NOT NULL,
	[kullaniciId] [int] NULL,
	[gonderiTarihi] [datetime] NULL,
	[gonderiTuru] [nvarchar](10) NULL,
	[aciklama] [nvarchar](50) NULL,
	[etiketSol] [int] NULL,
	[etiketSag] [int] NULL,
	[foto1url] [nvarchar](50) NULL,
	[foto2url] [nvarchar](50) NULL,
	[solBegeniSayisi] [int] NULL,
	[sagBegeniSayisi] [int] NULL,
 CONSTRAINT [PK_gonderiler] PRIMARY KEY CLUSTERED 
(
	[gonderiId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kullanicilar]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kullanicilar](
	[kullaniciId] [int] IDENTITY(1,1) NOT NULL,
	[kullaniciAdi] [nvarchar](20) NULL,
	[ad] [nvarchar](15) NULL,
	[soyad] [nvarchar](15) NULL,
	[email] [nvarchar](50) NULL,
	[sifre] [nvarchar](50) NULL,
	[kayitTarihi] [datetime] NULL,
	[hakkinda] [nvarchar](250) NULL,
	[gonderiSayisi] [int] NULL,
	[takipciSayisi] [int] NULL,
	[takipEdilenSayisi] [int] NULL,
	[profilPhotoUrl] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sikayetler]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sikayetler](
	[sikayetId] [int] IDENTITY(1,1) NOT NULL,
	[kullaniciId] [int] NULL,
	[gonderiId] [int] NULL,
	[sikayetTarihi] [datetime] NULL,
 CONSTRAINT [PK_sikayetler] PRIMARY KEY CLUSTERED 
(
	[sikayetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[takiplesme]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[takiplesme](
	[takipId] [int] IDENTITY(1,1) NOT NULL,
	[takipEdenId] [int] NULL,
	[takipEdilenId] [int] NULL,
	[takipTarihi] [datetime] NULL,
 CONSTRAINT [PK_takiplesme] PRIMARY KEY CLUSTERED 
(
	[takipId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[bildirimler] ADD  CONSTRAINT [DF_bildirimler_listelendi]  DEFAULT ((0)) FOR [listelendi]
GO
ALTER TABLE [dbo].[bildirimler] ADD  CONSTRAINT [DF_bildirimler_okundu]  DEFAULT ((0)) FOR [okundu]
GO
ALTER TABLE [dbo].[gonderiler] ADD  CONSTRAINT [DF_gonderiler_solBegeniSayisi]  DEFAULT ((0)) FOR [solBegeniSayisi]
GO
ALTER TABLE [dbo].[gonderiler] ADD  CONSTRAINT [DF_gonderiler_sagBegeniSayisi]  DEFAULT ((0)) FOR [sagBegeniSayisi]
GO
ALTER TABLE [dbo].[kullanicilar] ADD  CONSTRAINT [DF_kullanicilar_gonderiSayisi]  DEFAULT ((0)) FOR [gonderiSayisi]
GO
ALTER TABLE [dbo].[kullanicilar] ADD  CONSTRAINT [DF_kullanicilar_takipciSayisi]  DEFAULT ((0)) FOR [takipciSayisi]
GO
ALTER TABLE [dbo].[kullanicilar] ADD  CONSTRAINT [DF_kullanicilar_takipEdilenSayisi]  DEFAULT ((0)) FOR [takipEdilenSayisi]
GO
/****** Object:  Trigger [dbo].[begeniArttir]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[begeniArttir]
 on [dbo].[begeniler]
 after insert
 as
 --yeni beğeni geldiğinde o gönderinin bilgisini güncelle
 declare @gonderiId int, @begeniSagSol bit
 select @gonderiId=gonderiId,@begeniSagSol=begeniSolSag from Inserted
 --eğer yeni beğeni solki ise 
 if(@begeniSagSol=0)
  begin
    --gonderiler tablosunda solbeğeni sayısını arttır 
    update gonderiler set solBegeniSayisi+=1 where gonderiId=@gonderiId
  end
  --ozaman sagdakini beğenmiş demektir
  else
    begin
    --gonderiler tablosunda sagbeğeni sayısını arttır 
       update gonderiler set sagBegeniSayisi+=1 where gonderiId=@gonderiId
    end


GO
/****** Object:  Trigger [dbo].[begeniAzalt]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[begeniAzalt]
 on [dbo].[begeniler]
 after delete
 as
 --beğenmekten vazgeçildiğinde o gönderinin bilgisini güncelle
 declare @gonderiId int, @begeniSagSol bit
 select @gonderiId=gonderiId,@begeniSagSol=begeniSolSag from deleted
 --vazgeçilen beğeni solki ise 
 if(@begeniSagSol=0)
  begin
    --gonderiler tablosunda solbeğeni sayısını azalt 
    update gonderiler set solBegeniSayisi-=1 where gonderiId=@gonderiId
  end
  --vazgeçilen beğeni sagdaki ise 
  else
    begin
    --gonderiler tablosunda sagbeğeni sayısını azalt 
       update gonderiler set sagBegeniSayisi-=1 where gonderiId=@gonderiId
    end


GO
/****** Object:  Trigger [dbo].[begeniBildir]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[begeniBildir]
 on [dbo].[begeniler]
 after insert
 as
 --yeni beğeni geldiğinde foto sahibini ve etiketlenenleri kullanıcılara bildirim gönder
 declare @gonderiId int, @kullaniciIdBildiren int, @kullaniciId int, @etiketSol int, @etiketSag int, @bildirimResimUrl nvarchar(50)
 select @gonderiId=i.gonderiId,@kullaniciIdBildiren=i.kullaniciId ,@kullaniciId=g.kullaniciId,@etiketSol=g.etiketSol ,@etiketSag=g.etiketSag, @bildirimResimUrl=g.foto1url from Inserted i
 --beğenilen gönderilin etiket bilgilerini çek
 join gonderiler g on g.gonderiId=i.gonderiId
 
 --ilgili kişiye bildirimlere ekle
 
 --eğer bildirim kenndinden gelmediyse bildir
 if(@kullaniciId<>@kullaniciIdBildiren and @kullaniciIdBildiren <>@etiketSol and @kullaniciIdBildiren<>@etiketSag)
        begin
        insert into bildirimler (kullaniciIdBildiren,kullaniciIdBildirilen,bildirimTarihi,bildirimTuru,bildirimKey,bildirimResimUrl)
        values (@kullaniciIdBildiren,@kullaniciId,GETDATE(),'begeni',@gonderiId,@bildirimResimUrl)
        end
--eğer soletiken başkasınınsa onada bildir
 if(@etiketSol<>'' and  @etiketSol<>@kullaniciIdBildiren )
       begin 
       insert into bildirimler (kullaniciIdBildiren,kullaniciIdBildirilen,bildirimTarihi,bildirimTuru,bildirimKey,bildirimResimUrl)
        values (@kullaniciIdBildiren,@etiketSol,GETDATE(),'begeni',@gonderiId,@bildirimResimUrl)
       end
 --eğer sagetiket başkasınınsa ve soletiketten farklıysa ona da bildir
 if(@etiketSag<>'' and @etiketSag<>@kullaniciIdBildiren and @etiketSol<>@etiketSag)
       begin 
       insert into bildirimler (kullaniciIdBildiren,kullaniciIdBildirilen,bildirimTarihi,bildirimTuru,bildirimKey,bildirimResimUrl)
        values (@kullaniciIdBildiren,@etiketSag,GETDATE(),'begeni',@gonderiId,@bildirimResimUrl)
       end


GO
/****** Object:  Trigger [dbo].[begeniBildirimSil]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create trigger [dbo].[begeniBildirimSil]
 on [dbo].[begeniler]
 after delete
 as
 --beğenmekten vazgeçildiğinde o gönderinin bildirimlerini sil
 declare @gonderiId int, @kullaniciId bit
 select @gonderiId=gonderiId,@kullaniciId=kullaniciId from deleted
 --vazgeçilen beğeni ile ilgili bildirimi sil
 delete from bildirimler where kullaniciIdBildiren=@kullaniciId and bildirimKey=@gonderiId and bildirimTuru='begeni'
--bildirim key değeri olarak gonderi id tutulduğundan ona göre silme işlemi yap


GO
/****** Object:  Trigger [dbo].[begeniDegistir]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[begeniDegistir]
 on [dbo].[begeniler]
 after update
 as
 --beğeni uptade oldu yani fotonun beğeni tercihini değiştirdi
 declare @gonderiId int, @begeniSagSol bit
 select @gonderiId=gonderiId,@begeniSagSol=begeniSolSag from inserted
 --yeni beğeni soldaki ise
 if(@begeniSagSol=0)
  begin
    --gonderiler tablosunda solbeğeni sayısını arttır, sagbeğeni sayısını azalt
    update gonderiler set solBegeniSayisi+=1 ,sagBegeniSayisi-=1 where gonderiId=@gonderiId 
  end
  --yeni beğeni sagdaki ise
  else
    begin
    --gonderiler tablosunda sagbeğeni sayısını azalt 
       update gonderiler set solBegeniSayisi-=1, sagBegeniSayisi+=1 where gonderiId=@gonderiId
    end


GO
/****** Object:  Trigger [dbo].[favoriBildir]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[favoriBildir]
 on [dbo].[favoriGonderiler]
 after insert
 as
  --favlanan gönderinin sahibine bildirim gönder
 declare @gonderiId int, @kullaniciIdBildiren int, @kullaniciIdBildirilen int, @bildirimResimUrl nvarchar(50)
 select @gonderiId=i.gonderiId, @kullaniciIdBildiren=i.kullaniciId, @kullaniciIdBildirilen=g.kullaniciId,@bildirimResimUrl=g.foto1url
 from Inserted i 
 --gonderi sahibinin kullanıcıIdsini aldık
 join gonderiler g on g.gonderiId=i.gonderiId
 
 --bildirimler tablosuna ekle
 if(@kullaniciIdBildiren<>@kullaniciIdBildirilen)
        begin
        insert into bildirimler (kullaniciIdBildiren,kullaniciIdBildirilen,bildirimTarihi,bildirimTuru,bildirimKey,bildirimResimUrl)
        values (@kullaniciIdBildiren,@kullaniciIdBildirilen,GETDATE(),'favori',@gonderiId,@bildirimResimUrl)
        end


GO
/****** Object:  Trigger [dbo].[begenileriSil]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[begenileriSil]
   ON  [dbo].[gonderiler] 
   AFTER delete
AS 
BEGIN
	--gönderi silindiği zaman onla ilgili beğenileride sil
	SET NOCOUNT ON;
   --silinen gonderinin idsini al
    declare  @gonderiId int 
    select @gonderiId=gonderiId from deleted
 --beğeniler tablosunda onuna ilgili tüm kayıtları sil
    delete from begeniler where gonderiId=@gonderiId
END


GO
/****** Object:  Trigger [dbo].[etiketBildir]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[etiketBildir]
 on [dbo].[gonderiler]
 after insert
 as
 --gönderi paylaşıldığında etiketlenen kişilere bildirim gönder
 declare @kullaniciId int, @etiketSol int,@etiketSag int, @gonderiId int,@bildirimResimUrl nvarchar(50)
 select @kullaniciId=kullaniciId, @etiketSol=etiketSol,@etiketSag=etiketSag ,@gonderiId=gonderiId, @bildirimResimUrl=foto1url from inserted


--sol etiket kendine ait değilse  ve boş değilse bidirim yolla
if(@kullaniciId<>@etiketSol and @etiketSol<>'')
   begin
        insert into bildirimler (kullaniciIdBildiren,kullaniciIdBildirilen,bildirimTarihi,bildirimTuru,bildirimKey,bildirimResimUrl)
        values (@kullaniciId,@etiketSol,GETDATE(),'etiket',@gonderiId,@bildirimResimUrl)
   end       

--sag etiket kendine ait değilse  ve boş değilse bidirim yolla
if(@kullaniciId<>@etiketSag and @etiketSag<>'')
   begin
        insert into bildirimler (kullaniciIdBildiren,kullaniciIdBildirilen,bildirimTarihi,bildirimTuru,bildirimKey,bildirimResimUrl)
        values (@kullaniciId,@etiketSag,GETDATE(),'etiket',@gonderiId,@bildirimResimUrl)
   end


GO
/****** Object:  Trigger [dbo].[etiketBildirimKaldır]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE TRIGGER [dbo].[etiketBildirimKaldır]
   ON [dbo].[gonderiler]
   AFTER delete
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  declare @kullaniciId int , @gonderiId int
  select @kullaniciId=kullaniciId , @gonderiId=gonderiId from deleted 
  
  delete from bildirimler where kullaniciIdBildiren=@kullaniciId and bildirimKey=@gonderiId and bildirimTuru='etiket'
END


GO
/****** Object:  Trigger [dbo].[favoriSil]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[favoriSil]
   ON  [dbo].[gonderiler]
   AFTER delete
AS 
BEGIN
	-- silinen gönderiyle ilgili favori listesini temizle
	SET NOCOUNT ON;

    declare @gonderiID int
     select @gonderiID=gonderiId from deleted
     delete from favoriGonderiler where gonderiId=@gonderiID
END


GO
/****** Object:  Trigger [dbo].[gonderiSayisiArttir]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[gonderiSayisiArttir]
 on [dbo].[gonderiler]
 after insert
 as
 --kullanıcı yeni gönderi paylaştımı toplam gönderi sayısını arttır
 declare @kullaniciId int, @gonderiId int
 select @kullaniciId=kullaniciId  from inserted
 
 update kullanicilar set gonderiSayisi+=1 where kullaniciId=@kullaniciId


GO
/****** Object:  Trigger [dbo].[gonderiSayisiAzalt]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[gonderiSayisiAzalt]
 on [dbo].[gonderiler]
 after delete
 as
 --kullanıcı gönderiyi sildimi toplam gönderi sayısını azalt
 declare @kullaniciId int, @gonderiId int
 select @kullaniciId=kullaniciId  from deleted
 
 update kullanicilar set gonderiSayisi-=1 where kullaniciId=@kullaniciId


GO
/****** Object:  Trigger [dbo].[takipBildir]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[takipBildir]
 on [dbo].[takiplesme]
 after insert
 as
  
 declare @takipId int, @kullaniciIdBildiren int, @kullaniciIdBildirilen int
 select @takipId=i.takipId, @kullaniciIdBildiren=i.takipEdenId, @kullaniciIdBildirilen=i.takipEdilenId 
 from Inserted i 
        insert into bildirimler (kullaniciIdBildiren,kullaniciIdBildirilen,bildirimTarihi,bildirimTuru,bildirimKey)
        values (@kullaniciIdBildiren,@kullaniciIdBildirilen,GETDATE(),'takip',@takipId)


GO
/****** Object:  Trigger [dbo].[takipBildirimSil]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[takipBildirimSil]
 on [dbo].[takiplesme]
 --biri takipi bırakır ise  daha önce gönderilen takip bildirimlerini sil
 after delete
 as
 
 declare @kullaniciIdBildiren int, @kullaniciIdBildirilen int
 select @kullaniciIdBildiren=d.takipEdenId, @kullaniciIdBildirilen=d.takipEdilenId 
 from deleted d 
        delete from bildirimler 
        where kullaniciIdBildiren=@kullaniciIdBildiren and kullaniciIdBildirilen=@kullaniciIdBildirilen and bildirimTuru='takip'


GO
/****** Object:  Trigger [dbo].[takipciArttir]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[takipciArttir]
 on [dbo].[takiplesme]
 after insert
 as
 --takipleşme olayı olduğunda kişilerin takipçi sayılarını güncelle
 declare @takipEdenId int, @takipEdilenId int
 select @takipEdenId=takipEdenId, @takipEdilenId=takipEdilenId from Inserted
 --takip edenin takip ettikleri sayısını arttır
 update kullanicilar set takipEdilenSayisi+=1 where kullaniciId=@takipEdenId
 --takip edilenin takipçi sayısını arttır
 update kullanicilar set takipciSayisi+=1 where kullaniciId=@takipEdilenId


GO
/****** Object:  Trigger [dbo].[takipciAzalt]    Script Date: 15.05.2016 20:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[takipciAzalt]
 on [dbo].[takiplesme]
 after delete
 as
 --takipleşme bittiğinde kişilerin takipçi sayılarını güncelle
 declare @takipEdenId int, @takipEdilenId int
 select @takipEdenId=takipEdenId, @takipEdilenId=takipEdilenId from deleted
 --takip bırakanın takip ettikleri sayısını azalt
 update kullanicilar set takipEdilenSayisi-=1 where kullaniciId=@takipEdenId
 --takibi bırakılanın takipçi sayısını azalt
 update kullanicilar set takipciSayisi-=1 where kullaniciId=@takipEdilenId


GO
USE [master]
GO
ALTER DATABASE [twixphoto] SET  READ_WRITE 
GO
