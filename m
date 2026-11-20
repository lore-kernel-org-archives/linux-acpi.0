Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178816;
	b=IqL1RntKCycbrhtRZQsGSGkI5U8omknGAKzV6wVsQk0QFnvCnoq1Uk0cfXjt/8qe+oLL
	 elulEkslTNZfbm9q9mZwCpJwuLDZMcXrozZHmrwHuahJwVSFd0vI4yTR+GXCs5jVIvRZt
	 RFFxXY32w4wqhohnoGqDqRFSVJ0JcsyCZoH4t310S5QGwdEel108HU1l0iRRe6LRT72LE
	 CNsC1ZScr3S9l7SCeKdPuyJITQlOxA2KIonyweFTsrwRxsA7csVg3h8N7AS6/pDp5D0EZ
	 Lh3y88Ec788+J8WqKkKIxj20BDp7COjpAGhHmP+sgKVqiFF29UoSdA37TA4GXH9RU8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178816;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=;
	b=rn24hed7P8fg0EufUNf+UVHE8kdRxO6NLDoKVlF722Rg6hiBtrFZbDJD6rf3yEd3iEkc
	 ocHFx83eiS6hX+vYEPRusOwntcpLdW2bxflUAncR1FoJQ52ijR+LhWznFRuSsty/kmv66
	 Xzyr+KFvqsBN4tPLChf6L+kp0xWGNkNVhKVKDSCVMHdiRfreUICWdzx8wb02wws3UJj8U
	 C21/x88cYM13UkowBGQKYWbarIMU+aPWoPoOVXvw6xVqL8ikoQ8lNQqDD6sK5iWoExBPe
	 7318gT0eBbhs+dOIB2MmDfO/MQSw93G+JJrMM6lLRva6liow2QUNckuodzkHTLB0sPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R0QGU5oF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iSzLGaS0;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618A606A332
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E618A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R0QGU5oF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iSzLGaS0
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAk0FO3731648
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=; b=R0QGU5oFbZc24jaz
	K8JeAKp+DafQwKeQBoxLJHy9NZenThm3sYRNunrFmfHhNflJkG57Pc06Y0tXT3KB
	SqZxq+4s300d9D/djek7paTjIddyIBOvH+j4ldJnws3F0Dk0fC2OTq2fJ3CHsSHH
	BS2PivKuvPe/co8DBU0MghGe5/XjX6WZ0YFBb15T2mw2TWvuFKIsRZDZRYSMG8TN
	Q1tcme8/mDF6IGuHndSuVJaleqI2nkQ0ZWOmi4EzT9KR6kQcogvd9WhIS3t/KNWC
	YT7U6d4J6Aa6JrrGb1U/Pr4Hgk/duzmLevKcsBkat4fZdSNAoaYDya0g5kKZIXtn
	iXQTMw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2mm4gft6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:46:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f2373e9b4so110853985a.1
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 04:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795178814; x=1795783614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=;
        b=iSzLGaS0fMC2twSJZ6CHEvYwjXiIf0FMXWhLNiLgJ8Tbk+te1FE7nMPlqoZA0+zrFc
         Z0mMLMFfxF4W/FvqfOdar9BJPTyOK6/Ek3Wx/oSWHiIzWz3Arkd4E4xcm7jIcvhFH7VL
         L14v82dZ7Ag34vyMugl4pDsM+WvxUXeGFBLf3biCXkpXEq0U8pIOUYKv/6MdbA1OA1vY
         sMw9Qo1pJbp5f1xIxwA2JkUjG9DL+vfcBFKqUiEuWMO5cHx04PaFg/AGZnAwIGMAbjFn
         Z79U0Pm+NSpB3NMYHOYkeggFCm9O/d7c/BfP9WTSGDW4PVq9aJdCa82w2YqLOglqKbwc
         U0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178814; x=1795783614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=;
        b=LITlB+zouyyJaI/QwH3il39bbkXKFrL7iwZv15ntMrFwqWMuRXaxFu8TpmxhT25qCR
         8fjHkFhvtGECywXlT72FEgAxVK8aLI7QSALq42Y7KhuvQhL4duk/ba1fM7EMrHO85hR0
         xiuy5EvWrQL2d+LlqUxmjK+rghoeu5h/F2SEJKTPFcNmUxvTFIHUdR+r18Icg4rwyJPK
         s+nHhht9MzC9qTxHv8aQlEvl5zBB8Ss01Mm1Y8xcUGoHr0sWeZHO/eioeQZET5px/C+h
         KMIPSI2of2dIO5H+SXcgynU5fLblr4rJrNWWMU1Qm6A944mXCyPtaJttN5OCRmRZkvq/
         0PDw==
X-Gm-Message-State: APuU4Z/xzLXYwp/jctZgGCvzUJ2sZC9hFL19e+DpVAMfaKlJTTUS6mtr
	baYUypctRiphDSWv68B1EPHHA/50pN4eirjtrXLG3r38EOStTKJyOoWQJFSV8gm2FIyR9MBMaIv
	ARVMvg3joxGYNvJwF7AYthsC3y9Tw0Clo6Osbos9ErhOxoe3O6jKDcp/bI0IxkkRM
X-Gm-Gg: AYBFou3T+IRnVddxYXzraWTwk719x0Djtar4vyq4xCQ1oz2aedyncCiCiQy4Ebvp8Wy
	EQzSt1iEtpj4xScGmZJmqnwykcJHAshynXpE3shZRR0i91s3zPV6LwCcbFqT8gbx9o2Qd8UPPME
	3Dv67/5fSU6at3hqEybyz0Qf/5NxixnTkWAQFJm7SNlgfHAk6/hhWubIjWre7pHoogBKab/v86k
	OCa2+9GaDNwQmTZtam3Ry5cYnN20Y0+JLRIKzMBpJgAW/y/YSeOPLqrVJ53VMSYwSiCfWOt/9Em
	Ry04ivGXCb+yXA4lGXAmqFNJeiNFd6vV71KNycKBK/zhimrTSCgZxriurXRhtD/38mta5Rrc3Hh
	Nr2PF/81yEC0h/sJp52/wNReePfjcXj35wfwlyfBr1n2qeany8Sxhict2Xv8Dx43gYX5/T0Hx5c
	k=
X-Received: by 2002:a05:620a:4056:b0:949:7893:397d with SMTP id af79cd13be357-949ba9b8ccdmr519733585a.23.1795178814121;
        Fri, 20 Nov 2026 04:46:54 -0800 (PST)
X-Received: by 2002:a05:620a:4056:b0:949:7893:397d with SMTP id af79cd13be357-949ba9b8ccdmr519726085a.23.1795178813505;
        Fri, 20 Nov 2026 04:46:53 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm119248995e9.11.2026.11.20.04.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:46:52 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 13:46:38 +0100
Subject: [PATCH v3 01/10] lib: string_helpers: export and rename struct
 strarray
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-fwnode-for-each-prop-v3-1-808e304dc73e@oss.qualcomm.com>
References: <20261120-fwnode-for-each-prop-v3-0-808e304dc73e@oss.qualcomm.com>
In-Reply-To: <20261120-fwnode-for-each-prop-v3-0-808e304dc73e@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=hYScHpsRvvGBrMd1w71TLaQh4T+I7gIpjdQzKJBQdf0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrAEE29BUzYu7qXthMo1ziHpRFzdZUEh3WqC84F
 OGuKrX0zbyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawBBNgAKCRAFnS7L/zaE
 w34sD/9INMXQs1L2Mvsqvlku0UNIaFhS95oY+fgGh50hV8uPpZqYJ9NtZmpgskw0vpYis2Ro36u
 cztRSspCvn/1Jy3tnFXLHIbVPKIidV7uL/eo+pgDu2WooSCrpLxyVtDrCNZnyQY4rzglxSzgFmV
 20FtfdT647KzE+j63r3q2iadFYnTGomwGclZCfdpr3nExBli6ufhptbHBx2Q47EUvuQUGzvAV7k
 vyt4OFpD9PqxpFfoyXpBqT1Pgs9d8guOTsWXkbluTz0VOLA0sNtoMilnS0MvpxAe5azhLzRFSS7
 qrgJL5Vki0qb8jbx6YgCBxzPIf7Kmu6tQtg2hfjYCFsPj32pKplN7th3AJk8sj9qpLQIjomLZvw
 ZpTl8iJgw2H+oh6esb977jX6S5IxI7IiNqfg2zbHb308qdGmD7tw8z15idvvEDvyKO75tJHJ/79
 wkxPro8xFGpTImnweShdNOz9gkOVNue3adn56GhyY1nrWX3KyRYSzUskSGUEkAuFxpZkOAcMYWe
 SDGKXMcobp9/+IK83ILgxdB8ShLGcthKK1mx4mcAtYwMmbI3VBlmq2qBPyDJ8N6EyXkSnaNYB0i
 po/BVd4HrzPDYz4cPMbC/f4Ix9nHwFiCRJAYTkd89W28TI1EEtyp6D2bWlP3PDqIyCppC7jgWh/
 mWyRS+q1a+CyOKg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: ZDzmZqlMXGrVVtb9Aq_xXpEESYyy42ie
X-Authority-Analysis: v=2.4 cv=RZYFmFtv c=1 sm=1 tr=0 ts=6b00413e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=NBg0Ud2t-6tr7aH_vnkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfXxxb7U1eE7y54
 Q0GSeb5EShWqNjNzr4Xyr2Df4Sh46gLb34Ya32xV7GqgxfIwHkTFGiXKdg/Ovd5+RKCB4tP8QTx
 hShG61MHbHu36flZNFv2cGpQHTp0yPc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfX9XbRHYKeMGLU
 EKqMaZwvYfsiFqw6MrYmDlGRqEfVktSRaur0FgWm1ExPzm/j8632J9Zab35oh6kLkw8JUiZzHGt
 90p2OahmS5UwKtzYVsANh0usET9NhONIaNwY07DvrRd5IoTcsUoIQf4NwqQyD3LFRFXoEyzOS9Y
 0qlSiLVl2ea/HXPH1AfkwkwGQ6woOj6BowqhA6fwhpF8V8cdDpFfdmQ1krOTQQXpvdvs6ZHFih9
 idXcfl++A5vzwypvFK6lDH8vFkOqNe5GLPmBKTSfBy98yTAXTfvah19RKcLNEHn8p3kzF1vMow1
 u8skrK5GAsmSKn8FU8y/td2zM6GzzvdECPj+VW175m2MgWOD378DdfbMpJ399R3khR/T4TGw6JN
 i69vd3kAIXxuw9islRPUIbVHQinBKK0KE6S5aEhGuuBnizeQcGnS7LSg+OWACKAcN6NdgxhgCPJ
 d/+mIyrbXJ2qzqIgM9A==
X-Proofpoint-GUID: ZDzmZqlMXGrVVtb9Aq_xXpEESYyy42ie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200050

Ahead of introducing a CLASS() for string arrays, make the existing
struct strarray public in linux/string_helpers.h. Rename it to kstrarray
to avoid any potential conflicts in the future and make it clear, it's a
kernel type.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/string_helpers.h | 5 +++++
 lib/string_helpers.c           | 9 ++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 3fb88a1e989833ad5ea1a46858efa16e3971bf08..c9f08066439bdd33cc26e2054dbe1ba2e867aee7 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -116,6 +116,11 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
 
 char *kstrdup_and_replace(const char *src, char old, char new, gfp_t gfp);
 
+struct kstrarray {
+	char **array __counted_by_ptr(n);
+	size_t n;
+};
+
 char **kasprintf_strarray(gfp_t gfp, const char *prefix, size_t n);
 void kfree_strarray(char **array, size_t n);
 
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 98d6ed0eaab7e9f3d54e420c404629a28b925bf4..8ec7ff6dac1212fe8a1f242654944ba6e5568e20 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -804,21 +804,16 @@ void kfree_strarray(char **array, size_t n)
 }
 EXPORT_SYMBOL_GPL(kfree_strarray);
 
-struct strarray {
-	char **array __counted_by_ptr(n);
-	size_t n;
-};
-
 static void devm_kfree_strarray(struct device *dev, void *res)
 {
-	struct strarray *array = res;
+	struct kstrarray *array = res;
 
 	kfree_strarray(array->array, array->n);
 }
 
 char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n)
 {
-	struct strarray *ptr;
+	struct kstrarray *ptr;
 
 	ptr = devres_alloc(devm_kfree_strarray, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)

-- 
2.47.3

