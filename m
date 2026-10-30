Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396420;
	b=RgQdAbVQ8J26ng1hf6LR2/j/tgBTsoc5o/IuAJMUE0SrxrCk5q2BmqPnZwzOrbc+PxP/
	 yTfW1qzocbILsuVqlAYnUaf5W8FbV1mUovGb4d7MbyyBqCR86JRVEd1m0kRdN3lBkLm1W
	 PVw6sb4E/xm0Nd7BfdwUaH8YtznKaZnVkPmxa0NtfCtWu2BT6ZFcb+bWe62dT+h7mbzl8
	 15x9q36thP+8pWAung7D5W1X5VycYoBiNPatWRI3Bd7YYEwRkoj4lyEaa5HRkkiD9noNr
	 RdFEoJfqY3uF88Mi4ds2Wf89yeNKNPJ2SQV7D3crlEZ+QwgMibN63WXDb2XMG4IxWnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396420;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AzamBldx86MhDlsFg4AtMRiwjZaUeXBeihXriheeQTU=;
	b=W/8yqThDtpw4rlyI/iyJicbt6LTqv+Jskxii1NHLGp5fhCIcnaMEyRbd9aVXEBL7i974
	 oAHBW2TTaBkh/A0dDYoQtZf9X6EvfaMLPjw618UV+cmPaL2ig09kNe2Q2uVFULsQ3q2gz
	 Xxy9nvQw1gn0nmrYdv02yOHyq/uo9gUih1IZ58RoyuOLHPufklxqQyfpDsHIilIjGwv1K
	 k957pci5OXvB6I4R8ND8CQhMhsjsmCte8yAOGAZQnYVF37649FyN1iZM6XcODVEBMa8+P
	 DsCIylmJdVDehOQfpnWuGqHuzXAqQRD/zTpDlIuuLwkAxNgpgLJ/xp6dWuqP0HDE+Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bfs3p0Dk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rbg6A6+l;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17674606A327
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 21:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17674606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bfs3p0Dk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rbg6A6+l
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ULAfHr823317
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 21:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AzamBldx86MhDlsFg4AtMRiwjZaUeXBeihXriheeQTU=; b=bfs3p0DkFZKaSceC
	vlX1bd0BKhJEnIsymsRUWJ7yd1yDZXKKvugBcFpoUzvzcC4+apH39jdaK3OrWlUY
	hdHpSo2cEgYmjpelO34Sng57/Dx2Q3phKrK7rdewRDP2zwDbuOCj0KP718ThKMjF
	6OJotWNLHDy/WM3iux+vAzv+oR0xZhQ2THdceY5sHxL0x2VNP4R6WzWX8An6R54l
	xKOGKbL+3SLJbzHbvhUP+guCrL79i4TJMpi/3xH2YHFuQ3S+VWMW354qlLcgBLf3
	cVHgVmzIrLceeI+Vc4u3039QlBRWWa/8R6cPHxJvQZAWPUBlE2woOlK8tncXhBYo
	ivS45Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x08563-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 21:40:18 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a3451ea93so1813215eec.1
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 14:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793396418; x=1794001218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AzamBldx86MhDlsFg4AtMRiwjZaUeXBeihXriheeQTU=;
        b=Rbg6A6+lnbiUFG+Z4y9lB7aaH+DE8yPhrJBKSXehz8KMZfADeruDllrY0gZt/ekaxk
         qOZCVPLCczd81WYHqHp0zURV+/KpOVLrOvw2Be/LGoK38YM2MNPfwS0ZTpIKhz8T8ByK
         i4azqU2/9tdq2mVmkjjKHKO5PrT3ytvXKFF4FsvHvS3H1LQXOxwuEbKK8ZujYnSaKtOt
         EO3htStWQlh8j3JzTUNMMBULzQZQ7lpLvzah9qkZn4GyTIr7WQe9ALMRkwYdbFN/jml/
         E9xT9E0KpUd+IA+QPYctHaJJBx6/eN5/QJKyz+U5/Kyt9HDQDEf1DZ39K16oh5icBoWs
         54DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396418; x=1794001218;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AzamBldx86MhDlsFg4AtMRiwjZaUeXBeihXriheeQTU=;
        b=TjYo9fltgQqDqWmBQB93Mt3X0ywmNHl6i/P1h3086bGvimil3DOzA2ojo+XsGd7AtR
         qHAJljib950VhVoe8i0O8mLFcqoBh8qaPLGcaqDjKa6zTtLZm2w6P0GRxydEXXdw5EoM
         86Zi4HesnZVl6iZFUY4rmcJapuUPhnIQ4Y/vf8zscLxeB23n8MnJBrbnN+qzFoshGtV3
         sSuui4rGA2Ruw1MCy2TdIHuGqPg2GzB3FDJGo0vC/7rPWqzx7Oq2b5B9iTbfQo7Tkf9R
         p6QJC4vgVUX/nByEMYFJnI0fv+lCPwu1d/oryQ5DUos1vVBZwHwxghUv2Qv9RUsZq4b5
         6yfA==
X-Forwarded-Encrypted: i=1; AKwUvByvN/6Co06afVyQ/1HlO1myoFRjQtERHHqRm2H+clxrMbfFUVcNovRrWYdJFkfPv4tVAFBKcuLTbjQQ@vger.kernel.org
X-Gm-Message-State: AFq9FYKOX12nJIw1hIde7QAaeoY3f8EOqALq8MI/g3j4UgH4tg7f3w7J
	eOlILx7KBUoMC0pggiWvDrJHuP9/FeA4vZ7ZVbqaOrbKgLxF9v9oRJec/NAOctOWW2vGHgAgraF
	Vyzppnd784O4rk2+YkvugOgOxK5bA1Db4apzHodqMxmhzgKXoXpq+RkstMIgVEFob
X-Gm-Gg: AYBFou02DSwlCld+L3u/winFFij2KlcEQVUxd4pqTqn7CCdliEe0RkvdlLk9LYR7a+C
	VE3oP3QQBg/6H5NdzYYVaYkVJQXDPKa9UiiCfnnzj9fiiXQT1TCf1GXUAxmBZJudIKxJMMUJbEb
	MuOrEUUe8JbIwpHvnzFfs5llhIz3Xa8et1PwQ8AZDPw/RdZxRB/GznGv5/3ifHpqDjjI39iACvH
	pJxMdxycrfDSOnxaFKObO15X3EzR65Ll/oBY1zhTQmo1FZEo+5r4ExhltmkMhTnLLro6kTXcmht
	z1YgcPmjgZbZudGspMTdkv7cpokPFWdkPNJXz92P2aSLVcVMjT9K7CvbF5Ql2pLeVqCUI2ez9Tt
	95Qa9zAw9fIEjrmkReK3ZU+fQxFueJJ4wQMoXXi1Us8QaDB4elVWRFqxsv24A/Q+eU0YLSSd6OX
	bqBUTjgsAOgYCHGxXJLwklTz2UlWQ=
X-Received: by 2002:a05:693c:4154:20b0:35e:f4ac:5f8e with SMTP id 5a478bee46e88-36a420574admr5315643eec.0.1793396417737;
        Fri, 30 Oct 2026 14:40:17 -0700 (PDT)
X-Received: by 2002:a05:693c:4154:20b0:35e:f4ac:5f8e with SMTP id 5a478bee46e88-36a420574admr5315576eec.0.1793396416900;
        Fri, 30 Oct 2026 14:40:16 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm13643226eec.16.2026.10.30.14.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:40:16 -0700 (PDT)
Date: Fri, 30 Oct 2026 14:40:13 -0700
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
Message-ID: <20261030144013.0000320e@oss.qualcomm.com>
In-Reply-To: <fdbce441-921f-4ef9-9c57-0685706cdf89@arm.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oE2J4q1KKiZHH98AjYPKAHJJm36Ejkdz
X-Authority-Analysis: v=2.4 cv=Z6N5j3RA c=1 sm=1 tr=0 ts=6ae50ec2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=OkvmfuOBzfRrInaeso0A:9
 a=CjuIK1q_8ugA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NiBTYWx0ZWRfXwer/Pq9iaJa0
 Rkm7YksZuX2WQfkymf4diD7xXStwMU9cKVzJuGCeBvhcxlvrSr9BJMEzBEmvnIAwRauEda4WXVk
 kkBYBsAPJIuj5emCM5ULiy+Acum1UHSb09XASiMxNsHkIlYv+Dah1hXGVytDStGmdeOkvdki5Hm
 kAY8BUa1uM/jfJnXO7QZHs7V5GRZwzVxHBmredqPglSwrYbpVlU4x29hzwrh2p6nG9S+ur+pv7B
 IzbBR+8waD+soWYfiaR0tBfnWD0zg7lNgXxOn2YCMJ9HIYgRZ61IZB/a5Qj0z1Ft9WKxg8fsSgL
 ZU4JXhdTtGrCy44Ienw0UJWXIF/NWKL0MV2fH81/zwuqsHMQtTigOnQDxBYVH/L2hCStuPT+hrP
 YKn708N1kHW50yjjw9NreMnGqinseT/Yyp9K+fx2gGVkvB9LRPu9B49i916Sd79JJqTcBzTZapY
 PWOArGwahzqCgmxaSGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NiBTYWx0ZWRfXwmKNxFax7Jbt
 0yQn6hBcXGzsLDy1SschYaoMCL5yogHdk0O5HsNTQ9jeKmeJnj2JKN5d1cxiCE5TespVyRaPbsQ
 1iHG8eHF7C5ntQz6I7ydTpAB97DYchg=
X-Proofpoint-ORIG-GUID: oE2J4q1KKiZHH98AjYPKAHJJm36Ejkdz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300086

On Fri, 30 Oct 2026 18:16:06 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> On 10/30/26 16:19, Jonathan Cameron wrote:
> > On Fri, 30 Oct 2026 12:51:47 +0100
> > Pierre Gondois <pierre.gondois@arm.com> wrote:
> >  
> >> On 10/25/26 00:05, Ashok Raj wrote:  
> >>> On Fri, Oct 23, 2026 at 05:04:05PM -0700, Jonathan Cameron wrote:  
> >>>> On Sat, 24 Oct 2026 00:40:33 +0200
> >>>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >>>>     
> >>>>> On Fri, 23 Oct 2026 14:26:21 -0700
> >>>>> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
> >>>>>     
> >>>>>> On Thu, 22 Oct 2026 09:07:25 +0200
> >>>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>>>>>         
> >>>>>>> On 10/20/26 19:10, Jonathan Cameron wrote:  
> >>>>>>>> On Mon, 19 Oct 2026 22:38:39 +0200
> >>>>>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>>>>>>>            
> >>>>>>>>> The support is mostly duplicated from Memory Error Section handling.
> >>>>>>>>> Other than differences coming from the content of  Memory Error
> >>>>>>>>> Section 1 and 2, differences in the support are:
> >>>>>>>>>
> >>>>>>>>> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> >>>>>>>>> This structure was used to support older versions of the Memory
> >>>>>>>>> Error Section (1). This is not needed for the new structure.
> >>>>>>>>>
> >>>>>>>>> - The compact version is also used by the tracing framework.
> >>>>>>>>> To avoid relying and propagating a non-standard record format,
> >>>>>>>>> through trace event (cf. extlog_mem event) the new trace event
> >>>>>>>>> prints each field individually.
> >>>>>>>>>
> >>>>>>>>> The last patch of the serie was only build-tested due to the
> >>>>>>>>> absence of relevant hardware. apei_mce_report_mem_error() and
> >>>>>>>>> arch_apei_report_mem_error() implementations were also removed since
> >>>>>>>>> last version.
> >>>>>>>>>
> >>>>>>>>> It will also require a proper handling from the rasdaemon. Applying
> >>>>>>>>> this last patch without rasdaemon support will silent the reports of
> >>>>>>>>> Memory Error Section 2 error, cf. ras_userspace_consumers() check.  
> >>>>>>>> Hi Pierre,
> >>>>>>>>
> >>>>>>>> I'd slow down a bit.  We are mid merge window and convention is normally
> >>>>>>>> one version a week or so anyway.  Better to gather up feedback from
> >>>>>>>> a number of folk and spin only one revision to cover it all.
> >>>>>>>>            
> >>>>>>> Hello Jonathan,
> >>>>>>>
> >>>>>>> Ok sure, as the v1 was reviewed quickly I thought there was a chance
> >>>>>>> of having the serie accepted quickly aswell. I ll wait a bit more.
> >>>>>>>
> >>>>>>> Thanks for the review,
> >>>>>>>
> >>>>>>> Pierre
> >>>>>>>           
> >>>>>> A general question that came up in a related thread with one of
> >>>>>> our RAS architects. How does firmware decide what to send?  As far as
> >>>>>> I can tell firwmare has no way to know whether the OS understands the CPER
> >>>>>> Memory Section 2.
> >>>>>>
> >>>>>> So options that come to mind.
> >>>>>> 1. Firmware must send a CPER with both Memory Section and Memory Section 2.  
> >>>>> Please don't do this: this would require either Kernespace or userspace to
> >>>>> discard one of the reports, only if the other one is there, which can be
> >>>>> tricky. Could be done more easily at userspace, but only if some database
> >>>>> support is enabled, but, at least on rasdaemon, this is an optional module.  
> >>>> Good. That confirms my view that is horrible.  
> >>> Hi Jonathan,
> >>>
> >>> I agree that an _OSC capability is the right long-term solution.
> >>>
> >>> Firmware should select one native CPER format based on OS support, rather
> >>> than emit both Section 1 and Section 2 and leave deduplication to the OS
> >>> or userspace.
> >>>
> >>> For a Section 2-capable kernel, we may still avoid a second GHES notifier
> >>> chain: preserve the existing struct cper_sec_mem_err * contract and give
> >>> it a lossy Section 1 projection of a Section 2 record. The conversion must
> >>> translate validation bits and clear validity for values that cannot be
> >>> represented, rather than truncate them.  
> >> I understand we might want to emit a new extlog_mem2_event and a lossy
> >> extlog_mem_event for legacy userspace, but I'm not sure to follow how
> >> you want to do it.
> >>
> >> Do you suggest that we only need one notifier (ghes_report_mem_chain)
> >> and that we should not add ghes_report_mem2_chain ? This would mean
> >> that the .notifier_call (= ghes_edac_report_mem_error) should handle
> >> both cper_sec_mem_err/cper_sec_mem_err2 struct.
> >>
> >> Another solution would be to keep the ghes_report_mem2_chain,
> >> which would be responsible of creating the lossy v1 struct and
> >> triggering the original ghes_report_mem_chain.
> >>  
> >>> That preserves legacy EDAC consumers, but cannot carry all Section 2 data.
> >>> Updated userspace needs the native Section 2 payload through a
> >>> full-fidelity path, such as the existing GUID-tagged raw CPER event.
> >>>
> >>> This does mean an updated userspace listener may receive both the legacy
> >>> EDAC summary and the raw Section 2 record for the same firmware error.
> >>> They are two kernel views, not two firmware reports. We should therefore
> >>> add a shared GHES record/section ID to both events, so userspace can
> >>> correlate them reliably; address and timestamp are not sufficient.
> >>>
> >>> So _OSC solves firmware selection for old versus new kernels, while a
> >>> Section 1 projection plus the raw payload handles legacy versus updated
> >>> consumers on a new kernel.
> >>>
> >>> Thoughts?  
> >> This will put more burden on the firmware, but this seems the right
> >> thing to do. I ll share the thread with the group working more closely
> >> on the architecture aswell,  
> > We have will have a code first proposal for the _OSC part shortly. Just going
> > through internal review.  I'll make sure you + others here are on the +CC.  
> 
> Ok thanks,
> If you can also also add Mark Brown <broonie@kernel.org>
> 
https://lore.kernel.org/linux-acpi/20261030143802.0000231d@oss.qualcomm.com/

I started a new thread so it wasn't too buried.

Thanks

Jonathan


