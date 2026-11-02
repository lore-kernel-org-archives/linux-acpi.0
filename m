Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638703;
	b=GQZy3C+mcQPVhMrwxuUviIwXLASd6vG/5gyCfc6VA3ah+pwn3fAtynNuSarICqY9Alv4
	 W9G6enUNvc0O0a9JXL0NZPr4TeLuDaJ1jwa8Fp4JVOGsmNUrafgjuojHVf4LFIId6GXPh
	 D1OME1YhP980jPKLJDIdFXdwSWloxA3JRjZvXRefNg6MVubCw4Z7xK37WzJuJgnvO+QVJ
	 kEHoBplrJLsvZ1S3VYS0ojtQkCyMcObtLKJn/lx9DWdnqSgcAMDrMYldzdmm3Q1cnMPF5
	 1x/UdjmvPPrMFO9ML1dlQDVH1YR3al8JVnqnNIYM6x3rtRgEMyOj7deC+fggQHQsqXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638703;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PzJGXubz8ItkEzPUWY/nEgW+2q4rBpwlu9LIiqUJd14=;
	b=KwUQEn2QBs6W0tzRETykyVZ5ZfjRhXnWsw3/MgdlAsYl4wGzmr+Yx8RLmQ5XfQsTlnzH
	 Jf9poOOzVs4E1M0QbxuVHBK8oPMendP1pmVCVOpcc6JLdVFHPcEw/si4Sg4zmhlXrLA9w
	 coUtA2ep5vTYIYH925Tzzrq35Dfow5zfFfkh8Pg0g/u4j76YNZjXuEQu1hHZx54FbvfJe
	 6PHBpcgMZq0wXuWoG+C6amdkFrwldBBK9QYb1ecGs1XJw0Jz0xurdsiPdt0pQNbf13L8b
	 Fve9xAnF8VObJLvn5P/waqhhaClo2XGGhDopCBJCMMkWmCEfviOJoimHcJW7ewAh2Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dUN+m8HR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jgUKC03J;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DF9607BD24
	for <linux-acpi@vger.kernel.org>; Mon,  2 Nov 2026 16:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90DF9607BD24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dUN+m8HR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jgUKC03J
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2GYstv1222685
	for <linux-acpi@vger.kernel.org>; Mon, 2 Nov 2026 16:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PzJGXubz8ItkEzPUWY/nEgW+2q4rBpwlu9LIiqUJd14=; b=dUN+m8HRQemx+JdO
	1Kq3YwsYqp2TrSKgPY3P1b0kRCoBuWIs3Jmhjw9Q8gtZ1DVoVEYtMHmPpysXpt4w
	2jye2Swznblo03xfDawI44V2DSeCGRIdhtk4c0QMmUvnt7CubrvLmcqHad7A9dI2
	l47x1f43RQlT/GnjWbzy6uWjN/f/oHGSzef/u4Pb3y5VnoRGgwYBKLGfSOTrU3A8
	GKjFkluaUCa64y+XRLVyOFPp0OUmNFrLg5VOQZqarjK5ejjJB8Ll0yFQHZut9DES
	2geDkoysbL7Qgq9sBB+kIlBDsfPg3EM1adQ/FoU5j/rLejnBs7mADF+8eDk0jcbc
	0DSp1Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1tst3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 02 Nov 2026 16:58:21 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a190c53a3so4394122eec.0
        for <linux-acpi@vger.kernel.org>; Mon, 02 Nov 2026 08:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793638701; x=1794243501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PzJGXubz8ItkEzPUWY/nEgW+2q4rBpwlu9LIiqUJd14=;
        b=jgUKC03J1qarY0z2tMlQ+AQIMT7+TGTKktzZXZdn9i9PTXj12XBUa+Ml1slAzDHPoK
         2sbO6VEwN6BDayzFHVe/o4s2CJ5Brr3tU/6AfDnASg9/bCsIFT+t1M35aWE4AygS7TXr
         fE32PjksDn7lITqgfGyGAi+s5jNI4lm0GP7k/fX2xHXPTpVJjo+VdFCYWrwamJpPlnSO
         no5xLZZF9TGa+Luabiq+Xr9PZTxM96ZAL7hTx0ZiFtsrIsj3/SmYW4wg/WEjeyzDqroZ
         L2m8D0a6eEKz+sGU6jK7vnr4EpTAdzxZlqhRHL+qtxD8eR5w9269dXyl0eSo+aJq1/d/
         E22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638701; x=1794243501;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzJGXubz8ItkEzPUWY/nEgW+2q4rBpwlu9LIiqUJd14=;
        b=HJ5OzgEFP2ET9tp37zGkto8XagssztdvA8kBXVkhDFGgvCnH6DkFs92uR02OMEnPkX
         X6Uh1l+YuEkHk9nmGKdBOBFnWPD5vMb3Dql25HtDTA/Q3WbC402jgudPownR4kF/BNG+
         vX97ccatO51BaKvS0Mitt//EJIpXIBWU73JGRHB4KdZ4tZwr1y2jGB9vppMzTy3Z1V0b
         n/0nSx5kaA/ndkf9cNbrAa5p+ZPj+4c7j9+BE5aSPleZ/3G+hYN8J2PE0IYMG2sDgX3a
         q+DkSKSzo0NjSCj3bJac9eCKeBbTchS8MbB84bLxI5iNtc0qqaSAyWfYldiZQ/PQ8Pve
         E8ww==
X-Forwarded-Encrypted: i=1; AKwUvBwwJwVUqzC24gkd4bVvugiea/Qkt38IgLG9rPBeRgR+E/qIIij+aj+wMz9fs4QufhZHbIxlk0lctHXr@vger.kernel.org
X-Gm-Message-State: AFq9FYIMTRqAgyOtA3lCi4IW5awsMf7yaGOkl99QmpcvYH+K99F4h0YS
	5eSIxnCciaI0B3Pf7Qhq+ap+IEvk5T7qZFUcooHkfWvhTbpyWvZx+5W2g8Wq53j4S/nW7f3opMD
	KPnvehufT4LcVqOrrb0c2XNYFTL2jdIfcRpymN30hZ4ujbf3z+qvyIM65alMAite9
X-Gm-Gg: AYBFou0MgB0W7b2l0azzt9GHY7Pl/Y/f+sgTuetsroe4cuYwAMrf2RsDeT7z0CJI1P9
	JbRXznpjMbqhTfL42aaYUprJTHWSAFrekrKuPGxCbCHpPIrCgzTZpXkbcfy470745CgW2HmcERH
	VEvWaEVOuwF6EOtZv/z9p7Zbi2L12tiDBE/6O9eo9jzqodrAcYSaBthsmG94YVMv6eJEvNdM6CI
	uYlZIh4s/VOmfvZtzKQhXdDamOv77onVAxJx7u2qd0cBezOLwSGM976dy5LjCbG2k63lzre9kO3
	/lNIENIWWQZEyv7/FSLeMQKShRywDB9RPhB8xxuPDLIWuzrkqv482SU01c6nV3Icz58QWjcZv99
	FTOq1SFIqOycm+N0ei5abnB7NfU8CyEa69OcDObXenCOoch+oPwSRhUc1G4Jw+/YpID7KstL8ML
	rQqgCqoSxQkZ/Lv3XhKSVYNwf0Vkg=
X-Received: by 2002:a05:693c:864d:10b0:362:2e2f:c261 with SMTP id 5a478bee46e88-36a3b5fdb1bmr19288529eec.27.1793638700560;
        Mon, 02 Nov 2026 08:58:20 -0800 (PST)
X-Received: by 2002:a05:693c:864d:10b0:362:2e2f:c261 with SMTP id 5a478bee46e88-36a3b5fdb1bmr19288478eec.27.1793638699826;
        Mon, 02 Nov 2026 08:58:19 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm44938189eec.15.2026.11.02.08.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:58:19 -0800 (PST)
Date: Mon, 2 Nov 2026 08:58:15 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
        Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Borislav
 Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, James Morse
 <james.morse@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Maciej
 Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Pawel Chmielewski
 <pawel.chmielewski@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>,
        Breno Leitao
 <leitao@debian.org>, Dan Williams <djbw@kernel.org>,
        Terry Bowman
 <terry.bowman@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
        Morduan Zang
 <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev,
        Ashok Raj
 <ashoraj@qti.qualcomm.com>
Subject: Re: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
Message-ID: <20261102085815.00002239@oss.qualcomm.com>
In-Reply-To: <3718c5fa-88de-471b-89f5-4cba15975a49@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261020101048.00000186@oss.qualcomm.com>
	<0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
	<20261023142621.00007051@oss.qualcomm.com>
	<20261024003917.283b890d@foz.lan>
	<20261023170405.000060b8@oss.qualcomm.com>
	<at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com>
	<43301529-f169-493c-bc59-fa08b77e1ef3@arm.com>
	<20261030081941.000040e7@oss.qualcomm.com>
	<fdbce441-921f-4ef9-9c57-0685706cdf89@arm.com>
	<20261030144013.0000320e@oss.qualcomm.com>
	<3718c5fa-88de-471b-89f5-4cba15975a49@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: V44-ofmBaithKT8I_Sy_Wg6jzK-AQhhW
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae8c12d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=eIcoSznhEi4KaPes0yMA:9
 a=wPNLvfGTeEIA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2NyBTYWx0ZWRfX1LD/r8977U/D
 diNW/YrpByY4wdk40Wrc/HFXG2qTZw9P5w00WqM22uBCysYO00MWG1XFOzxT0x86SIWXdeqaCom
 ZvuGE85mOP1Z+jAF9LYZpg9VtDww/7zYsXxuSR1XWuArfJM2840ulkCGoUW3ZCRS5wqctAnHif4
 SW+w2w/FiJ2SMRqs/qxWxqXuvx14t2scXNJoRtMjKavNsCtd9OVlnBJtLG5R8hxwNWXD65SjXhr
 AxvWHnjk//58Dfd0ZPC8QWJqACoRME3VdApVLmfLrGDE4co+O9eDzfQUPMx/WRq4J3RU/Co/ELZ
 /GXfR4E4qF0k2Q2qNxstjfOBEc9ARWTVomisJot3YCa1qtPPZoYog2M9hNrrmxQoylw+2ixhI/P
 jmCEq9pfNILqetEhdjcFxWI64BBLyXTybg+OqswYLuUorPONIcZAimTg0KcwG5O8c3j44omJiXH
 FewcF9n8mjjKouepYSg==
X-Proofpoint-GUID: V44-ofmBaithKT8I_Sy_Wg6jzK-AQhhW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2NyBTYWx0ZWRfXwb4agi1q3b8n
 LRsUv6myhkRdo26+MQpMsOiYxdkk/d28/vbcpEDgLPUQH2STuMJ0CzbGsnm1hiHgW1WnltQrzxP
 TPdERAyTrf/tOVoqicrPQR0G1Xtn+t8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020067

On Mon, 2 Nov 2026 12:33:16 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> On 10/30/26 22:40, Jonathan Cameron wrote:
> > On Fri, 30 Oct 2026 18:16:06 +0100
> > Pierre Gondois <pierre.gondois@arm.com> wrote:
> > =20
> >> On 10/30/26 16:19, Jonathan Cameron wrote: =20
> >>> On Fri, 30 Oct 2026 12:51:47 +0100
> >>> Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>>    =20
> >>>> On 10/25/26 00:05, Ashok Raj wrote: =20
> >>>>> On Fri, Oct 23, 2026 at 05:04:05PM -0700, Jonathan Cameron wrote: =
=20
> >>>>>> On Sat, 24 Oct 2026 00:40:33 +0200
> >>>>>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >>>>>>       =20
> >>>>>>> On Fri, 23 Oct 2026 14:26:21 -0700
> >>>>>>> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
> >>>>>>>       =20
> >>>>>>>> On Thu, 22 Oct 2026 09:07:25 +0200
> >>>>>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>>>>>>>           =20
> >>>>>>>>> On 10/20/26 19:10, Jonathan Cameron wrote: =20
> >>>>>>>>>> On Mon, 19 Oct 2026 22:38:39 +0200
> >>>>>>>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>>>>>>>>>              =20
> >>>>>>>>>>> The support is mostly duplicated from Memory Error Section ha=
ndling.
> >>>>>>>>>>> Other than differences coming from the content of  Memory Err=
or
> >>>>>>>>>>> Section 1 and 2, differences in the support are:
> >>>>>>>>>>>
> >>>>>>>>>>> - v2 do not rely on a compact "struct cper_mem_err_compact" s=
truct.
> >>>>>>>>>>> This structure was used to support older versions of the Memo=
ry
> >>>>>>>>>>> Error Section (1). This is not needed for the new structure.
> >>>>>>>>>>>
> >>>>>>>>>>> - The compact version is also used by the tracing framework.
> >>>>>>>>>>> To avoid relying and propagating a non-standard record format,
> >>>>>>>>>>> through trace event (cf. extlog_mem event) the new trace event
> >>>>>>>>>>> prints each field individually.
> >>>>>>>>>>>
> >>>>>>>>>>> The last patch of the serie was only build-tested due to the
> >>>>>>>>>>> absence of relevant hardware. apei_mce_report_mem_error() and
> >>>>>>>>>>> arch_apei_report_mem_error() implementations were also remove=
d since
> >>>>>>>>>>> last version.
> >>>>>>>>>>>
> >>>>>>>>>>> It will also require a proper handling from the rasdaemon. Ap=
plying
> >>>>>>>>>>> this last patch without rasdaemon support will silent the rep=
orts of
> >>>>>>>>>>> Memory Error Section 2 error, cf. ras_userspace_consumers() c=
heck. =20
> >>>>>>>>>> Hi Pierre,
> >>>>>>>>>>
> >>>>>>>>>> I'd slow down a bit.  We are mid merge window and convention i=
s normally
> >>>>>>>>>> one version a week or so anyway.  Better to gather up feedback=
 from
> >>>>>>>>>> a number of folk and spin only one revision to cover it all.
> >>>>>>>>>>              =20
> >>>>>>>>> Hello Jonathan,
> >>>>>>>>>
> >>>>>>>>> Ok sure, as the v1 was reviewed quickly I thought there was a c=
hance
> >>>>>>>>> of having the serie accepted quickly aswell. I ll wait a bit mo=
re.
> >>>>>>>>>
> >>>>>>>>> Thanks for the review,
> >>>>>>>>>
> >>>>>>>>> Pierre
> >>>>>>>>>             =20
> >>>>>>>> A general question that came up in a related thread with one of
> >>>>>>>> our RAS architects. How does firmware decide what to send?  As f=
ar as
> >>>>>>>> I can tell firwmare has no way to know whether the OS understand=
s the CPER
> >>>>>>>> Memory Section 2.
> >>>>>>>>
> >>>>>>>> So options that come to mind.
> >>>>>>>> 1. Firmware must send a CPER with both Memory Section and Memory=
 Section 2. =20
> >>>>>>> Please don't do this: this would require either Kernespace or use=
rspace to
> >>>>>>> discard one of the reports, only if the other one is there, which=
 can be
> >>>>>>> tricky. Could be done more easily at userspace, but only if some =
database
> >>>>>>> support is enabled, but, at least on rasdaemon, this is an option=
al module. =20
> >>>>>> Good. That confirms my view that is horrible. =20
> >>>>> Hi Jonathan,
> >>>>>
> >>>>> I agree that an _OSC capability is the right long-term solution.
> >>>>>
> >>>>> Firmware should select one native CPER format based on OS support, =
rather
> >>>>> than emit both Section 1 and Section 2 and leave deduplication to t=
he OS
> >>>>> or userspace.
> >>>>>
> >>>>> For a Section 2-capable kernel, we may still avoid a second GHES no=
tifier
> >>>>> chain: preserve the existing struct cper_sec_mem_err * contract and=
 give
> >>>>> it a lossy Section 1 projection of a Section 2 record. The conversi=
on must
> >>>>> translate validation bits and clear validity for values that cannot=
 be
> >>>>> represented, rather than truncate them. =20
> >>>> I understand we might want to emit a new extlog_mem2_event and a los=
sy
> >>>> extlog_mem_event for legacy userspace, but I'm not sure to follow how
> >>>> you want to do it.
> >>>>
> >>>> Do you suggest that we only need one notifier (ghes_report_mem_chain)
> >>>> and that we should not add ghes_report_mem2_chain ? This would mean
> >>>> that the .notifier_call (=3D ghes_edac_report_mem_error) should hand=
le
> >>>> both cper_sec_mem_err/cper_sec_mem_err2 struct.
> >>>>
> >>>> Another solution would be to keep the ghes_report_mem2_chain,
> >>>> which would be responsible of creating the lossy v1 struct and
> >>>> triggering the original ghes_report_mem_chain. =20
>=20
> [1] Not sure about the outcome of the above.

Needs input from the RAS maintainers etc - particularly on x86.

>=20
> >>>>    =20
> >>>>> That preserves legacy EDAC consumers, but cannot carry all Section =
2 data.
> >>>>> Updated userspace needs the native Section 2 payload through a
> >>>>> full-fidelity path, such as the existing GUID-tagged raw CPER event.
> >>>>>
> >>>>> This does mean an updated userspace listener may receive both the l=
egacy
> >>>>> EDAC summary and the raw Section 2 record for the same firmware err=
or.
> >>>>> They are two kernel views, not two firmware reports. We should ther=
efore
> >>>>> add a shared GHES record/section ID to both events, so userspace can
> >>>>> correlate them reliably; address and timestamp are not sufficient.
> >>>>>
> >>>>> So _OSC solves firmware selection for old versus new kernels, while=
 a
> >>>>> Section 1 projection plus the raw payload handles legacy versus upd=
ated
> >>>>> consumers on a new kernel.
> >>>>>
> >>>>> Thoughts? =20
> >>>> This will put more burden on the firmware, but this seems the right
> >>>> thing to do. I ll share the thread with the group working more close=
ly
> >>>> on the architecture aswell, =20
> >>> We have will have a code first proposal for the _OSC part shortly. Ju=
st going
> >>> through internal review.  I'll make sure you + others here are on the=
 +CC. =20
> >> Ok thanks,
> >> If you can also also add Mark Brown <broonie@kernel.org>
> >> =20
> > https://lore.kernel.org/linux-acpi/20261030143802.0000231d@oss.qualcomm=
.com/
> >
> > I started a new thread so it wasn't too buried. =20
>=20
> Thanks !
>=20
> Just to be sure, the _OSC=A0discussion should not prevent this patchset
> to proceed right ? I think there is only [1] which I m not sure about the
> outcome otherwise,

It doesn't prevent this going forwards, but reality is I think no platform
is going to surface any Memory Section 2 errors until we have the _OSC. =20

It should be a trivial addition though to pop the _OSC assuming we get
it in the spec.

thanks,

Jonathan

>=20
> Regards,
>=20
> Pierre
>=20

