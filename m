Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373591;
	b=GZ1muZg8FL+2G1K5OHSgPdKUJT4WGHHVZWoZNinoHanB9RqSiMroA1RhigKGWq1LEb+I
	 yeNPnNATvalJaz3j5AscbA5CGVJAxZBjagz7KIjItCAOdQF+PGd3eDCjZfmFiaBe3N/hF
	 9peYmW0xoCDvo/Y2NOR1peL8Qh/G9I0ULtBns/KMNw5uLFAfZBog/6ixA7Urx9SagICNt
	 xemhxWrVlc1GtSw+/31TDsvZrArmJX0RrWXCnjX/jPXqcuGUzDp5sA2rZdVKJxhQvoUBH
	 Bz5cbFt77+t5yX5nUfkIhT3M9rArI5xTA0RJP8Iz8cw8yerZPs409ff1KDF8CAhDXAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373591;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FGkyxQN9i0NhBdCJIXq1uYlUjDXSlWOx7RjK7fuDemM=;
	b=Bvlnw/eF2NLE5EXM0uqV9HYozalcuvJTvpQtYA7QmKqg59e3tk419EpL5HChzY/62eMD
	 YwGlKngOCcllf5bWPZy4I122N9g237mZ6irH05ZzolImmm+ndBtD5/YPkrfev0dRUSGbh
	 mHsudKqx0cprsMcY0dLPkn6/bws9m64/ZDHGZdiPhBpnDgDvVTfIzJHqIKeyESp6Slmrg
	 Q4GzzQ3qZpXhpfEzbujMe0GNqSJ3F8aAghvby5dLcN8Lr9iuT/JxiYh1MtxfPgzcGra7A
	 7JT5Z0wo+9Z2OoC5DTLo2qSZXhn2RRsgiUPzOXlrjjiUsFgXTTdqnZ7sy2Lb77Ww0qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AwZhD1dB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PUjxFcO5;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887BF606A323
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 15:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 887BF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AwZhD1dB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PUjxFcO5
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UES6U41954133
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 15:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FGkyxQN9i0NhBdCJIXq1uYlUjDXSlWOx7RjK7fuDemM=; b=AwZhD1dBRmP8Tyfx
	1gG20HuFAU1a2cuph7IGHXKITBF/tFArNX9LK1LpPvrPPoZFKGjx2dyvKX23UtHS
	NYkC50mBMEpZOVwK0tfV0bMtZdQP0Zvygh4pyvHCeT9r4ri8F4LX2NEMOZVdwpUD
	6QvJUXKDohf7O2ixKt6YHDsvU5FIJxo9Bdq44lvTUUM7NEb01ZRu+mAsgTUlWQ38
	IegLbJqK9w6z7wZ1okemLhEV5SHGhUJTHCcHCvKq9Y7JIqtOmw1qK20MFBeke9C2
	qOvzZ1MeVWA8ESRROuge9EQrQq17hFm5TbUAgnxXp4Ijn+ugmae38k6DVkh4gzIh
	etqevA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pkqsp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 15:19:49 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-55bf11583d9so1174176b6e.1
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 08:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793373589; x=1793978389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FGkyxQN9i0NhBdCJIXq1uYlUjDXSlWOx7RjK7fuDemM=;
        b=PUjxFcO5UuWQAUyOCGDsqxJMSJWkqKkSiNJrNLjOTyJi1dNbaQ3X11tJkhD67swXw5
         h9P20caPM/LPQpvjr8Rj1N7/rWs0eDYKGLtR9bDzCRb77mEPdYHWwbBjiDjhXUE2ZqX8
         9eK6/IaCJOUSkrb6lKKJnAKneRBhhQZmF8hEgumQBkTwkYhhezgej+xJNpOcL8OW9Wnv
         NBl3ad+qHOgPv7ECtolCcFFTO45EvnrYIC+sjrMLJgMVynbWQPqvsEW40ByeXzM10pQ6
         1qzjdl/1oNmpFzIQF1MoKroKBCtNyW+kTKMi8fO995jrXrT+jWL8RQVwOkMZXnckqxhF
         0Q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793373589; x=1793978389;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FGkyxQN9i0NhBdCJIXq1uYlUjDXSlWOx7RjK7fuDemM=;
        b=mTHXBw16WsX/IBcVCr836P0UjgrsAkGHZA5oo/2bJ0DuHrAdZQvSusjOcLFb7OTN8p
         ZdcD7/g+QKDW/pe2/VYgqDwb7ryVoi+ipW5bVbUSvYCN6bCkNZOeOSXyVgxXE4VHiiSq
         2gqiKaI8gIG1x2W6ZoRFw4b//vZL+2xLU9PunsxyC1O78uiyzhWgiftfAEtIKHCQSIy7
         DdIl6Ovm32HflFR51FNN+ULOYCSJ/m2zOmsn/fXF8zVzz5taPlMaPdG+TQmbqvxK+Ivf
         W5tUgPpqNDlcBrS9RtNbbVQGwXn34XQtZsABMPZ8YSgVHXr9dFY8yFIiISvGPEBnpTK4
         Lnag==
X-Forwarded-Encrypted: i=1; AKwUvByJZLqRVTFCFOMivt4Lmu60NX3qbJsInGolykxbJ5pED2Qr6XodA7y/JFhdTlRq8EiejyPdUbJ4qMVy@vger.kernel.org
X-Gm-Message-State: AFq9FYKUOtbN6w14K5oNKyCS13mTW1uVxGrRenJs+xU5SAG2OGAvUGDc
	VkKw0kZCd9T9ISokTdXEBERlCuO29lXp3C5GwXlelvpPRlmCnG4UW8tSSTOTqbSCt7B7PoJpjAG
	usxOdJG45wWZMAHNm/H14tNxpkkgs0Q9U0o60OW64lDLOwhMmQvhjB3hQbvGovMOy
X-Gm-Gg: AYBFou3La/rWSmIct4PXk7PkN1orjbzgOGaAZE7TsFBSEqsmgTJlawg7lbRC2eX5qaG
	ST3QO1R+HztFUMz+DQIiTFg5fjFNDMe/jtBELXfr4Xi5lOkCFvM23WASlnV7Kpp8en7otGV02ht
	LB3r0JrCt+KjdlW3JuFN39PLJfImSStMjViHAh+85U8qz0F0bShD93e+7kT6AWJANcoh8zRnuI4
	wgldHbcgNTGYs87x2AviDkJRYvPaNtZEvkSFOPql8o/NUVU7Huv8ThduXgCgUCLG2/W5RhCAk0y
	wGtTZ34L3/mC1aJEh42QzsOpyeGgV9zjCL0VgWbyiahJ/NlUbjknnEn2bkYzHGObeGdmrQsU3H0
	wfEC833Z8zd2nvmNaTdtktgwSEniziyY88LUzZlZUKEaj7rldw5Zwn5ZnDwWBYcIkzMOC8rztEE
	GBLRjRnMC5rbli1XU5OEZ60ZyFIfY=
X-Received: by 2002:a05:6808:ec2:b0:495:f8a5:8797 with SMTP id 5614622812f47-563ef28e71bmr3103328b6e.0.1793373588707;
        Fri, 30 Oct 2026 08:19:48 -0700 (PDT)
X-Received: by 2002:a05:6808:ec2:b0:495:f8a5:8797 with SMTP id 5614622812f47-563ef28e71bmr3103286b6e.0.1793373588134;
        Fri, 30 Oct 2026 08:19:48 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe42454sm1821202b6e.17.2026.10.30.08.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:19:47 -0700 (PDT)
Date: Fri, 30 Oct 2026 08:19:41 -0700
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
Message-ID: <20261030081941.000040e7@oss.qualcomm.com>
In-Reply-To: <43301529-f169-493c-bc59-fa08b77e1ef3@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261020101048.00000186@oss.qualcomm.com>
	<0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
	<20261023142621.00007051@oss.qualcomm.com>
	<20261024003917.283b890d@foz.lan>
	<20261023170405.000060b8@oss.qualcomm.com>
	<at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com>
	<43301529-f169-493c-bc59-fa08b77e1ef3@arm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfX3SaIuE8PSlDf
 5JkQNISoqnr5xbNQlQuKuVmqK81iWP3u2+nFXmHYel8zgwsb6qPfav5B2Rkqvx/xV2YOQzyG9Nw
 /ZLkE4e9yTZL8rKkMOpnWEEJjm2K0kmnbJyKRxj4RVoqNneLnTwwwnIaTvQHYdm960x7x/U64wt
 AzaLsqkPKK54mANpcgRCWgptW5n4sXnSOocUdt0ExnsGInMXd7Ci+l2XQSMT4xwCpO0oHn35rkG
 U01cE58aQJTr8monzv1qYqDQVi/xOzAcFJRey09BTdUNUueBsU71GPSMAj9WrCOmKGuti20V06g
 WwCZo2cWKM97nii1R82ljCdlsyQ+tD1HghBjhUBsc2htXi9EVs8FQ/4tuTSqVdo4EaYxLAYc++a
 EHy4GptDnD4k8JY0m/UwSUWNPbTilRGaT5n9i4bArMMMf+96jyR1tXlnMEMGtC+VYx2S/o1cx5B
 aZbqnoVcdAXuUsJHxHA==
X-Proofpoint-ORIG-GUID: HuuwibGqPrVciKOtPl3g67H161lZhKaG
X-Proofpoint-GUID: HuuwibGqPrVciKOtPl3g67H161lZhKaG
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae4b595 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RAp2bQ1MI6N82g0F2AwA:9
 a=CjuIK1q_8ugA:10 a=pF_qn-MSjDawc0seGVz6:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfXxOhTCttHLxWF
 CB04sDHoctTaoEcNK5fwU4u3JJiZXmfV+i8HgIDqjDVDAesF4nmPfNo7BXwCPrl4HkBv6/iKvgq
 p/1m3sm1lZ9v+/A6/b8mAERB5g1xWnc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300061

On Fri, 30 Oct 2026 12:51:47 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> On 10/25/26 00:05, Ashok Raj wrote:
> > On Fri, Oct 23, 2026 at 05:04:05PM -0700, Jonathan Cameron wrote:  
> >> On Sat, 24 Oct 2026 00:40:33 +0200
> >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >>  
> >>> On Fri, 23 Oct 2026 14:26:21 -0700
> >>> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
> >>>  
> >>>> On Thu, 22 Oct 2026 09:07:25 +0200
> >>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>>>      
> >>>>> On 10/20/26 19:10, Jonathan Cameron wrote:  
> >>>>>> On Mon, 19 Oct 2026 22:38:39 +0200
> >>>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>>>>>         
> >>>>>>> The support is mostly duplicated from Memory Error Section handling.
> >>>>>>> Other than differences coming from the content of  Memory Error
> >>>>>>> Section 1 and 2, differences in the support are:
> >>>>>>>
> >>>>>>> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> >>>>>>> This structure was used to support older versions of the Memory
> >>>>>>> Error Section (1). This is not needed for the new structure.
> >>>>>>>
> >>>>>>> - The compact version is also used by the tracing framework.
> >>>>>>> To avoid relying and propagating a non-standard record format,
> >>>>>>> through trace event (cf. extlog_mem event) the new trace event
> >>>>>>> prints each field individually.
> >>>>>>>
> >>>>>>> The last patch of the serie was only build-tested due to the
> >>>>>>> absence of relevant hardware. apei_mce_report_mem_error() and
> >>>>>>> arch_apei_report_mem_error() implementations were also removed since
> >>>>>>> last version.
> >>>>>>>
> >>>>>>> It will also require a proper handling from the rasdaemon. Applying
> >>>>>>> this last patch without rasdaemon support will silent the reports of
> >>>>>>> Memory Error Section 2 error, cf. ras_userspace_consumers() check.  
> >>>>>> Hi Pierre,
> >>>>>>
> >>>>>> I'd slow down a bit.  We are mid merge window and convention is normally
> >>>>>> one version a week or so anyway.  Better to gather up feedback from
> >>>>>> a number of folk and spin only one revision to cover it all.
> >>>>>>         
> >>>>> Hello Jonathan,
> >>>>>
> >>>>> Ok sure, as the v1 was reviewed quickly I thought there was a chance
> >>>>> of having the serie accepted quickly aswell. I ll wait a bit more.
> >>>>>
> >>>>> Thanks for the review,
> >>>>>
> >>>>> Pierre
> >>>>>        
> >>>> A general question that came up in a related thread with one of
> >>>> our RAS architects. How does firmware decide what to send?  As far as
> >>>> I can tell firwmare has no way to know whether the OS understands the CPER
> >>>> Memory Section 2.
> >>>>
> >>>> So options that come to mind.
> >>>> 1. Firmware must send a CPER with both Memory Section and Memory Section 2.  
> >>> Please don't do this: this would require either Kernespace or userspace to
> >>> discard one of the reports, only if the other one is there, which can be
> >>> tricky. Could be done more easily at userspace, but only if some database
> >>> support is enabled, but, at least on rasdaemon, this is an optional module.  
> >> Good. That confirms my view that is horrible.  
> > Hi Jonathan,
> >
> > I agree that an _OSC capability is the right long-term solution.
> >
> > Firmware should select one native CPER format based on OS support, rather
> > than emit both Section 1 and Section 2 and leave deduplication to the OS
> > or userspace.
> >
> > For a Section 2-capable kernel, we may still avoid a second GHES notifier
> > chain: preserve the existing struct cper_sec_mem_err * contract and give
> > it a lossy Section 1 projection of a Section 2 record. The conversion must
> > translate validation bits and clear validity for values that cannot be
> > represented, rather than truncate them.  
> 
> I understand we might want to emit a new extlog_mem2_event and a lossy
> extlog_mem_event for legacy userspace, but I'm not sure to follow how
> you want to do it.
> 
> Do you suggest that we only need one notifier (ghes_report_mem_chain)
> and that we should not add ghes_report_mem2_chain ? This would mean
> that the .notifier_call (= ghes_edac_report_mem_error) should handle
> both cper_sec_mem_err/cper_sec_mem_err2 struct.
> 
> Another solution would be to keep the ghes_report_mem2_chain,
> which would be responsible of creating the lossy v1 struct and
> triggering the original ghes_report_mem_chain.
> 
> > That preserves legacy EDAC consumers, but cannot carry all Section 2 data.
> > Updated userspace needs the native Section 2 payload through a
> > full-fidelity path, such as the existing GUID-tagged raw CPER event.
> >
> > This does mean an updated userspace listener may receive both the legacy
> > EDAC summary and the raw Section 2 record for the same firmware error.
> > They are two kernel views, not two firmware reports. We should therefore
> > add a shared GHES record/section ID to both events, so userspace can
> > correlate them reliably; address and timestamp are not sufficient.
> >
> > So _OSC solves firmware selection for old versus new kernels, while a
> > Section 1 projection plus the raw payload handles legacy versus updated
> > consumers on a new kernel.
> >
> > Thoughts?  
> 
> This will put more burden on the firmware, but this seems the right
> thing to do. I ll share the thread with the group working more closely
> on the architecture aswell,

We have will have a code first proposal for the _OSC part shortly. Just going
through internal review.  I'll make sure you + others here are on the +CC.

J

> 
> Regards,
> 
> Pierre
> 
> 
> > Thanks,
> > Ashok  
> >>>> 2. For whatever other reason a platform knows it doesn't work with old kernel
> >>>>     so can assume support in kernel and hopefully userspace got updated too.
> >>>>
> >>>> 3. We propose some additional discoverability (quickly - code first) to ACPI
> >>>>     so that it can be a negotiated contract between OS and firmware.
> >>>>     Until the OS confirms it understands Memory Section 2, firmware has to send
> >>>>     the older one (or risk the record not being understood).  After that
> >>>>     negotiation it can do what it likes - probably send the Memory Section 2 form.
> >>>>
> >>>> Option 1 and 2 are ugly at best.
> >>>>
> >>>> Obvious path to me for option 3 is an _OSC like the one for generic initiators
> >>>> that we discovered a need for whilst implementing that years ago.
> >>>>
> >>>> Anyhow have a better idea?  The above doesn't solve the end to end problem as
> >>>> maybe userspace still has no idea what this new tracepoint is, but at least gets
> >>>> us past hop 1 (so through the kernel).
> >>>>
> >>>> If we conclude _OSC plan works I'll draft a code first proposal.
> >>>>
> >>>> Jonathan  
> >> On another note, Pierre, any plans to actually enable a path to the tracepoints
> >> on arm64?  Today they only emerge from acpi_extlog which is x86 only.
> >>
> >> We definitely want the richer data for PFA and obviously for userspace nice
> >> to share tracepoints with extlog.
> >>
> >> Jonathan
> >>
> >>  
> >>> Regards,
> >>> Mauro  

