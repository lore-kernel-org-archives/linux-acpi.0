Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434123;
	b=Y4ZOQ3xwZqyZ/dqeklPVf4EHlm4fHDV7Hrk0bqo9GLEfLAK2dhuHwg2uMUpMHLtUsGZ9
	 YTUsvJuUzKCt9bzr87oTFRVI7yzz7oUBO49RkIBo4ou5uRlxiEKHLOrvxc7mOcLhrzdyS
	 i0Bp7zeH/odxBA73uDHAEHS5TT3ofcZoqzwCPPpG4QxXEKObE8cIR9eVuqSRghwl9vjdD
	 PO/qNimSEtpT9vZm8rfp90hOHuCXq5ad63a4ljXQjrJ7+qM6Coh5PbXr3hJsmhU33ZCZO
	 my84V09bPaM9BKNvb4l/LjrhpApeDiDu6Q+tGXTmgSPOFaTqhObjB6v6zyjjkmL53+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434123;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OzM/EG87vKHwQb3clxhLpAhZOOi6NHbejQuRTq00yik=;
	b=u9TKaGPTJiUi3bvF1KKl9XHkyyWoLDj1w7hY1uNAJh7B5uy6mrNOewVB4e5zyAbM+7zB
	 /fmkZw6SAZmjbJMLYKOb82pllUQD446MREQ6q1CeigreVDdkP1ePin5JYDvzJAf+4lZAT
	 GYRrruTJiBs0As87StzFpOoxrvNgoNrWYkC2yeA+DdNKYagrTfnoDs40HqGT9oYvD26QN
	 tvah5K3vv0WQBwU2AUsZAat6i9MjAz9RTvjipKPrhJbqT0XtxIYQLiZydxsg8Dh2Id3LU
	 F78jlVWDr5ufVUDr6p0BVgoR8FOcwW3+fTCfAIxVVf79EW4qCb6xEcvX+91m+5xO74A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FtpHEkUE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LXPYoUh4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C797D606A31E
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 18:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C797D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FtpHEkUE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LXPYoUh4
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JI02Ui2609756
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 18:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OzM/EG87vKHwQb3clxhLpAhZOOi6NHbejQuRTq00yik=; b=FtpHEkUEYbIV7Ov6
	yArCnhlsnLn8n/AoCj/bcuc+gbW9OavkkIylfb5r95I9LYzxoq3gpRM6XEVWW5Xw
	nAX2V9OxZ9GzlHN3vsfFop0nJwOe/jEXxVSYr9pYMVUa4tSDIUBW2chu2F/kt594
	xxYMnfntZ+bEwLFktpp7WIz79wPVjPh87tRpwzgwc4HHwgCxHuit3s5n8GzmExqC
	gg//XU8uE+hTDxC9tk/BoMZ7LugfOPSC86+vr8gg2cMmLaBUMlrfSYrB6qAEZrU5
	vhdE0IIGdd5pQ2lLkB5Cx2wig0X2k5wFsP0yO8moXWkAzLWXD880fvxzBsmbcyFs
	ZME7iA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr3p036b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 18:22:02 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so1380391c88.0
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 11:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792434121; x=1793038921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OzM/EG87vKHwQb3clxhLpAhZOOi6NHbejQuRTq00yik=;
        b=LXPYoUh4qnQAhZd7PvpJnmfoLnTWLaOSjsDKSI9IlTdq7UlhPCzC1TcXvqFQwA6epy
         lm+hWq3wL9dknAn0L/sFJf8nj1HkB3RUnNfqbMH0DI8wEjDDefnMLaxmIZIFzaN6x3wv
         y5CyHT+AusqJ7Kn668m6acdVYYeB0ZGTrUjQpC42L8+Pj62dBs8IzA56qO9l3UphEL4O
         FXjEoN2B6v44WR4pOHNw1ovjIxGuZtdj4aWPHFrL8UoQeh1/8ho4xEJcaHvzrA/T48H7
         ubmss3c26MSZ4OiKTNzqoDGsfPbx410LB9f1JhFp1J1Fd3A3t0doKV9ewSVKdA75wZkn
         kLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792434121; x=1793038921;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OzM/EG87vKHwQb3clxhLpAhZOOi6NHbejQuRTq00yik=;
        b=dptqBE0nVeIFvtzQu/BHKGkfadiDm3I/p8chRn02s5rIZPiXqI1wvVJfzhykom87UV
         41jMRNFYld+KYm7BrRSWiDWm4fAxkZfzgF5jxAALdwViKLPEw2NVOvzJce/DkQr+yCvn
         6uVvDjbMsdV200H1OU0xrvGWR63aTJCXcUHWNtduQOmAN6SUR4VHClSWPKFIHsPwUjyp
         uVEQD7sEzHcfqDlmWmthH41X6vDNTRUkDviSoPiR4mZradDDCPrbo9Rld2Pzi1iNCMeW
         3Bh+k0ZeYZeHGqYlgY2WcmyGFChwVW1hk4rua+Qwb9NBPYDpoHmd3kiEKDgbuDH2Qaoh
         QZXA==
X-Forwarded-Encrypted: i=1; AKwUvBwKwTcNUdPthlZEHgpBx5lb0WJhl2/Tylo+F2R7ZS3VAP+6O4Bx81uC6mHN5b0feXOyQH0iYSvSEjS1@vger.kernel.org
X-Gm-Message-State: AFq9FYLD1jCr1vuXzsDue9IFLvM1dV4yEEms8SYMJr3LCm0bjURb0FGQ
	2TgCNhkTmhHcbzeWzubghMHZujNOXMamcZa9e0mLkG+qycI70KfTw7w9bVbQg264mPOLgpr9BQy
	HGfySdG5WyiN7VyStKV2OzG/uV95+YA/fqTy5N+6Xl0FWmkr86K5hQ6SPQegvufn2
X-Gm-Gg: AYBFou3kGfZIZoF7hYe/k+WTKf+1lOMmPAVxs5esZ4NoUh+a+Equvk16nJ1dHOjhqnR
	CLHYzIjU3CZfRbJEelILyZc3DJBxZPFziXEFW1J6Mz28xrVzkDkiSsjOE57MEnoouVqQ+JGZ04J
	xawaUqUygA79IP9YyniqbV55tpZKCTvzxmNdfA5sz5jTaVIxD1EG6/rmsHni3Km0riKwf0BNEo7
	Cksm/5kiWR31V3/nAjpgcQpt1azELi5I9wLttcWCthYrLXO6RemGMoZQbi886+BlhHEaE17LDrt
	WHXddbYiDj5fkMhYmiNB18luakkPxm3D5PmsCB7NzK3Aed70PKJq83JeecVvfT60RVdqsh52onN
	EQWBpuS1komLtSfjZ/kEQ0+Y5lVG6jGBo5K6/h+wCWQ==
X-Received: by 2002:a05:701a:c907:b0:169:3706:d61b with SMTP id a92af1059eb24-18511eb6a06mr12491483c88.16.1792434121254;
        Mon, 19 Oct 2026 11:22:01 -0700 (PDT)
X-Received: by 2002:a05:701a:c907:b0:169:3706:d61b with SMTP id a92af1059eb24-18511eb6a06mr12491430c88.16.1792434120643;
        Mon, 19 Oct 2026 11:22:00 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314b1722asm31987710c88.1.2026.10.19.11.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:22:00 -0700 (PDT)
Date: Mon, 19 Oct 2026 11:21:55 -0700
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
Subject: Re: [PATCH 3/6] cper: use BIT_ULL() for processor and memory
 validation bits
Message-ID: <20261019112155.00006fb6@oss.qualcomm.com>
In-Reply-To: <20261019145643.1877246-4-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
	<20261019145643.1877246-4-pierre.gondois@arm.com>
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
X-Proofpoint-ORIG-GUID: IJpzUGOfs_IPDD4jIyQzp9AeH8uWMI6R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3MyBTYWx0ZWRfXyooCfnga9oAn
 7Y+pMu+WE51SWmqf84Nco4G3Y5p1MvtsrMaZxi3MlkV1s6gpYo0XFQlggZo43MUenasdt0k2Gmm
 ATweeuiEAWME9PqBwkCKepBpTy2e7N04qcLQE7LiYP5TTCZkG71Vlh3zmmxFFNzq6Y0HWE9ij8C
 qKqvVuY0uUJnGhvSNmqFquv0wspDLdifdu9INBHcvq4F5AGIS1FPPnp95uLUNLMKy/3cJPYVjmq
 HfWSwWxoWRl+ve5nZ7K0onP9b1impoyLBGNwmTNC/LEHw8CITx6pwWGOfYixDjba5JG6Fp769tC
 H/9NhvQp/G4CWCpCGv5MllP2TN9a41GlFcUo+bUm7LF48zdUBdS7FAviIcLZ9n63yx6DRdb1Dlg
 4zj0dbmukjmPF2TwuOtPHpGg7kQ1O6eEnifZP1ZBs9MiHIli8r6ACQz45zskTggkn/phx9FscaX
 FdE1IhufxVpV78etvmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3MyBTYWx0ZWRfX1Mn/wvQWx30T
 mRzJrkl/wXo2imyqeKmxQxuaE+5oFzfSGMO5rt0tIXF1vXmnTUW+yHO1pnI5aPzQUzssEg3Y4F2
 AGPXrMMwcINctTy4vQqH/rwZi1/j7ao=
X-Authority-Analysis: v=2.4 cv=HLxWhYtv c=1 sm=1 tr=0 ts=6ad65fca cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=wDomEPKxsuTd5H5FNvYA:9 a=CjuIK1q_8ugA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: IJpzUGOfs_IPDD4jIyQzp9AeH8uWMI6R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190073

On Mon, 19 Oct 2026 16:56:10 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Use the BIT_ULL() macro to describe flag bits instead of
> hexadecimal values which are harder to read.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Nice.
I'd do this before the previous patch, but not particularly important.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
