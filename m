Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B031364E92
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730365; cv=none; b=PhQwYflvjnQbgEVQhZH+P+d+DR8yTxX0/wbMGfqXVA/fDnflSFt+d6wajFfEWNoy+o5pBaVmgjdGuNCXspEWdi8X+IdVmceU07XnwRR72eaIoEU6aEma+JmRhIs4XRjdiZw6tuvEWvIncQZ0yAapxIdgmW6qvChR8AsqHg/Mjrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730365; c=relaxed/simple;
	bh=QYS3EqsqHNnRb2qyR1WrVdwQJM+VvU5Fqh/2g07zTc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GDbvdk3v6fm3Fa0RORWEZerhXGiYBMGus/Sjbjpy9oJq7rzo2z+pw9JoxD5E5adyXMZTtU900hdvjbIgG8TyPgLQoJY7sTRSNkgHacMYaAj2AO2HJHwOgkoO2CpwKWJhdYG0G/oyWuYg9yVCXxXZkDbylseYCNo1U0UJq19AWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lqRQzctr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iWEWzrcn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lqRQzctr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iWEWzrcn"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAT6OJ2627926
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b8fuaLzKX7/zt0DI23Fv8iBITnIyykYc7tbykSQp4Cw=; b=lqRQzctr4Kajdav7
	lYx2um3APIHdIRxFP7EnCv74uA/yCPZPdr0IuHoKsYM4z6GlXM8rmP5DCf5eBz51
	FnA3YVGfswU8viV7u48eQGPDmipD/EGXfN1SOnvgoEz71EJrvFYS4T8/2W+JLZU1
	rxQL3Og5rGGfuBVhXx9alLxU9dN+drAPNaUj+Dljt6xQKcikodtPfv9ur5BFHJHC
	20AflN73fvRlBZQdQO9Q/bXB7z7m77eB8WKur1vUf10JSz1dL+1K4ogAtAWPIsTc
	QczPnIplWPB2r8kSI+pZ+WkBgpFdwz0hOkNKXJxNMAN+8CbhO2beSNxEaFzlBHCs
	lu9Ntw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nbgrgy7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:52:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92b797ce02bso575491285a.3
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 03:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782730363; x=1783335163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8fuaLzKX7/zt0DI23Fv8iBITnIyykYc7tbykSQp4Cw=;
        b=iWEWzrcnQwVhJbTQWUHkkUbm8UlbArRksZ8Ulvlr0cVuMYUcVkB+OrPZIj/zhmU2xS
         EoImiZ0cyRIlMkA+MLo3wQEqvTUNcIqxPvf72bAIGAk8zjQzdP+gGXFim3t9fiXk6AjE
         LPWYLJouXI/5n2FpKEotVOA1gqwuLb8wIi52k6zx38zb8gYrivAnC0Pi5ifF45CzsBF2
         Fa2Ht7ibFYcnd/OMm761qG28Ogx16iR2zTfnVDGrRh6Tu0bN+qV2VrSxy2RvECbSj/AH
         FAucBou10YvzWmfpOJitD0KqU2pcDY1+M0ydX1qnkBRmZl7UBfgzCwTjCggjNHq3guF0
         2wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782730363; x=1783335163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b8fuaLzKX7/zt0DI23Fv8iBITnIyykYc7tbykSQp4Cw=;
        b=D5Y6qXGhXr3+uPi/oM9Rq0FvB6VygvfljPugbOg3m+mz3n9r7V8HPMv5gc6Nslz1ly
         qqsbfSiSmVbOJ8qgxJRQ9fPNAitwW1OgZ8Zki0zA4Ik0+rqnQKFS/QT1PtZord/FFHNp
         1x2/F+OAxCGNmrpmD2/NC+NQvQy3nWBaHIneGm+Ut+FK0B1dd46cBMFEM0oX4fyNx2mD
         w9ZIRumLifVVtAvNdfp++srpA7qxNiGXkywcORRex+jTPBS5b3vpx0A6dO+M2gaxxIKK
         E7eWINjF9dqGJ+2tS3J+FBhB/m95QuzJv4xIe1moybflVV8XuASnFC8nS8pcqOxsYWq0
         pnsg==
X-Forwarded-Encrypted: i=1; AFNElJ+hEspHT9zqtI/qHEG6yeRb7SDDIocZaAtq+YrKKoN8Tuw0K3XAyzY6GDZnl8Wn3oeEkaVtsezgKTLE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpxz9Xy30no2qfnhX6tw40zjLtdOyDB3P0nc5raXX//j9uKSRp
	K76mtjw7b7c1G6b2AI2TOdHxWuLaNQPFDI2xHmKD6NrS1ZgyZYfOCUqCsmUYa7FnzySJ/XJlJJt
	VDKPOTJL0Q3twDSS2pgZH84Lzx6dBukn0sGQoMbkeoAbRWgkkP2k9HoLr4jEqv7sK
X-Gm-Gg: AfdE7cmr5Ol+RRPbgax5uiJ9fRVelS/LS2PmJSpDaZEOTMHAOrw3jtZJ5OFipPQKj+E
	w2x+r2pH1x7Yl6405bnOdv7lJW8VmrtHx136ElQ5ITSh8NiIUsr0kpIR5rr2K5hEYOTtN1BlVrp
	b18j5dN8PyTPsIX6ZdxeOY9HKVTinfnyg8Q1ajb+7UUTbGi0T0FiQVLSZ/Ob57stXnzcOx+uFyl
	K/524WOrJHBrvSJU+pEAxx7q7XzHUPy6tlEjRE8SFGP1NNgfYH+nmPRJ1qgZ50SpRmIVbGYz19q
	AjrJCAZN1ZtPQHqSnW3yJm/95ToGKPwPOiA/fFGgYd7wkvnXCFg+iLaKIaKBlCPAFimB8vea5R7
	Tb0Ad5BN6UPBriyM7wxwsSAvS1sbwgimdI6rqZjOG
X-Received: by 2002:a05:620a:7119:b0:92b:6805:9189 with SMTP id af79cd13be357-92b68059702mr1417911185a.65.1782730362464;
        Mon, 29 Jun 2026 03:52:42 -0700 (PDT)
X-Received: by 2002:a05:620a:7119:b0:92b:6805:9189 with SMTP id af79cd13be357-92b68059702mr1417906985a.65.1782730362062;
        Mon, 29 Jun 2026 03:52:42 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4726b76e6f8sm18341754f8f.13.2026.06.29.03.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:52:41 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:52:09 +0200
Subject: [PATCH 4/5] MAINTAINERS: add myself as reviewer of software node
 support
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-swnode-fw-devlink-v1-4-b90058b41839@oss.qualcomm.com>
References: <20260629-swnode-fw-devlink-v1-0-b90058b41839@oss.qualcomm.com>
In-Reply-To: <20260629-swnode-fw-devlink-v1-0-b90058b41839@oss.qualcomm.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-acpi@vger.kernel.org,
        driver-core@lists.linux.dev, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=971;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=QYS3EqsqHNnRb2qyR1WrVdwQJM+VvU5Fqh/2g07zTc4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQk5vAtDrLBxJ7wJSt3inQfdwNmzPhUgJvSVzf
 KKilDv7TSaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakJObwAKCRAFnS7L/zaE
 w0uND/45JdiqnKMuc5wUZ7a94clqHgiv92Vw4uq+Dt6H2vT1hShus81oLf7Az0Mn1+ZcdzO5inx
 eNYRIp8fz2ZpoT/6th+odyzuaJmtXtCX9sUQefkbocFl5tiYsgqMSRh7H8IYamQSvGNDM/wLcRl
 XSiMXhYxCf5B9qprngFNBNDx906crWvX0RxaHngioNcf2iXtpnumvKq1JacaM73djmyYrQOJg2u
 Vzd17L1sffP1Uf6+nhhVWDoyuAASM37vzZC5UMYr3+K2o1cjKECYdNfh8SVC1opRBjYLtgcNA6q
 QIR0awIpCX8jjCCsrMFOOMjPhW11xf5rXIQZnqYD4PMzhZ4zEjKCXT8DwVAKvzQNlaW931kQYCI
 bpeaTs2sW0Y+XAc6and8RyHWbCV/EII+gxghO2/OJJzZct+Ms8OEvN4kECINn8jkKB8ujR9Uwf5
 QwIrOrYACLqduoHLLAwoAPGuzjZiq4fSN0p4dS/6rU2CEtgtEWzoU9wk80VW7ORKXQj4beGR+qm
 fZfGoZVLk7A2YYK4f0IfUWDEyLVSaQyMF6YDJvEAyrWEggL+2h5q1kJxeOzwOtF5HF0kGtSvgwj
 nldxL4bakgFDh4R5P9SRskUl5GvrRvUF3ZZivjIctlqsVNwF2zj7P/iFX0jPKUCgkwB/LdHLvPn
 sKj75IPRiSn3IDg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: 7iz0Oqt0F6OToQvskqDJ7l7kK31_VSls
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a424e7b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=hdCJvu6vi-O6ykQZt0QA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX9mfe2ym3VPgM
 dw6C74lKtgsccfxDLr2lXR90UEjY7RjaoPDky4SL/PtVWZ7QPDBMKVes7rwmxdUfWHNpOFMn7t2
 Jkz0SS9eWnqTbc3NM7ymTILLw7HDJSc=
X-Proofpoint-GUID: 7iz0Oqt0F6OToQvskqDJ7l7kK31_VSls
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX45HaX+MGxsaO
 mJGPkG7OEpZ5/VIylJQvdwHUvA7dDpBrcDYz5tLy6KFE898L8QbJIm0zGcwQoOXrp4u76Nl7v4K
 3f0eVLdHlNtsz2FgwO6ubRZ+vzcdBdS7IoPlguLwbfR2FQ4fLmNGtn5r5H3qJx2Y85zfDE116f9
 hQlqxYkQC1mAi82DAFaC6OljkX4FuFXY02E5RgwrYDSjtRo2wnfjQYU9shDjvF6CY3GeuDqjNTU
 JU/N16dKQGlXlQf60ypnpAojdHHhH+jZ13FNm2DknpYgkv+jkz5YCcSMV3YsKHg4zpJ6a+yN1ol
 gE+CvrysjIj59dkN1nzQyzyVBz8g6FByCB7/YlTBPQEXt71x8iGGDBwM8PupdUO6hWZLJcnNAp8
 yuA7N1rOo48Nv3xQHTVNv0AZnI10NagIzwJVAieMv4aY+dvRhnUZoe+VMhKaRIbh+z/sKKkwdKs
 GkaWHhsrYuGXGPDD11w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290088

I've been working extensively on software nodes lately and introduced
some changes. Add myself as reviewer so that I can help review any new
proposed changes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a994cf1b354f490d6c4e411588df88..e30aa3b63eff90bc0ccc39de774986ce17494071 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25101,10 +25101,12 @@ R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Daniel Scally <djrscally@gmail.com>
 R:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 R:	Sakari Ailus <sakari.ailus@linux.intel.com>
+R:	Bartosz Golaszewski <brgl@kernel.org>
 L:	linux-acpi@vger.kernel.org
 S:	Maintained
 F:	drivers/base/property.c
 F:	drivers/base/swnode.c
+F:	drivers/base/test/swnode-devlink-test.c
 F:	include/linux/fwnode.h
 F:	include/linux/property.h
 

-- 
2.47.3

