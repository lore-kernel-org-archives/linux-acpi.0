Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801058;
	b=4seoZpEPuxq3/oxTlOjPCAuSAaoZBP3WPbxzswicqRHUAvUCx6NAW+PwNnAUWoGAEtjy
	 hj8Xj9vdpI9Lwh07RHuw6SS/VouP9vEAfDE5vxhwplmwoH+z9o/wPab5Zux4CWc4IiTLh
	 OETc2GZNM8GKYq/2RuD7nB9rE8nS1IUSSFFQax1lCGNbBfiXUkHyF1FgvfxqopEbAZjS6
	 gULXH6vCWlIcttDbvORmxvvxxiQ91atBkXHADZW1fqA6e7kEG66g1XowWuShjIcYf1OyD
	 Di2XA2thEx47k+Dofzk4x2nRiy7h9oYvFIF9I+kbLPilpS9q4CGkG6QBaUh4pgAwBqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801058;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=E1AqakhzVdc9Vv48h7Bt2KKLj8pj9gQLGMHQuyOjDKY=;
	b=I78FFTt3HZHfpVNCLum3xSddWA/Vhpo3KnIgTqLZuu5cd0ZjsoLGeKnHmDjdJXoYqIp4
	 WPZJnUutSrJSFI1nGxrlKuzvqIroX0fM/3LlZuDOU31ed9FDceNlGbiqRI8EDRHXxA3xF
	 JcjVKCLsESYw7PG2sa2NsVCXLrhnFe3TqwKVjXyPrWSf4oDoFjKvTRzk/+n4V5w2Ot0mH
	 trCjBtF1HRsCoLXnruriIwcVuBZeCiDxxk35uERgUudpoKu7jHaddLAEoM5LgMEClIa05
	 ypXVtn3vQlnRWfN5/YEQnF9tuy96vBovJ+hJ2toigDM8Z2zIGWVtC0ZSDol4xurNDfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hW7tXMvC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OJs4qf8C;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15456606A32E
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 14:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15456606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hW7tXMvC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OJs4qf8C
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BZmLI739122
	for <linux-acpi@vger.kernel.org>; Wed, 4 Nov 2026 14:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E1AqakhzVdc9Vv48h7Bt2KKLj8pj9gQLGMHQuyOjDKY=; b=hW7tXMvCQpuSSKtN
	ZFd63aatRREqxNb/XXFLE6kATLNEDiKcpvjMvAjmx39RMsGxDeRD5HsnP5epFx8i
	C7VX5AhR/CS7+Kz+Hc8bHQYjGtRDRzcKW0AJMtomtI04C6denBUTQlrW+cOE61g3
	wcFoo+1OtUxgc/Axpl6QascgzF2dWBsFgQCota6CxqKob/Xfr3m5lC3OG7Nzrq8X
	shy8CFc6gBQWyiQCU/8XeClybsI7Vc4YNFyP1eWoxBFkS7sfb7Abq7mUlfTd66lr
	j0MZJpxFrVVyvYsF5pOhzRxflj+eWAlkT4oLT0C/uLmh68Re2kCZr6Ma65mnPw4U
	ez8wLw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr163hagj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 14:04:16 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5ec2ea00c42so565308e0c.0
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 06:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793801055; x=1794405855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E1AqakhzVdc9Vv48h7Bt2KKLj8pj9gQLGMHQuyOjDKY=;
        b=OJs4qf8C2UkhuuP7ZEbLVGpACKHKALOZhpMwx3Vyb1zRw2SkWVVIbzt7LfurMIJqb8
         IraYE5wPHd8K+DPdAAtovzrEoE53gLn7tWRSFrzITPewgAsV00P4wZCrTBiFNhAu99Cj
         IXM/0gWCVMSFie8fktM8l0pya1GHagLk4ktvx3G4eoqR8e/sXqbEtsy3rbWIkAPLYYjV
         8p++aQoITlIM+U/5mUiBLHIooBeBvvRyI8GfN81vFaCSQOYI9wEd1eOvQ1AoSxwl4ZDv
         TfRKsdDfNBDRmIFt4UhkeW+H5e7uCQ5A3pNmB9Xvw3w3A71UNc8E4fBroRw4002uPIe3
         3XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801055; x=1794405855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1AqakhzVdc9Vv48h7Bt2KKLj8pj9gQLGMHQuyOjDKY=;
        b=iiG3R4EcSjFImapOKhclYuMesnKh+2KSNinl4khkVicvA3S1wgGzUgStCW6YarKbAT
         ytajcoQhlobbZ9tI1BSLRKX601fcOBCoiuvPGZZur/R1Lr3DGHQom4gFa/8GOJIKdzqC
         aRQ4eSmHxigN/M0PzQpGvx0oiCiyGPtOAYVSa9N7ghKs45L0LC8l0VDgtAZjF8jY7dB2
         B2Hwop2xukhjEK/+FZiPGYbSWNZm31rDm79pz7y5CWo1p7yWGqZ5dmDeF6B61qF7wOUL
         Di7hN7WsPo17PZZRs6sSFI5AP+Sb6cQ3ywSitXAbP9yOOnpNtW1TzBgkCDOSuvQ5iHxM
         7LUg==
X-Gm-Message-State: APuU4Z/6/CS/W22LCtVQtgH9Crt6mWZj3BBqCOIaIjWe67LPdWBil2id
	RELXloPSQLJar45bp8sPQG29jEtEy+uQ+of0f3bfDKg+nOpF9jTPXNoorhchViMEhvT1LuvAft2
	4pK5zfrG/6rDs2N6SNbm1ezZL3MS3/IYOY3AsPEgh3SjK9SYadm46T3UzgDYMLPWs
X-Gm-Gg: AYBFou1hDVioW0PxuWxOsCCHuoA4ZiVFxMK5FRx+TgzMNnegCMIXwUC9BTsI0kh1r4F
	OQhV4JawFrMmyC4XIc9P/x8Q868ou2xc6Y2v/IC4VZQNMkkAC1WoXK84suqRad8j6aZ1zEti7cG
	AD4gjbRhuKecFfQa4Z90/bIVJHPL2F339SpD+e38VxnHdN1F3iMrDY0rmH70tud9vwUreVGQN32
	iOodcw2xcEJqJQzjkkqbjrVSvR3YlUuXhzUeqifeTJoiqyjNlcaj4grwlT0gmm/eWyiwaqN1L6M
	dtcw66TQWT5VFFlTh7swOdzAcc561gRzjfUKkb2J/c9DhMzL9EAOom6sgySCrFGawsQgnsEydzb
	+H2uHOQbBtNfq3MSSdLZmD4ejkpi48GvtkosXGx3a422p0hPw2qqV3LoyYQRuaig=
X-Received: by 2002:a05:6122:c155:b0:5ea:ae80:c97c with SMTP id 71dfb90a1353d-5ec5879d16dmr4305641e0c.15.1793801055250;
        Wed, 04 Nov 2026 06:04:15 -0800 (PST)
X-Received: by 2002:a05:6122:c155:b0:5ea:ae80:c97c with SMTP id 71dfb90a1353d-5ec5879d16dmr4305566e0c.15.1793801054567;
        Wed, 04 Nov 2026 06:04:14 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d87b5sm3968358f8f.11.2026.11.04.06.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:04:10 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 15:03:44 +0100
Subject: [PATCH 2/9] lib: string_helpers: implement a CLASS() for string
 arrays
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
Message-Id: <20261104-fwnode-for-each-prop-v1-2-6e28fe1c72c4@oss.qualcomm.com>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
In-Reply-To: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
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
        Linus Walleij <linusw@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=X4m+GBtBmyDIIU2ymTvn7JPXMmdv3wdDg2SwxtGCMic=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6ztSySWtk1BlVtDvFLGvG8VThjJrWy5dSYUhX
 +WkF61XXdeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaus7UgAKCRAFnS7L/zaE
 w6+4D/4j7k8c1zrVHvsP7FPnP0L/Otl5Fq+MKofbzA4D0w0BETcvM58YVvJIHn0rRzBRYjXgFv0
 9qXudM0FtJwygIzyfZIzLte56iIzSHDvMIEkS4RdkjvSfn/EImsCZvUHuLS1FwGEHAY/L8mjvAZ
 7qADB4uj85+JnI3rgvVNZO30GttbJaZv7hUd/IgsvP4X+WqtexFh+HDOGUoca8rX+2K2RRlXDmB
 xXan6FU77l2TRtc+/356EJklrHHYMCS/bcWARKNjk9scpRFZY4j1z5ihdJBNcXdo5hZQfPu7iC2
 /92H9utwbeeMTc7+9VMLVIp5BTnmA+3t5Uy9tm1H0qA678k2SpLmAjHjIqTDEnvJcuTMZZzhECm
 3zQbX1fOX28Kk82WsaTU5j4Q8h74/YWhmpbsNgmOKrVhOoeDPKs4PqPqb168OwbQBGQ2/8cnefn
 lmQ/Hk111jcr4umGsCttNdWUsG7GaK9fzEnkisIUJAzZz1DFKUL76R/H8Ldg3V/6YsMf6Sho37w
 VJp5EAu7XJcDdQ1cyN29EDRHxXg5953KclxYnuuRSHcuJPQ7qUgmfwG1Fp8I/T1hbw5meMS7Uul
 RdJgx9RGQanZK2xKrKQ7BjUaUOAUmSHM596KQlL7gscczn/73v0KSu8d/plig2FW1xjmIPHujHp
 MVDUJD3sOPzk3cA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: AggR64SzI0ry2VvGoebxOyk0bJHyjMQW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfX42UJBTO5bHsA
 eledamBUJMZ+ySt9p+FWmZgoXurY95QGqLJeAxm4w1IRrwaH+wmtdA3IEO5yLglG32xK/vjUG26
 03TFXcdeW5AnV87GP+T7RCYl4sPUh48=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfX2RoDnkJLjslt
 /tUDNKYHT2h7zVTlUBAjzKyN7kNbSF51iDsXTUa9V42+hoslLJDSBcnhW9OAx//Aa440Gi0MS0/
 5JvlQ93DLfqlXZNLwFtUefqu6UMn6ArI1C7HOoDATuzBeFRi3y+3/0fxNBQDRvmGXis4I6my5DG
 ZtoU48gKv5Q69SVcZ51WjQyTfOgtEP/AtX4lEjoJTyTi9A/goRW71LeTUVNL4EvcTkjKhBwCp7q
 qC5aX2ZYJSzhJboZvGVCA0sp5GEZrhWxZlgmqvyu7CJHYuxdlUey6SLGV+4jKqkxLIJkDR+exHM
 q5UFQYV8c67sjqfgFg96o1/j87NBsV6nk+bJUwoDiF3M3J3rljU+QXw3GD2TYForGk20NmKOAu5
 QJXw/rKYqQ46otRd1KC5kQx6485uHmJXwe0THcRSwa9ADUfZVide4j/SOMhkzWhJfxVDdqET7t3
 kbdFlbSCPofPoKu378Q==
X-Proofpoint-GUID: AggR64SzI0ry2VvGoebxOyk0bJHyjMQW
X-Authority-Analysis: v=2.4 cv=O5OsLx9W c=1 sm=1 tr=0 ts=6aeb3b60 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=lR0QwHyGZrhmQDu0ocIA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040055

Provide a CLASS() for managed arrays of strings. It can be used for
automated release of temporary string arrays when they go out of scope.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/string_helpers.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 3fb88a1e989833ad5ea1a46858efa16e3971bf08..3122be1359a36272190264d1c3e4c84dce785e6e 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -3,6 +3,7 @@
 #define _LINUX_STRING_HELPERS_H_
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/ctype.h>
 #include <linux/string_choices.h>
 #include <linux/string.h>
@@ -119,6 +120,17 @@ char *kstrdup_and_replace(const char *src, char old, char new, gfp_t gfp);
 char **kasprintf_strarray(gfp_t gfp, const char *prefix, size_t n);
 void kfree_strarray(char **array, size_t n);
 
+struct kstrarray {
+	char **array;
+	size_t size;
+};
+
+DEFINE_CLASS(strarray,
+	     struct kstrarray,
+	     kfree_strarray(_T.array, _T.size),
+	     ((struct kstrarray){ .array = array, .size = size }),
+	     char **array, size_t size);
+
 char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n);
 
 #endif

-- 
2.47.3

