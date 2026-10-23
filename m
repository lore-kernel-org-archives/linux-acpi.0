Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790790;
	b=QbN7K4U7eCFgBRStCeoiDLrT9P5wIeKR2bN8z30YqvbUkwiCF9K33fmXKImyRf3LALFT
	 iMLNV9vbvxIT1K4rTWT7WW2ssox1NxJH8mU/4tEXFOSwhQ5FAuLHhid3VnDPDCTNaFxLM
	 f4hZEjNovxt1WxtHv/oOC8IncN0upsaQPAJqsr75+OjKTQXB+QuITYZWXud15VVOn/ugU
	 KJT0hwanCwByXaxb49TqDiBn7BXajTvQ/5u3unVCICjGMcVPU7g4Wv64oB3yi2dJ/IQfR
	 +CnQLiEEEOoPjp6aWEa/90yvMFxQE3HRgo8NIgZT8JDlUeOz9pQIBAz8LDAWs/f234g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790790;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=onjC+0/JB/EMzeywRoMR9YdIXgcyM2qGbjpbSI4T3h0=;
	b=1hV1J8eeLC1GEONeG/jImATs+fF23EpaEJkjRAuRxYU9C7UpUlyWtdsY1w3BC1dJpGhl
	 eR4a5xn9KMad2ljt+qdUN3uzols4R4mTVxviAa6B++AZxTzG9xTrK/g3q3f2K5x9niSP8
	 eobeaXY7bPSxP+Nk8GcTbVdKnPkMcYiKypW59pHFYANNCEuzIZ7SMVedAuKmC2laE9qwe
	 KjaTBDCRHn0/A2BIz4ncwxjQT4MVkapvzZBvQs1bnyXxei9ANl01rdkSPJIsnCp44IL+Z
	 hoQejViXLbgZUDr/DntcCmDzKu2hVgG6Su7MStL7RCASG2zbA7QND87Ge5MNkGRaOWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HRnNMC+Q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VluYqfcK;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51BB606A31B
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 21:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D51BB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HRnNMC+Q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VluYqfcK
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NIZKlX3047654
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 21:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	onjC+0/JB/EMzeywRoMR9YdIXgcyM2qGbjpbSI4T3h0=; b=HRnNMC+Q6WSd7YsH
	RZcrFxdaoCMuhrteHUqGKX3AkmhklMoyZ/cnmcyrc35ASxrxIEE8JA9999/TAR0a
	28AEarTbNWLmVQxHLdal8A9BJPiuN//4x1dBC5o998g2pi+jbfzFmyD+Fz/hQBNS
	Do0nkv/8rq81UF5qKDK3gPhxUSkrsH6EUnwVD0JqfCOfzXPdAoihGPBRqaUSEOK/
	IvgSn/8FuzbbiYsRcUSi2gxL1OnN+XNzK0eJSYq/9IDb+aFXYiovcASXrnuuL+ZA
	JGVbXs4Cy9nQAtXMD1feWK69CqjLqBy4MSK99b9xb3smeWxCpbTE/rXMLr/XWEhB
	K/2oJQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcrughy1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 21:26:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3552883bd19so4188208eec.1
        for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792790788; x=1793395588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=onjC+0/JB/EMzeywRoMR9YdIXgcyM2qGbjpbSI4T3h0=;
        b=VluYqfcKMa0g5yFYadpgV3E3o/8WWXMbgucE/k/+zOHPIx0g6E3+jVga6bwqslSZbY
         N1ihBQlGpFFwaJHUAKY3304PeHqg9p+V6nSd2gZF1uQyPKRVkJuiKQn1BoRFKvkt5wST
         TeYd1g8/2VmbE//AG5J+Ns79J6ZHG2SAFkLr3y9z+dfTB80eIpRNCGncaw7j6M4qz3qu
         XJXyWw6LDtD72JO4z/sJKgA7OOHxI1FCcFfr4P9AfKiO1I6uVu2JjbByvx9xEGo0fb7V
         +Xhm7/vgtJXPo9HS1fBTZ3r2G1UDa1NzUoG3nHFfmjIsZEJ1FHnQtEpBi1ICimt2JgKb
         NwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790788; x=1793395588;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=onjC+0/JB/EMzeywRoMR9YdIXgcyM2qGbjpbSI4T3h0=;
        b=ph14kBhCGvOQyr/ZeX04eI1iV/1fhMItK51fVwmzaJljHx9RGPIB0tbBTjOn56KgrR
         xxWEcvjMzD48U8izJUJ1IRhuhLkaR4eIjGCfk5uBSX80KA3VEHlDQ5XptKyzc8h6r3dR
         SNkkTGVvPdcDAynVUPw34S76NpS1DqiymxJBDqAxudg/mGjk+Prc6i9nZKPOOtNwhKPV
         5VeMUduvgZZUxskCVTUTX1TDMjAW4pavRJrJDKUuTY8LVZQXhRYgHBDcbLOFdNIK4MKo
         DewbNiJInSMD/w26Htd1ZC4w/sK0DlHcpEZQdBaZrErmx/vps/ihgjKOmAke2HOXPPeN
         uOhw==
X-Forwarded-Encrypted: i=1; AKwUvBxpTh1KXled3b1peTs5QYivFMS3ZuCsyDbjjXSQRHPlEL1ciYHkj9ZL81B7vMhrHXQJZu8oAILI3RM9@vger.kernel.org
X-Gm-Message-State: AFq9FYJuAqQuKkya7tbqIVzBw8GhiBS1bEGndpIHUbnYk+q5yxkIO+mg
	85Q4PADoQi385Ii9SyhlHeMJHuAOqx4VmHLbKNO+DAXv+A6QBBP8wnsmOzK0nVVl9L7OozFO/wx
	gPTodFCzqL72i+Ov0Jc9nQ/VL+MyKIUI/221z4/498iRXm+IvyGnboRcBAJY+coP3
X-Gm-Gg: AYBFou2F+fuVyhUFT7swFa1L9OJ++kmXSC3RyQcAUKwYiKY2Wq0BuGaRh6365WzidTD
	l7Vz1d9vY+/EWenf9hyNQqeH+PAkz41yWCUle0t25Ww4OUXAxfs0zdoQ2cYz+VCxN+e6JpClJxW
	LkRhHSN3W8tSwnHLxjmHWH/2WOoLZHNZDB658CNR32YHpOOyr7mpfIOiuL0uz5mFJGUblVbRhqk
	Ycbu9ksp0ZwbSaTgwKAP+oRgnSvhDAzgtiA+PrKWeYRlFVerTEJNozr1Wqaireq7UGgHUlBThWD
	jOW0biUDwpF9rCts2+3uSLONSjvgDKFBkmWyvQQ61mhu6IzGHAzlygE9KtpYcsgevzXOzgS1UZq
	rI38UQgjRB7xZ4GnvxQE/hVeKjGDQ+bffCixWRRmf8K4C5UvK6ophJw==
X-Received: by 2002:a05:7301:2f31:b0:369:d8e1:7bad with SMTP id 5a478bee46e88-369e84d7714mr627758eec.34.1792790787905;
        Fri, 23 Oct 2026 14:26:27 -0700 (PDT)
X-Received: by 2002:a05:7301:2f31:b0:369:d8e1:7bad with SMTP id 5a478bee46e88-369e84d7714mr627705eec.34.1792790786964;
        Fri, 23 Oct 2026 14:26:26 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8afd64fsm1007158eec.0.2026.10.23.14.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:26:26 -0700 (PDT)
Date: Fri, 23 Oct 2026 14:26:21 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Pierre Gondois <pierre.gondois@arm.com>, Tony Luck
 <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mark
 Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuai
 Xue <xueshuai@linux.alibaba.com>,
        Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>,
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
 <ashok.raj@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
Message-ID: <20261023142621.00007051@oss.qualcomm.com>
In-Reply-To: <0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261020101048.00000186@oss.qualcomm.com>
	<0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4NCBTYWx0ZWRfXyrektTYqdY0x
 pp8gXE/0WnKJhxxg0Ysjke6ANfr/RY+HymDrJDwYHpyGRueJVYq5oqsNFvMGjGb15ys3MPmxzN4
 2ULWANq1xu66ZZl3vZcnu19D0bo9qNk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4NCBTYWx0ZWRfX3WyOo02Fdfdt
 URuSUofBeQLyY3GhcTR0xQqaIVqkOtUOltvRYHtKQj3hsJylI8aRVnbKxJak88ug9QwOKTrXNrX
 KF4sVoQv57tYGroNM5aY/JfHjptzR4WkOA3cUwsJ5K2nHl2+jIrG/i3l7bJ6K5Y5DUs6yPzpHSL
 xcvTd3/x6RSw6V65hnWxdkzzjwnsJNzBLgbv9UxHSe9VJIWRrzsRcuPLUmB4YAOq/UX3AfTS5s2
 BRAndFOgaFeBbsJ2CrMDNeHcfhtG53jhEgkQHulJbo0mcO5P1lepkXpAiVW99MQ5alOAEIroc6I
 G6lP2M86qQ2pPgp2ZoMXjJSV4H/k02I85mqP1Y5zWcsR53rKd3O80y88JGtDmHr8NwGk0l92rrC
 2hGnwh4bU0xoaJTsSW8FY8eqaVxu1DChA4ai1vF7+sN5I+j+TI22XCoeqAsmKY8nhObrYthHclY
 5HGFTexpbCWff3n5qEA==
X-Authority-Analysis: v=2.4 cv=Ju5kP84C c=1 sm=1 tr=0 ts=6adbd105 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7CQSdrXTAAAA:8 a=viUReOrFISyjNDj8nWYA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: MS3ISfAgKzH99u3BMIbf76pjDgq1q7Ok
X-Proofpoint-ORIG-GUID: MS3ISfAgKzH99u3BMIbf76pjDgq1q7Ok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230084

On Thu, 22 Oct 2026 09:07:25 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> On 10/20/26 19:10, Jonathan Cameron wrote:
> > On Mon, 19 Oct 2026 22:38:39 +0200
> > Pierre Gondois <pierre.gondois@arm.com> wrote:
> >  
> >> The support is mostly duplicated from Memory Error Section handling.
> >> Other than differences coming from the content of  Memory Error
> >> Section 1 and 2, differences in the support are:
> >>
> >> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> >> This structure was used to support older versions of the Memory
> >> Error Section (1). This is not needed for the new structure.
> >>
> >> - The compact version is also used by the tracing framework.
> >> To avoid relying and propagating a non-standard record format,
> >> through trace event (cf. extlog_mem event) the new trace event
> >> prints each field individually.
> >>
> >> The last patch of the serie was only build-tested due to the
> >> absence of relevant hardware. apei_mce_report_mem_error() and
> >> arch_apei_report_mem_error() implementations were also removed since
> >> last version.
> >>
> >> It will also require a proper handling from the rasdaemon. Applying
> >> this last patch without rasdaemon support will silent the reports of
> >> Memory Error Section 2 error, cf. ras_userspace_consumers() check.  
> > Hi Pierre,
> >
> > I'd slow down a bit.  We are mid merge window and convention is normally
> > one version a week or so anyway.  Better to gather up feedback from
> > a number of folk and spin only one revision to cover it all.
> >  
> Hello Jonathan,
> 
> Ok sure, as the v1 was reviewed quickly I thought there was a chance
> of having the serie accepted quickly aswell. I ll wait a bit more.
> 
> Thanks for the review,
> 
> Pierre
> 

A general question that came up in a related thread with one of
our RAS architects. How does firmware decide what to send?  As far as
I can tell firwmare has no way to know whether the OS understands the CPER
Memory Section 2. 

So options that come to mind.
1. Firmware must send a CPER with both Memory Section and Memory Section 2.

2. For whatever other reason a platform knows it doesn't work with old kernel
   so can assume support in kernel and hopefully userspace got updated too.

3. We propose some additional discoverability (quickly - code first) to ACPI
   so that it can be a negotiated contract between OS and firmware.
   Until the OS confirms it understands Memory Section 2, firmware has to send
   the older one (or risk the record not being understood).  After that
   negotiation it can do what it likes - probably send the Memory Section 2 form.

Option 1 and 2 are ugly at best.

Obvious path to me for option 3 is an _OSC like the one for generic initiators
that we discovered a need for whilst implementing that years ago.

Anyhow have a better idea?  The above doesn't solve the end to end problem as
maybe userspace still has no idea what this new tracepoint is, but at least gets
us past hop 1 (so through the kernel). 

If we conclude _OSC plan works I'll draft a code first proposal.

Jonathan
