Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879545;
	b=XxEFhYv/dm9vKB1aAkeNEl6GAVi66HHMlkrDJfJAFREghuBCEyGNb8ueEitIMKzU4Huv
	 76DbDjXpVqqIXvrLG3Qwhp5P5L0CGNER524ycitBYcoiyOPjgqccrvhbZRFyKyetwyDoX
	 AYwuvCJIYIju05u7XvDY9YJnUc2s13DmOX39T0iBcZrNHqcYzw5S8V5Ob9GVodOE0TtHC
	 1XK0k27RfE6zReBv4IdGWWCnfEkLIbX7AALkrbXuKVdTL1GZb5ERSJwfyycTx9qHcnN/h
	 E3Mf7tJ/rK/WO0U9Rr52ZGD9+V3IqggjY3xKiQ16l6vSzb5nDGXBeXqyveBshfh216g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879545;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8kVrNNwECi/pBgLtq3kn4zJJZjFdKtfvJtknlnpxdJ8=;
	b=wgcKGab+h0rzK3mjdvnmnxygtarBbN0HUYsPs+58+If70ToNN/ShirynDZU5Io/A8VEz
	 Q/F7bdrOv07HQ3wgZrM599GTZrxl6UAbQjM59w6DYYQf+aj0msBGmZPOArnf0mJLfWSoa
	 2qhTkSzJ0aOgmgGQfkB1kM1Kos2sZR5Xby5p9LGKH2BfvxzxmqQeesRrlRND+lWpMPRZW
	 BuxxLMYsqmh0XAa9FAntB1XVQ6QgyG4/VC2mBmzcfw/THljpeAmLmIpaYOoouEpTPZMJw
	 CEGE4vtulVWWZmpcHIEj0NIUAv93sjgnFs8zXgYirAYCmDshgMV3UZqLgqGEJmppr2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EkULdcR1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KZAufTLC;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46D606A31D
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 22:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD46D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EkULdcR1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KZAufTLC
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69OLbCdE3751202
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 22:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8kVrNNwECi/pBgLtq3kn4zJJ
	ZjFdKtfvJtknlnpxdJ8=; b=EkULdcR1W7J1DWJ7fuajGh1OltMM/HIW7ISBoMnG
	1SZYxKXb0cBdx4bcHvLUUzPzuMg0RLERHpFi2duhPcczNf9MDmP4CRy4xnsg6z7e
	NfYWkQXvLU2YEXN6NcxVFy2Ib9AkhzzYFY1h5RrDYHRNz7R4xkN81FOwINetckcW
	sbarvaT7AhrCCiRM5C7isD56tlZAlokwAsavEI1exfCGU/ekMZT/hT1LtIrazsQD
	kfoUno1TRqN8HfViLUmKxWxEKNs2uz0pak0H68U3NNvJZy6S+GJQjJ2NByZqRDR0
	neUM82luDMwYuHra/XXMOkXd3k6BE4GSrWFczlz+z4kBhQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmsa0r8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 22:05:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3510d0baf63so5268657eec.1
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 15:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792879543; x=1793484343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8kVrNNwECi/pBgLtq3kn4zJJZjFdKtfvJtknlnpxdJ8=;
        b=KZAufTLCzpdUsBdE0S8qYmf9s3FPhrMCVxIJgdAL2D47amOoPekAFVaRGkaosU6D55
         XZFQeeDJI4kbH9QM7GAOZ24lOQjq9a5FJrau85J+WFRRZI9nwz+PUpLMPFgOyD8JnBmU
         ITLjVl+y58PjerjvngeG2yt51ocG7ZLKGeYN5J7zIX5/7Ijy9IyVGYIR8VwreMvM2gbr
         BTDMl1fBNtLi6KSkdf4hcuou7n8Mg3f+xMBDLTLitb6fTtbl0cv9i/TeILfzz0ZWJgDj
         4uAOP57G3VUiZgV9Td8j171M1xY76mZv8rrgGGVKV4x8KvQVwyUkVfFymjVcJomt8+iz
         D4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792879543; x=1793484343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8kVrNNwECi/pBgLtq3kn4zJJZjFdKtfvJtknlnpxdJ8=;
        b=xOFOhxdqDNZJSV+sFw0OliHXWEGFuMirbPjlyFAZbCwD2XsberskuIpX+q8Xyvs5lX
         Aej3GyQ/2btuRZNifWmXjZ9SKHBixJlGGf4QQ5Py6fNsdQxyssVBjV/twSeLXMRxN/5Z
         aDdyEz0LUh+2zTcTJyDTfG3IryrRVA8sL4hIZjE3Vp+4Bx7hP2FsIe+aKALHogOuvF6X
         phMH9mrRsf6/B9i2M5V4v6D5UxBMjQDYUv47ZH+J+mfXlo8rPSJL0LiIW4p4AqJSMY5v
         i2lahUWkkJAaQX52ByEoPdAQ+3C5VzOAWR8sfeNu37HN5vHelMqUN3AUemxqmj1HJjFL
         OK2g==
X-Forwarded-Encrypted: i=1; AKwUvBwG4gjeuFRFf9vATfG8uaXvvQRHqmkINurfM/rA39BzEKBO/a1XBcHqHKPqBvKG2L8Vi2RgX9uMOYVf@vger.kernel.org
X-Gm-Message-State: AFq9FYKseUrH5jSadt8r+OpPM2LD6ElbtcRBRyI3+/F4HBK6PKh6Wa6B
	2kWkkVcfX+5PBbxz6v7HZieMYsgL/51ZfsOF8wicBkI1+jSSANzWFY1IVP7vNGsKZEy5r9W/tuL
	plOGkfTqw+EsCbRGS8hV0r3DO/Fef2cEuAJthlV0JL4YdFR4dzbo1LzcIHPOEa9Lo
X-Gm-Gg: AYBFou3TihaUhxgsImtM3FYcJJ6Oga27ig178Ol0UzZShR2EZvk7a88Es7vA3pzjEcd
	mVYo78FbMGM9j3wYUx74xjtN4BZoFTj3lamaGzQ5XPA1Q++RcNM3uJ0691M/QhaRkLIEXn+KApI
	00Wj0ZW+aTt11Jf4lxZIhHz/jZZxzVMkqiEM3jOY6TP6oUuZQv9VBO3Jb37nnt8nhC1RBeIrJJ8
	hl+KG9CUdMmjxeNoPOX9PrKZQP+BbKv3wmC5+g5E7HEaX/4cx7H9NVsiwX1xpJT9OzmnzvEiex1
	a8HueuMRxhxotqHbbff6HPrsUwVM1oaS8UjDnxjcETq0ur2pAzpQf3nOERFo4JHzJ+O0ui56Ri6
	sjXgn9oeIh9EK8llJP0bXvkfGIxXcFTEF/Y2PCPItVapsKqTV
X-Received: by 2002:a05:7022:4585:b0:147:a685:912d with SMTP id a92af1059eb24-1993580ef4cmr5550184c88.29.1792879543074;
        Sat, 24 Oct 2026 15:05:43 -0700 (PDT)
X-Received: by 2002:a05:7022:4585:b0:147:a685:912d with SMTP id a92af1059eb24-1993580ef4cmr5550122c88.29.1792879542501;
        Sat, 24 Oct 2026 15:05:42 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a277b26csm11055500c88.18.2026.10.24.15.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:05:41 -0700 (PDT)
Date: Sat, 24 Oct 2026 15:05:39 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
        Breno Leitao <leitao@debian.org>, Dan Williams <djbw@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
        Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev,
        Ashok Raj <ashok.raj@oss.qualcomm.com>,
        Ashok Raj <ashoraj@qti.qualcomm.com>
Subject: Re: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
Message-ID: <at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261020101048.00000186@oss.qualcomm.com>
 <0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
 <20261023142621.00007051@oss.qualcomm.com>
 <20261024003917.283b890d@foz.lan>
 <20261023170405.000060b8@oss.qualcomm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261023170405.000060b8@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: iImCo-jePrQdQurT7eud8nMYccVJtAHA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA4OCBTYWx0ZWRfX+lOcAJ1ft4M7
 RBBWAS98vEltiMVE+flsshXHDE4aS2s8O/e1IUQNtdq5By6F5dWqTkI0wq/ZPi1GtDT71xv/btC
 krsw1P1KTBoREdnBn5VGf5jtXlsETLGgBbhgm0ww74xpk3cQGPEul/8PV2TEUdtlXQjC6XeiI6B
 iWp1pf7+PXCcuwLx+993M/TToOIDc3uAC5pyW8bITBVhayqWXk13bHNNjnOHbQ9b6MyP+gTY/An
 63VUPDKhMSL1GKUsYCVXgbT6VCjxmjzz3/Ok6vJTU3qTk/YLfiyQUfvEpFg+63S6cKfQWUg5EcK
 AuL/GMfwASrKrOOVd6gcM3MGCxuAwi+2U4sd1FTTdc72pFXfg9pf6uZPRnyy3bIkDpSHLtAWt4W
 rdJ7bCv5hDsWnwC7wpS3YyMLcuHHXcj0aCgdLO6SxSGmF/7tB6IXIcDO5PIEAp9a4pNSZqJgffd
 hE7+5ebEhI+GZzKboOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA4OCBTYWx0ZWRfX5B1cn0hkwHXH
 Z9QYS0mUtxGnFbf7uHX2lbetjvjVe9mVLZMMB3RwR0rjQ3AK15urAzZ+E/uU4Es+eXBXEO4KNiJ
 xZ3sIxZnSLP9FmbhG53cIPtOyt1+0cs=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6add2bb7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=6KC3CYklt-igK55gTzAA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: iImCo-jePrQdQurT7eud8nMYccVJtAHA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240088

On Fri, Oct 23, 2026 at 05:04:05PM -0700, Jonathan Cameron wrote:
> On Sat, 24 Oct 2026 00:40:33 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > On Fri, 23 Oct 2026 14:26:21 -0700
> > Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
> > 
> > > On Thu, 22 Oct 2026 09:07:25 +0200
> > > Pierre Gondois <pierre.gondois@arm.com> wrote:
> > >   
> > > > On 10/20/26 19:10, Jonathan Cameron wrote:    
> > > > > On Mon, 19 Oct 2026 22:38:39 +0200
> > > > > Pierre Gondois <pierre.gondois@arm.com> wrote:
> > > > >      
> > > > >> The support is mostly duplicated from Memory Error Section handling.
> > > > >> Other than differences coming from the content of  Memory Error
> > > > >> Section 1 and 2, differences in the support are:
> > > > >>
> > > > >> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> > > > >> This structure was used to support older versions of the Memory
> > > > >> Error Section (1). This is not needed for the new structure.
> > > > >>
> > > > >> - The compact version is also used by the tracing framework.
> > > > >> To avoid relying and propagating a non-standard record format,
> > > > >> through trace event (cf. extlog_mem event) the new trace event
> > > > >> prints each field individually.
> > > > >>
> > > > >> The last patch of the serie was only build-tested due to the
> > > > >> absence of relevant hardware. apei_mce_report_mem_error() and
> > > > >> arch_apei_report_mem_error() implementations were also removed since
> > > > >> last version.
> > > > >>
> > > > >> It will also require a proper handling from the rasdaemon. Applying
> > > > >> this last patch without rasdaemon support will silent the reports of
> > > > >> Memory Error Section 2 error, cf. ras_userspace_consumers() check.      
> > > > > Hi Pierre,
> > > > >
> > > > > I'd slow down a bit.  We are mid merge window and convention is normally
> > > > > one version a week or so anyway.  Better to gather up feedback from
> > > > > a number of folk and spin only one revision to cover it all.
> > > > >      
> > > > Hello Jonathan,
> > > > 
> > > > Ok sure, as the v1 was reviewed quickly I thought there was a chance
> > > > of having the serie accepted quickly aswell. I ll wait a bit more.
> > > > 
> > > > Thanks for the review,
> > > > 
> > > > Pierre
> > > >     
> > > 
> > > A general question that came up in a related thread with one of
> > > our RAS architects. How does firmware decide what to send?  As far as
> > > I can tell firwmare has no way to know whether the OS understands the CPER
> > > Memory Section 2. 
> > > 
> > > So options that come to mind.
> > > 1. Firmware must send a CPER with both Memory Section and Memory Section 2.  
> > 
> > Please don't do this: this would require either Kernespace or userspace to
> > discard one of the reports, only if the other one is there, which can be
> > tricky. Could be done more easily at userspace, but only if some database 
> > support is enabled, but, at least on rasdaemon, this is an optional module.
> 
> Good. That confirms my view that is horrible.

Hi Jonathan,

I agree that an _OSC capability is the right long-term solution.

Firmware should select one native CPER format based on OS support, rather
than emit both Section 1 and Section 2 and leave deduplication to the OS
or userspace.

For a Section 2-capable kernel, we may still avoid a second GHES notifier
chain: preserve the existing struct cper_sec_mem_err * contract and give
it a lossy Section 1 projection of a Section 2 record. The conversion must
translate validation bits and clear validity for values that cannot be
represented, rather than truncate them.

That preserves legacy EDAC consumers, but cannot carry all Section 2 data.
Updated userspace needs the native Section 2 payload through a
full-fidelity path, such as the existing GUID-tagged raw CPER event.

This does mean an updated userspace listener may receive both the legacy
EDAC summary and the raw Section 2 record for the same firmware error.
They are two kernel views, not two firmware reports. We should therefore
add a shared GHES record/section ID to both events, so userspace can
correlate them reliably; address and timestamp are not sufficient.

So _OSC solves firmware selection for old versus new kernels, while a
Section 1 projection plus the raw payload handles legacy versus updated
consumers on a new kernel.

Thoughts? 

Thanks,
Ashok
> 
> > 
> > > 2. For whatever other reason a platform knows it doesn't work with old kernel
> > >    so can assume support in kernel and hopefully userspace got updated too.
> > > 
> > > 3. We propose some additional discoverability (quickly - code first) to ACPI
> > >    so that it can be a negotiated contract between OS and firmware.
> > >    Until the OS confirms it understands Memory Section 2, firmware has to send
> > >    the older one (or risk the record not being understood).  After that
> > >    negotiation it can do what it likes - probably send the Memory Section 2 form.
> > > 
> > > Option 1 and 2 are ugly at best.
> > > 
> > > Obvious path to me for option 3 is an _OSC like the one for generic initiators
> > > that we discovered a need for whilst implementing that years ago.
> > > 
> > > Anyhow have a better idea?  The above doesn't solve the end to end problem as
> > > maybe userspace still has no idea what this new tracepoint is, but at least gets
> > > us past hop 1 (so through the kernel). 
> > > 
> > > If we conclude _OSC plan works I'll draft a code first proposal.
> > > 
> > > Jonathan  
> 
> On another note, Pierre, any plans to actually enable a path to the tracepoints
> on arm64?  Today they only emerge from acpi_extlog which is x86 only.
> 
> We definitely want the richer data for PFA and obviously for userspace nice
> to share tracepoints with extlog.  
> 
> Jonathan
> 
> 
> > 
> > Regards,
> > Mauro
> 

-- 
/ashok.raj
ashok.raj@oss.qualcomm.com
Qualcomm Inc
