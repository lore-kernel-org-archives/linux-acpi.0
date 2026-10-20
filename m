Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516257;
	b=TKOHvc5+TSxMipsyZcbj8YxnNaoFioFKe86O1S/aTouht41oHz95r9l6iZXM1dNa+7Co
	 PVz/NXKpyt/eYBKaUmqNmsQdlGPlUjdXlodVARH/Q3KChIRWf3RyA9g7YdVdXJuX9qPys
	 P2tgPKE4rP2I94woKWkdesv+10PfAPwiqLO0bzL6UbQP1WTYDZQHruVAl5JTSD37QynKy
	 oQ27oE+qpRdCLcV64EKeS30YKXXXEPbBLcwA0DS0u0Ij2qUIYZQLWCJd1LZPNmpzpTLGZ
	 V3FHtPLyKTyMj8MbZkXFAt4k8SeblP4oqU84EtiMJTlEkMMfhlS0ua9HZ93hxt/rHzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516257;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XuGp63Zu8Xhb/maxQXifefMXC5yHBwIeZ7UZd8sAo6g=;
	b=G55IBLDdm+3OwyQ+OET+jWG2AjXn2Ei/aP2CFU9AFl3h5tlMgzdT//VyRCmv8gO19clK
	 kfXV+kE2vqkvpEFXd+NOD6mxqLqDRxr+s8OKuWKRavtb1erlhmw5CfTshT8a7KCnGhj0Z
	 RNPjcDZQBRdxrsaV6D0u5fuOKwXN0o3IvyLgxX8cT6dRlWA5rPs8QCIRUcsMpZlGq0O1i
	 1onVuW21G8OhAxBgmgWt815MqzqlvmSZck1DHsErRYya4Gb0YbZ6Bu2U7khLJ7KTemz1+
	 cH7f5ucl2B5p/G/vp9GV/b8/boj98Hjk6xBROTl+kByaFOAJ9TBqw4QZqEvQPdxiZ/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cr8UEhZt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dxWCPcTQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5932606A32D
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 17:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5932606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cr8UEhZt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dxWCPcTQ
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KGtug03342398
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 17:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XuGp63Zu8Xhb/maxQXifefMXC5yHBwIeZ7UZd8sAo6g=; b=cr8UEhZtHzcb3IqX
	cktx1/Tjz8ZOrSW7yg+EZjyDKalpeLFfVXvVcxfZ4GpdXdFGuKFaPVtumG8TBpri
	Xs+CjKAOSb+4yXKrNTEvUFfYF9t5qD5MbmfqqNGbF7psV0brw9s0rYH66Tr2Ii+I
	oAzpuwaR2C9LAdKXF4WIU8Xj45vbbt4KJOw0YjDlnlyKCU+hEHkOS05mR8edq5LH
	1T4Uqdy/B2K+cc3aeodyeQl+RvcjSR6jknYOZp+7eUQ0ijDlFgZ5CAj7yzfnZf4n
	I9vkWmzYQ2gVYynfg6gUE3FuU1mfMOkP9J62yHxw9T8pfBJTDHF5e+jrzE/VHrkV
	meRLog==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nbjax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 17:10:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so7540990eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792516256; x=1793121056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XuGp63Zu8Xhb/maxQXifefMXC5yHBwIeZ7UZd8sAo6g=;
        b=dxWCPcTQhE1GIzkY9NluCy557sf/aV9Hlv7TV4U8xCxCvvee7Dgv0f/qzFmfYZzhB7
         MO4tNmYrrFl6RL9RYA5d+t7rw+bus4Bz1dn5lpoM6P/iyIHsqdFOtyUABUv3//rMRYwh
         /NIglJMJluBtYL1Sjc7mKhVYj4+Y6M+dnn7JqdvkUXTO3oprBizyukSxRZShasQZBrEX
         2B2RxyxxN35bCtDMsgy39qs1KXq+WPyVs8kFm30gCpJ33HcC9UdoPADadBZi1wKujvPC
         xnijG7Hk+f/xc5351VO7EPp2Ir/nJPM8Sz+tVjCSJHbbmfAnMpIFBY4ngo3q8nwZgM5W
         aSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792516256; x=1793121056;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XuGp63Zu8Xhb/maxQXifefMXC5yHBwIeZ7UZd8sAo6g=;
        b=ayUp/Z9jRNKDgIi3TGH4x64G/5uReoHF6rpKLwb9YquaobW13AilJ8FlFUSWOnQxhQ
         aXFtvUoVbvPP0IseGTjFipi3qaQtA0gZuqqHYcvKW2XR/BlUWpAAaj0IflJK5GiPWu9U
         8v+nyJzKDz1EX0aQP+E9sRjGytvqsABoMHDiyGBH9HmAzTe+nI6oU7WX/sSb6/ARJHGT
         DgNUl3hcwXQXaPwIMiCkqpaDz6My9C7pmqJp2fhxWxz7wwLkjMNgGLslkjkxYhzoK92r
         xVnjr8r9s8aNGEwWIsyDc6Y8je35GOhKtL2EmXze/YLnY526qq3zFelEBCqKg6RCtSUG
         vfKg==
X-Forwarded-Encrypted: i=1; AKwUvBzZyKzpmMoGHgtSgnlRQs9iAUpzdb79+64v3xIu6sRBI4OtXWg548cF5mbhhhEIR//LtG4g67TcMlC4@vger.kernel.org
X-Gm-Message-State: AFq9FYJqC1rFVmvU7Epf5zZPyWEyqJNJmgVvk4k+MFnk3dtQaVZnpfIq
	CwxeItIAZq5BrQ4+kgMppEtcldjc7Tm03dx/P4WjbVE4M7038VfGbcVseyMLl8vkyDw7JQF3yMn
	Zn93LoPGMJP8EY5fwtwJKIc+Nj8+kBn8Qr+FzirwJp4G58XN+TRke/+mmcus9aHvVlzsxlp6z
X-Gm-Gg: AYBFou0jAyvO7rcpwARIy95/eH/MzCFAHdoNc50Vdl0kV+NtOQeALqGHi5zNihYHoDq
	MM8u72KIkbGiFLpcae3pGDwoL3hliZMFnGdqGN2/cQUF/QqB2Ru0ffJdUOBkPwCLAWCbUvai+lt
	mqfHtu39T6Smqlbg1sh2G9Cd6u5VXgZLdiPDMK32UodrzKz2KRkcH8e/o1y0iJeeSBclkQ9WM8u
	FAHF6VUpGnxnyQ+KIPQAQ3yOrsa+0wyRE4BcT5JC7SchB1qwj7qmqbhGe7l1XMk4Lb+wZi1fHHG
	0pmhuo7TcvMwzCaZsl4GVckdOupu6jXfnaYHBkCb8mOdcFMVoscxtqzR4XrcqdizCQGX2fMkcWx
	xX6aOY7H1VDPoeQV+5gXCVD2n+U+AKueOIX5FLmFuLGU=
X-Received: by 2002:a05:701b:4587:b0:17d:961d:7db0 with SMTP id a92af1059eb24-18512e254fbmr15146323c88.28.1792516255360;
        Tue, 20 Oct 2026 10:10:55 -0700 (PDT)
X-Received: by 2002:a05:701b:4587:b0:17d:961d:7db0 with SMTP id a92af1059eb24-18512e254fbmr15146268c88.28.1792516254593;
        Tue, 20 Oct 2026 10:10:54 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm44388c88.3.2026.10.20.10.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:10:53 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:10:48 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mark
 Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov
 <bp@alien8.de>,
        Hanjun Guo <guohanjun@huawei.com>,
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
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
Message-ID: <20261020101048.00000186@oss.qualcomm.com>
In-Reply-To: <20261019203915.2019037-1-pierre.gondois@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
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
X-Proofpoint-ORIG-GUID: 0oSDX3dZmch41TxIoO_as1BSrM0AeE-u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2OCBTYWx0ZWRfX9902Qr/CqYfO
 EFE4UF1Fx8fcmdRiEhgLUtluXVlBrR/N5a6y7KcMzdXlFxdXoR2bivHQCL4VIECCFFtPknAXJ0r
 ODSqGcspN2DI8WNJ0i+b98414SQy7edPndZ/nHY+gupuy9M6s1n9qTnkuz05EqkNFU+KlbAWR0n
 ccdR/Qk3F2DCdlPFflrQMA7DYF619XzDr0MPVjDxAZqnX10KwsW2xZBg9yOu61MHwl3rASiWNhS
 26Bnz9kH5xjd//lp+W0Ijcoe9KTxpm9+6dfresFdScX6Xs/H0zKef/bpFLYrvf/fCtoyCGjE/+O
 ywH/PG6Ye/lMXgF1JMvuWTfQX18zSvfVbaI+Y7b44wiZKtJ8v5+bCLfzAXjmS5dsc2c1LZZnZnl
 UQ5vY6KiRpL650KihQ1s757X7oWst4LvJJ6qfaGKNWCAWVSyhQLNXn9UzITFKstKAOV94Oxanar
 jdeVgjitvwgFPbrYUMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2OCBTYWx0ZWRfXyP5QJLMMaKPc
 +v/fNN+A16AsrOJ+PFTMzySLU3EBarcQgCB6Xff6ScwslgGx+2TUiAAHPhwYLECdtBjWXLJdczl
 foI8D8Yf84eGhYrbaSmPhA/jxibfll0=
X-Authority-Analysis: v=2.4 cv=VI9IDNPX c=1 sm=1 tr=0 ts=6ad7a0a0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=7CQSdrXTAAAA:8 a=5VxSIjaA6f0WmzOPONwA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 0oSDX3dZmch41TxIoO_as1BSrM0AeE-u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200068

On Mon, 19 Oct 2026 22:38:39 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> The support is mostly duplicated from Memory Error Section handling.
> Other than differences coming from the content of  Memory Error
> Section 1 and 2, differences in the support are:
> 
> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> This structure was used to support older versions of the Memory
> Error Section (1). This is not needed for the new structure.
> 
> - The compact version is also used by the tracing framework.
> To avoid relying and propagating a non-standard record format,
> through trace event (cf. extlog_mem event) the new trace event
> prints each field individually.
> 
> The last patch of the serie was only build-tested due to the
> absence of relevant hardware. apei_mce_report_mem_error() and
> arch_apei_report_mem_error() implementations were also removed since
> last version.
> 
> It will also require a proper handling from the rasdaemon. Applying
> this last patch without rasdaemon support will silent the reports of
> Memory Error Section 2 error, cf. ras_userspace_consumers() check.

Hi Pierre,

I'd slow down a bit.  We are mid merge window and convention is normally
one version a week or so anyway.  Better to gather up feedback from
a number of folk and spin only one revision to cover it all.

Jonathan
