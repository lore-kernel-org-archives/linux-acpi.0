Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433818;
	b=fW5JqbCkYuXNclRtWO2fka8ZIhbr/grzEFBU2z1J7fzXE60Lp/znBrjD/WB564n0sDwd
	 TNI422+SvD8sbCql4XuaZ3vSsNHkTbqR1D5cks0g5+clgick0p6ivXLCxKzlQ+AVjUZJI
	 puB8hlP4Lu4Vbe3kE2gfeSo7N2xf+9etPnRlSr1u0Eq2ybTKXfB8+GwVqByacVuoY7SAD
	 PANeWGXPa0mHVoVnEuiarttXuEc33pIp+tlftdGLO6vMh1yNbuOyrOyNdZjb1VE9uolRB
	 TIOgdmSnvuqme6SIIwHAjYL2vHW89rimZGCVk9NlHM8ycMOxuheiJH38fF+Pswb9Aqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433818;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ME3cN6VotEvPOysbvIMmDJdPx2UppASZcvsxt09CPAs=;
	b=VNSH6XrsOD5DaucJ7b64pXVhYJPT20mMLe92dy5zKFLB85tfrXm7LzYdP4Oksdb77i3k
	 OQEqGH1luNomrEh2cusO+d0hTgI5vovFcWqvYiJPRKjdkT23XlgyLW+Dv8D2grh45ncOm
	 PqOmRl025K5DAmZLvcuKMlxR4HnzMhltHeLrsEr99215m8UMfPDTM/YzJabPKq7Uv+SBn
	 gxCW36cVvbFtrGkBd2zDDM2Sl3/oCJeUuY/E26w9gQplonDijVyQemXqXxgO+PTpCLlD/
	 UcsuYQAee05WkIGzA5nVsxxQgtRRDX/IVmsAOBn1B3jKN5iWjMFjIwFaYPLG6uVBqpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=axJNuqcB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gKA4jN6E;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E5D606A319
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 18:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76E5D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=axJNuqcB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gKA4jN6E
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JFOuok3158934
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 18:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ME3cN6VotEvPOysbvIMmDJdPx2UppASZcvsxt09CPAs=; b=axJNuqcBJaHuVjYQ
	E2h2efGauM/+beb5rqtHhYdH2yfr4LDBETXMtNNTpsMcVxu/zV05WGsZErrGlF2K
	NBqWn4pGclrsQMKQT01KPyg2s68U4YtSd1vuXPf+6DGhimC9elShCu9c9uVj9229
	EqdIyf7P0mrR/shsMGcnyBRoWwOigvjtNRtqzesSIyu8b5KIQQ3qkVI83ScRwGg4
	MPQQ3D5/PraMeXaZxgKr8btYTr59ASH+gNhYPOZIAKqiHsj0TUvs7DAoFTrl+aWh
	NfLf97PMAoG84chGn+yYASVlJ/nMX+WXb+8FbDTtE+cRVje7e8ByDlHd/ssalKut
	LKhjwg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3xapdu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 18:16:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3510d0baf63so6106314eec.1
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792433817; x=1793038617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ME3cN6VotEvPOysbvIMmDJdPx2UppASZcvsxt09CPAs=;
        b=gKA4jN6EJNVtIogRpKum9XVekD/YYQ49C56OGNYX38VEbAWu2ennj+hRumPbXwC18a
         DPxwNMxRFHH0z2rcmY/51rIHYb8XxsnSQSPaMpMzJ6/jkvO9jlV3T/nCiJ2kF35gDJ8y
         LdmUyIpvD87FV7gYmdTghWaXVxZKjugURJ0OUUFueIndKwjCyomXISOGX/b9qbadnEyV
         XBl/uhnttKv+jD4DYAFwOnKIgdsIlIuNGSrY9rOLTyexwqOCEj7+wY4BMBHKxdwMqdoZ
         vitJlTzyBnO49RriKP+HGMxLkjsgUAWQYtI6sfug+U3UlyBLaGbmGDnP7RN7sy98lECv
         nMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792433817; x=1793038617;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ME3cN6VotEvPOysbvIMmDJdPx2UppASZcvsxt09CPAs=;
        b=UCxRGrY7CcYiwI3Mr5MExQzlxNW19kmYL9KkGXTQxFbecqf4LXb+mO86I+rBIKph4u
         3ZVsFKykf3OLizRNBn70tE2gWF5pVKzthe5uV+JWo+Eg8afq/cl4doMdR0kERsfPV2gE
         Fo6v3VYIdkqK7sV1olffsydwD8R5+wlfCP56YGGhrY+Ae7i4cgkMWQESernf/7ogvyuh
         gy4wrVZ+P0idgY+O5m24TUdJwGK4vs+HhAmdIscJc9u8qbiec5ErloSCZN0MvaNhBGTW
         8JDL/Hx3Kv5GWP00XZW3POA2MOQXdiwRIL9PmPLzDTp2LZsDu5Jma88tFL60oaXkCPXB
         t7HQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIMmN/klYlPMhagPNfDguU/ZgIzylXCS/iPiHrqV1jZ8r38+KV1eccyJnQ3A6ZWWFkzSXfQzGEsN4r@vger.kernel.org
X-Gm-Message-State: AFq9FYJ70OM5aXagDL9BH8P7DXO39EZ5fW0uw3FoXMd7FylTdS77R40z
	2AyaCUVALEgow+mW7cTI5al9ZZkX/OhrfVN6wY7rok+XFXq5u5JlEFo5/u7YU53SbxTJD+G4SAB
	Q3q5Q6H1DVjbSrFSOH85CWh1DpZ1ieSXwoYNROaBksDqZVw9WhJtDzm2/0i4dtrzd
X-Gm-Gg: AYBFou0fG5w7YmTu5m/y2pXjH9duqNgFvBDa/AL2RXDccZHuhdq3QZnEsqbEoR9p9Dx
	S21VIzBVxFH1uVv/N1Rf5GK70FxRE1Pdl53nALzkLjunVCsG8Rmozo1o712DfD5mC/SzCAU/R4f
	6tty8IrkucpoVtd38518KDyiAhtlYbP7UuoMMUick0dSKq22uKoTfTf/cEvkBSIh0xQ/CqDDpny
	c0D3d/ujaFAPczCJk1AqVnFaIsuKW1v2v0qydLU3hsfhEBOmYr8D7IznQBHfOUg93nVkGNeYkm5
	KTH9wM0eS4u+EaxWimmgE6JR79sRYk9rNK8BCwC16sdoII+RSGSt/GDkwmCa1bQV19zZAr9olfx
	1FdPGjDKNMFl20/bnZ2E3+5sSFb1pY9OxWCUYU6HoMA==
X-Received: by 2002:a05:693c:87ca:b0:35b:c1d2:eab9 with SMTP id 5a478bee46e88-361a2e3d3abmr11081704eec.39.1792433816835;
        Mon, 19 Oct 2026 11:16:56 -0700 (PDT)
X-Received: by 2002:a05:693c:87ca:b0:35b:c1d2:eab9 with SMTP id 5a478bee46e88-361a2e3d3abmr11081665eec.39.1792433816173;
        Mon, 19 Oct 2026 11:16:56 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36083283478sm32477142eec.29.2026.10.19.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:16:55 -0700 (PDT)
Date: Mon, 19 Oct 2026 11:16:48 -0700
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
Subject: Re: [PATCH 2/6] cper: add Memory Error Section 2 structures
Message-ID: <20261019111648.00006fe3@oss.qualcomm.com>
In-Reply-To: <20261019145643.1877246-3-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
	<20261019145643.1877246-3-pierre.gondois@arm.com>
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
X-Proofpoint-ORIG-GUID: 3YX6Dg2sweToWb0PEj3yVJf2Or92SLfI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3MiBTYWx0ZWRfX0J+EjtIta4U9
 G3gs44dGrspH4FiMBAUrzIkvpKtN+kLLdiVcsu6D0ajrmjDgYdeor8GZaFfJjoxD4ZJnIwrEe5g
 n+2HjtwYK1ui1L8cJm1BfY/A9no6FkU=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad65e99 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=D-Xi6Kjd_1bfK2TynAAA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 3YX6Dg2sweToWb0PEj3yVJf2Or92SLfI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3MiBTYWx0ZWRfX1tze9nofN7Qs
 4gJDJukMAF2bM1GyifNC8E7kfMcn1UpYh8PDPQ3wIoLSfEswdAsqB5HKBrjHOC8VzVbmnyosRqa
 QtLukiHVN9uLJnezEh1HcbOJkurS9NXBgCfz71+eAYe2Wose/KtQmCmsQjSni32YfHnUAYUWJdJ
 xiVIS8LYwUJKitmkVu5Sf0/vGHRRtcu1/MejV7j5qNqZo+jHLWOoW16EX6Whjm+hPy7+9UuWElE
 peMVjDqvPfzsFovblTKP8f9brY3AR9PUnO+SxAq/GZBn8SnAH1B1MQ0C1N0lCHMQbh3urKeroQi
 73Dr1UjOB9lkRtc849TqgiNLo4MsBnm0MZUfYeY4ltdCYgQBuFwKjUVlnJuodCY2QIhyh1D/Evz
 ZN/Ien1OoeENwuOe2TC2fBH0arlLurWxSLjpgVK8typaFWy7DpfDT0h7jsD9zz3Jsnn/v1n2x3K
 fRvSd7AbhRlrKEz9kgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190072

On Mon, 19 Oct 2026 16:56:09 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add CPER Memory Error Section 2 definitions to the CPER headers.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Checked against spec and the couple of commented names
that differ make sense to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
