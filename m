Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5341C3E929B
	for <linux-acpi@vger.kernel.org>; Thu,  2 Apr 2026 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139327; cv=none; b=NXw30EABw7k4ux0LzHUqf/pAUqb9Pzp0y/Waq8p4d4aYmQvkZHR74ul54IznEParQXYqb4Amn/isOBntLBD7vmfNy9qSMWiE2OMPBYG6ehTz18E+/wS2wrLdLcKdkMj+ElnQaTwrJZiKcTM0MMSiur7vG75I7Z22R2xqS9HZ+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139327; c=relaxed/simple;
	bh=yBKrNw7YytejW291mPySbI6LGBLYwN1ehugPvNfrHLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QW4VNjUXcJlo5dG9H+5YBawwdnyVcL6CSBh9bk04tZFuANsLFWstJa0uabF6o3lzNGwYv0tw3u1pB85xw/9n0eR5Y+TKARBu6Sai7+LpH5PXDMakVGQYBFiswYi4/KKZDdBb+EQqaCu/DCQjOTsOcdyJYF6V04RpoKhZIu/Nflo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JK9y2rzy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R/8Ugbfl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JK9y2rzy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R/8Ugbfl"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632D9iLV3955995
	for <linux-acpi@vger.kernel.org>; Thu, 2 Apr 2026 14:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HwshQwGEYEPB4ewYumRkBFMYexYVpzxnnKi7Qlm1u/c=; b=JK9y2rzy2T82T4od
	hlXEty4Z194J87BnMHPKV1Xm0zaIdOavDzvHIjzVTkZJFpmq8LtbZt2PyzyqSERt
	iQX1gQmPRsOF76azXI88JRtsbXsDXgT3NT4yFV8RsE5IKvIONKrLNac/yXF6ME4D
	gDkbIdvlcTi5EApn7Kn/UnAaLdseqaPM0fRI08GakZ1U01PNuGh/VdaqIHkOEtpp
	qOyzEzFHQO90FjRnF4aiJ0asS4jiHtmmcVR7beSN2+xHn5rR6csNXKG5Zshk+Vj/
	SiHkOmaPKwcq6vdGdmkMFZOWXvebEdUC75QaCSfonmbkt4Gcg3l2ovpOUTPiktRC
	nCZxUQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9aw5km71-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 02 Apr 2026 14:15:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-509044f54aaso25833661cf.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Apr 2026 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775139325; x=1775744125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwshQwGEYEPB4ewYumRkBFMYexYVpzxnnKi7Qlm1u/c=;
        b=R/8UgbflCpIdNl7rlyqsfe5JWzWKvWzXy0jVTVogafCBWk8zo89fLZdiivw2tlDH1b
         CCbflF3oAgeKd9s6KAEcAHDrYC6yZrUj73ZUhwMWGlj7YmsJzSdRdGGOqrvDPIZOb6sT
         ZI8RbaRt6DgGxigPc+rGQV/6tk94b3/DAYg3y7PDRi/MjtnuJVDGa6AZWQgcvWCQNUEU
         4FSn4xd+Ww5mkPj1PI43ps+13sucR2VKBIRWc2cVlcHfE8ERNvsAy+pO54GZwkmYJprk
         nSV2hKNwa5unSpK4YNpOwNGuluZQXPrbz99pbT8Vpa1R29C88MnxkeozxkQk4aVulg5c
         J1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139325; x=1775744125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HwshQwGEYEPB4ewYumRkBFMYexYVpzxnnKi7Qlm1u/c=;
        b=saSdg/igdxcBi0MdCiuYfs58MBiCLzXbIQLSf7BkaF0cVnQCzaZFL2cPu0YHcpJ9/1
         8n1cAXFAH5ts4wBqYyOD8/3iovNe82xkaGXHyRZlUSiRzHwAm//Bp0dqBTKZris4Hcx9
         wdGxU0nBN7R77mNenxDkK/ffwqhL6gsCoAhcfSZeuf+ur2OwITc2dmRR7S+9MDJDb980
         gh/aqJECqzLSQqYXWRjGawO5DeAH8l/67ZkY4ceTIWNXQyBbv7R9ZkFjqohU3t0/MM6A
         EGWWHWQBlb0ka3QcLQhPibam690K7WjchHyxFF4D2XfWgETVuGZz25Pgmi86sq6yhb6Y
         iRSA==
X-Forwarded-Encrypted: i=1; AJvYcCW3pVWq+JqJWezfQQ9/nY76ylX49tsYlmCbHCE3N0IHSjlnbICK9iFVNnOcfjK8pRDrFy9fRc9ZIn8m@vger.kernel.org
X-Gm-Message-State: AOJu0YzFxQIjo9dIBPBWSc0Y5fJoGHYSyZOhutAHMvKnRFh+RfBaCYXN
	Iyr38S6lKYNGhRgAF7hqtulSRE0O/iRRncNrGTggf7yJuH2Jtd+2Ft/yY4KEsPxAb6OKNL5z7EE
	f/ke097jwrMGiXE4pc30+CrMYGYEmlrthem0/01JJLPYWdjoH5P5U5IDG+5VlButa
X-Gm-Gg: ATEYQzyeR0PAtIZ6iWdOVnJKPoo6n8ufHb6sZqtaM/FUPZJFTDWq7DdxiG3Ei2Lz2kI
	TzXoEr89d6xGvgR/VGk3zoCxQjASvEj4zY08xkMYEVwjfBrvywwqfe3VAuX38S8R9VqzLS0a7V+
	CeQbVxzn8zhTt6ADXoYnTjd/kRFafbAJZKYqeP0R9VW+M1EHPDWR8uvTNTf7sxJd7dJjRbOYxqd
	AoQxmuIKKnUC/+N9FnUGrI29RGEfp5uyldwnHaLn0O+x1WGFLrwPlX4n2GTR5qrHfOVpqZUkkMt
	rm718qjXKfmCkKmXV8F/MIrWHGHhuz2dL/PXe6XVjuYj5D/LM/4nKIYlW8WIFutQ8Wp+m5zMbgZ
	7oCzTHJ0qX4LBJh2veMvepk9YFJLFhF+prJMuNplhSmqAn14al2o0
X-Received: by 2002:ac8:5fd0:0:b0:509:2822:670d with SMTP id d75a77b69052e-50d3bc2a2f8mr109666021cf.27.1775139322509;
        Thu, 02 Apr 2026 07:15:22 -0700 (PDT)
X-Received: by 2002:ac8:5fd0:0:b0:509:2822:670d with SMTP id d75a77b69052e-50d3bc2a2f8mr109662421cf.27.1775139320358;
        Thu, 02 Apr 2026 07:15:20 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a5e2sm192824885e9.1.2026.04.02.07.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:15:19 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 16:15:03 +0200
Subject: [PATCH v5 2/4] software node: remove software_node_exit()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-nokia770-gpio-swnodes-v5-2-d730db3dd299@oss.qualcomm.com>
References: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
In-Reply-To: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=776;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yBKrNw7YytejW291mPySbI6LGBLYwN1ehugPvNfrHLM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpznnvGSCWONe5TLbuQtSrY72fMOoZXTKRAcb0s
 mqhmDG1RZuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac557wAKCRAFnS7L/zaE
 w1OUD/9OSD86XkGc+sAjVkMGHKvcn39N4RTc5O0XXVLyLfKn8tE4xyjvFcPy+smX4mZyqyxcO9v
 QE0Y54slQVt6egHK85JFznO6nDzDzrYEI4wJnsTzUyRS/cE23bZdQm8DFkgyYgP8SulxVAS3F+e
 d+SBdsaUs6fkx/LqtPKOc1XoUXMTM7FD9IhjioyMDVXHUHCGcx0x8d42mPmg1PiaQLThQCwguoy
 sncbcYKbq7W+1u5FKq0JmITwHq57JrwfABCNQI0X1hVrQlwTi9AXAto2/4SHQww+mzBIse1gNU8
 gjo5XvNYp5r0dqhHoq6mXrJ0+kOV6ElLlHCw6n+vrXNjmMzdcz5Vccwh0z7vqIkRJvZwoRaBhHm
 0xKIF6wX+eB1TQyioX01Sn/QUuJ1WgrEdOnx2t0/EQgEJVzp2gqeJLymBvCvoxDroUsRPyF1WdB
 P5fB2uoHdxlEid8l7NJPUtghQ94mOdP9pf16fIt+hn53sovq4v/O3tkDlVDcDL75pxTWYHkk+UK
 KmasIyRWS9Slo0MnNObblidd2xrrH5qjDmYLxjMyAdowUPByvMTuTwsvG+2F6WNzAF4gWsc87h+
 og8McoR/tx9in0Wch9REdNGOErbElO7/2aTCUayieZjXfpgNFbzdYNUbZibB/Y/2s/wiEhPOAVW
 oB7blfpwAAyLd1g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=Q9jfIo2a c=1 sm=1 tr=0 ts=69ce79fd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=mhlm9Ems92mV8WSaVUEA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: -hJuxlW2hnIw1Ag3_MidxdLj10wCMjAi
X-Proofpoint-ORIG-GUID: -hJuxlW2hnIw1Ag3_MidxdLj10wCMjAi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEyOSBTYWx0ZWRfXxVZ/aY2Ommxd
 zEDR5FlF/1sKfpBhqRlRFoaXCtpxpMkywpbVuhjDPgOFUtxLMydmWsUjH5ksghzoIoTCpAYpIug
 UjCISb8Y28lyWBSdaOHV9Tu0PlwsPKNMGXou4rucbj5WeK5EUw/pmMWCCX8stKcjn9xty0VeYpZ
 G26pzTjXnSBszGboji8Qkjw6RYCkb/AdcK8poCR2XStseX0w07QE6wGHiMcbsS+arkyKDR7fVb/
 WAzE8Ftp5ef0532DR7HFtnyTPVgc9d08+6OxpxgyCC+Ln2rdNT0z+CbU7Xfxh+73AGHPtKLm/lD
 lytVDQdGtngkgbh2buafHSeeV/SD1xatNyLDr0MWOGYpDjjOAlxC9P189vcgVw61dT9xrA2Etbt
 /jkj3cM6nKs8zmMzadsuCsKmF2104gsy5V8bgxSUfz7ikMSM65FFmDxh5SexAi89AfBMpeYVuZo
 Z3Bvli9H9chCT2aMW/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020129

software_node_exit() is an __exitcall() in a built-in compilation unit
so effectively dead code. Remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/swnode.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 51320837f3a9f1bf4f65aa161d9b941affc74936..26cbe1c2a2e043a2315764085207561069c23ccd 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1135,10 +1135,3 @@ static int __init software_node_init(void)
 	return 0;
 }
 postcore_initcall(software_node_init);
-
-static void __exit software_node_exit(void)
-{
-	ida_destroy(&swnode_root_ids);
-	kset_unregister(swnode_kset);
-}
-__exitcall(software_node_exit);

-- 
2.47.3

