Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800253;
	b=WpACFE/cjD9Z/ueR5iK/I9GcERJ6NTjTAlcSDHm59waERMXz3h4CT5LIJoueMpUNsuSR
	 a6PTfvkZ/sFRZIEzODKbg0ELdKY2f9o+4+DwPpLTryA4hJHrXtWA099KitwBW4CLLnWQp
	 qPVhktbXOEEAHC1bx0TGVi3YXe7vG97SrZowx5GhXBRyQpGgT49UUGIPNAAgbKljZKncJ
	 AZ4zBj2sVbrng/CJOzysOzCBU3t3Un1r7tSlE/Ulo9g+fFBQ0N8OIgdC/R4WiqCTjbCdn
	 zMoaElvXZxJsV/x9QoTTp8Tg374uTqtFEv1HN5Olk2ECafoTHa4PWQdIO4SAt3HtVlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800253;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=I3wuHmWmGvXCtEnDUsJhkbmfuPnqQvs8DG+95QVzPvo=;
	b=WtvBpM9AkRGbZ/a+/jE28qob8hxWC0KiErdK2qll3TIWpfzOS/A8yicHtLiSigxZ4smK
	 rh1IqILkKJYF6lTXG76+cfAHXcDWN6X8C/bz2f6m553AjhUP6V7q8TsuiTscphzclcjb2
	 4Fhu3z/iK+Fu9dbBuidLyI5fUxiTmskkUaJ39WJuMADrCQxaSMdymstK+5y8jibB2Br1x
	 Ly3o71wsKG+VCj8LjpI1t4bkdi47RB7QkuMNFel+cswR1LuVFEveimvWaS+zJDzw+FADx
	 LBf1xE8pLQOyEH+CY46l3nqlP89R8dTLgL0pt5eIawO34fULJbeMUwb/jFUsEc2eoNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jNkuuk4I;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XpdGgF8o;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C971B606A321
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 00:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C971B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jNkuuk4I;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XpdGgF8o
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLvAWm296942
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 00:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I3wuHmWmGvXCtEnDUsJhkbmfuPnqQvs8DG+95QVzPvo=; b=jNkuuk4IgwSv7LIN
	QjlEVqboix2Uhx3LX0GdsDVcM6gUaaZs9kfYdLK/tTA6awMBcp8eeSDtJ5/Fh7ft
	kUFgaIP7onQ7cW15aR+Nl/e9uLd/67A3y2pLZ7t43M+OfhmpVdcoEA8eyRaHULwr
	eQxDVRmG3yH/yXhN+QXkXwvgaWxhzbZ3Z/10JKKeG+3WRlKz3fH36pSSgsyOOasj
	t54pvJx3PEso5l0PZYq4Uh5mddeqLRlSFwMkbREj959unA+uLDqpuZ0J6LnLHV+x
	vY5Aq7hxo41J7IjIZOEeArheZjJPw1Qu6/KEdjFDbgbvnqPPtTZ6UE8ukXlBmLB8
	4BNO7A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgaruhf90-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 00:04:11 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-147be78cd56so5373795c88.1
        for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 17:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792800251; x=1793405051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I3wuHmWmGvXCtEnDUsJhkbmfuPnqQvs8DG+95QVzPvo=;
        b=XpdGgF8oJKomOqDi6fHoNN/xUmBCGsC4QQeoFCk9eDAtRsvl4Sh8rQ3flhFYrRgQIJ
         7pVk2gl9iyWX0s26gwcr4XZOteVmIZboA/QzBfVDlQPAvZ+zHx9yiWFwjylMVbfgEiFZ
         2+Q73IuYRNMWbpmmbJLUdlKa6P8AhBTVfzRtnTVhIzJQDKAWnuf8V/r7fC2nPnVUI5PJ
         w33tzH/lntSn82YzIQq1uYuaL0bjppH2P4yp9xoLaQqL7p15PfQLIFTnw6oFhR4+RXut
         u51NEKF7rh0EWN6PHeBDW4p4V3m7IZead7+qHJmDQvBlNGXsyK2LQRPmJiadVm/C6bPw
         /JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800251; x=1793405051;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I3wuHmWmGvXCtEnDUsJhkbmfuPnqQvs8DG+95QVzPvo=;
        b=GLNuFIIDxPrebqYExB/xc5Emc3Ph8v9j4o0s5rmrVBpnIEOHD3jMokQxdVvFgoVShP
         60134cngNEI/uqUhdxLaya1MrDhtGli+4VIFAzRMvOoR3Q+K7BTIEDmzCc+UFa11f/zh
         uBBZBdeKD/CO+y6hjUXBSJ8fUGFAhptNrYXxZp9zCcv68ewHS5lU+iBMyRcwXzDlcTGu
         y0HCZG7LJicRUhsp+k8veZ7SG9SPBGQET9iC4HjfYtZQe9xQOnoM0dNcp6/w/WYAS0My
         xiyARhY7ovF7osI32VyYlNdFME+Qhgz6gA54PDjG/u9wnDmmvVWdFrah9tum97coRMla
         Ad8w==
X-Forwarded-Encrypted: i=1; AKwUvBwEzdFLB0W1A9MzFx1CV4W1++2hgzlyFVC0gDA+HmU/wbsobOHo9VsAGGNCPd1nNTnxdnpB2VfpRKTb@vger.kernel.org
X-Gm-Message-State: AFq9FYIjxYzlbDWF/+4kNVMuvyOkkJBecBhJuTiX5OG10vxX4EH5QnoU
	EsAUrWXDjkemxs9ag+Q5qLdf8vL7feHIcPFjMFUKsEjmqDkGqLx5R6zAZSJPi8lfoFCAmr9wv3M
	nuPmIIObwpJegvoVZ/lC73lYRlEbhTXVEq3ZmjZtjFPJP/sEz0P0mHJO8ygwX0FBF
X-Gm-Gg: AYBFou0uQ5VqV5ljPWvykw/kW//C1+o9w4i8GC+DntO93TNJmel7UAzBGyyXXMxqCvO
	maob9DZA6dBjaVEmkB0Uy3doWp2UIM/8D9EMQPEgOGaPt8442QHLnYtkIDIqUDfYJuQnCAF4fbl
	RxT1fRI7OF7OlwwjmiVOj+OB1AE/aWuk11jzQ1zokWPXhFELvBO+62Ae+jO3MLgh537K5NhZNx+
	uQ42bhOrkwXX++pXl2jkEVZ2Vdl8QDUHscI08XPlEb2HRgTAByILfxa61GgsGuGagRu9NxXpmid
	RkxaSC2yiW/5yX1qhGXoUUcllFlCbWJM81KVX8c0+sKX2Eqn794HRiGiahGZh8T/SgQDA2lB+SN
	+UVn5Hkz22STBzxtXRzb9FWtA0ILbaGM/Vxue2DGW2w33HBk5Kki3Vw==
X-Received: by 2002:a05:701b:280b:b0:192:e5a8:6bae with SMTP id a92af1059eb24-1993fe812c8mr601077c88.40.1792800250470;
        Fri, 23 Oct 2026 17:04:10 -0700 (PDT)
X-Received: by 2002:a05:701b:280b:b0:192:e5a8:6bae with SMTP id a92af1059eb24-1993fe812c8mr601041c88.40.1792800249918;
        Fri, 23 Oct 2026 17:04:09 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0d98660sm1757914c88.9.2026.10.23.17.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:04:09 -0700 (PDT)
Date: Fri, 23 Oct 2026 17:04:05 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Pierre Gondois <pierre.gondois@arm.com>, Tony Luck
 <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>, Mark Brown
 <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuai Xue
 <xueshuai@linux.alibaba.com>,
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
Message-ID: <20261023170405.000060b8@oss.qualcomm.com>
In-Reply-To: <20261024003917.283b890d@foz.lan>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261020101048.00000186@oss.qualcomm.com>
	<0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
	<20261023142621.00007051@oss.qualcomm.com>
	<20261024003917.283b890d@foz.lan>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5NCBTYWx0ZWRfX4KylRH/S7nRp
 Y+bToxf4NVdP9Qtn7s2/yZIKwHgsDh7m67M9dHsiB4Ota3L+Xouz5czvtGZ+2LyXAGAatu9aGSK
 0FvdejYQjt2ClwaW+FyBNiyEzHJl0xc=
X-Proofpoint-GUID: gjzCzG28k8ToSaH7PtrI0cRe1BfdBy5b
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adbf5fb cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=x053eCT7BGEYFa6Myv8A:9
 a=CjuIK1q_8ugA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: gjzCzG28k8ToSaH7PtrI0cRe1BfdBy5b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5NCBTYWx0ZWRfX/h1jzjVisOML
 apM8+QumoW8Y70zzqU5yKWuN6yoW6Zk2XkTU7OOsXk8mLCKzb6e9nvFEht6RHWT+bzmum4MDLZC
 dTFW9bZQmVub1X+lRzCQKz6RblduACGEkTqS5qPy98EyXWwGXWeSOb/fq5x6i7AVmco8GfVlnkF
 6B1F++z2weZEP6Bktrc5nPWJykPN0tpZEoxfjWN2BsgYmwRb4TzbAtZo8JE+2H8bG/VIUBCtFEX
 4mdy2TughCvlCdpdpmUFdKoZWK8GFa0AaR28TD3poLhKGI+ESZzwUCL2IKY1Z6NlO2EK167G/D3
 3KKGYptdlVok4tbUlIvM0po/mOAFibJIFGTOqBSmi8D53Duhu6Vgdy7ZNgnCH2Fp+2Pe7aJX71W
 prQsobshcWTPf0M1Nu80BzmjJoQMQJxcSv6CJ1B2d4wsVzYskmmWl0zADN2nJAm4HIjS79hEVmC
 3k8M2Xu0T7JGCJjiYDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230094

On Sat, 24 Oct 2026 00:40:33 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> On Fri, 23 Oct 2026 14:26:21 -0700
> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
> 
> > On Thu, 22 Oct 2026 09:07:25 +0200
> > Pierre Gondois <pierre.gondois@arm.com> wrote:
> >   
> > > On 10/20/26 19:10, Jonathan Cameron wrote:    
> > > > On Mon, 19 Oct 2026 22:38:39 +0200
> > > > Pierre Gondois <pierre.gondois@arm.com> wrote:
> > > >      
> > > >> The support is mostly duplicated from Memory Error Section handling.
> > > >> Other than differences coming from the content of  Memory Error
> > > >> Section 1 and 2, differences in the support are:
> > > >>
> > > >> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> > > >> This structure was used to support older versions of the Memory
> > > >> Error Section (1). This is not needed for the new structure.
> > > >>
> > > >> - The compact version is also used by the tracing framework.
> > > >> To avoid relying and propagating a non-standard record format,
> > > >> through trace event (cf. extlog_mem event) the new trace event
> > > >> prints each field individually.
> > > >>
> > > >> The last patch of the serie was only build-tested due to the
> > > >> absence of relevant hardware. apei_mce_report_mem_error() and
> > > >> arch_apei_report_mem_error() implementations were also removed since
> > > >> last version.
> > > >>
> > > >> It will also require a proper handling from the rasdaemon. Applying
> > > >> this last patch without rasdaemon support will silent the reports of
> > > >> Memory Error Section 2 error, cf. ras_userspace_consumers() check.      
> > > > Hi Pierre,
> > > >
> > > > I'd slow down a bit.  We are mid merge window and convention is normally
> > > > one version a week or so anyway.  Better to gather up feedback from
> > > > a number of folk and spin only one revision to cover it all.
> > > >      
> > > Hello Jonathan,
> > > 
> > > Ok sure, as the v1 was reviewed quickly I thought there was a chance
> > > of having the serie accepted quickly aswell. I ll wait a bit more.
> > > 
> > > Thanks for the review,
> > > 
> > > Pierre
> > >     
> > 
> > A general question that came up in a related thread with one of
> > our RAS architects. How does firmware decide what to send?  As far as
> > I can tell firwmare has no way to know whether the OS understands the CPER
> > Memory Section 2. 
> > 
> > So options that come to mind.
> > 1. Firmware must send a CPER with both Memory Section and Memory Section 2.  
> 
> Please don't do this: this would require either Kernespace or userspace to
> discard one of the reports, only if the other one is there, which can be
> tricky. Could be done more easily at userspace, but only if some database 
> support is enabled, but, at least on rasdaemon, this is an optional module.

Good. That confirms my view that is horrible.

> 
> > 2. For whatever other reason a platform knows it doesn't work with old kernel
> >    so can assume support in kernel and hopefully userspace got updated too.
> > 
> > 3. We propose some additional discoverability (quickly - code first) to ACPI
> >    so that it can be a negotiated contract between OS and firmware.
> >    Until the OS confirms it understands Memory Section 2, firmware has to send
> >    the older one (or risk the record not being understood).  After that
> >    negotiation it can do what it likes - probably send the Memory Section 2 form.
> > 
> > Option 1 and 2 are ugly at best.
> > 
> > Obvious path to me for option 3 is an _OSC like the one for generic initiators
> > that we discovered a need for whilst implementing that years ago.
> > 
> > Anyhow have a better idea?  The above doesn't solve the end to end problem as
> > maybe userspace still has no idea what this new tracepoint is, but at least gets
> > us past hop 1 (so through the kernel). 
> > 
> > If we conclude _OSC plan works I'll draft a code first proposal.
> > 
> > Jonathan  

On another note, Pierre, any plans to actually enable a path to the tracepoints
on arm64?  Today they only emerge from acpi_extlog which is x86 only.

We definitely want the richer data for PFA and obviously for userspace nice
to share tracepoints with extlog.  

Jonathan


> 
> Regards,
> Mauro

