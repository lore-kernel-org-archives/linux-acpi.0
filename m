Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584835;
	b=CCgMgeCn5/aQOQmcUngjW6M0ONmiipK8Qlk18yKum9evRm68qhRTVhwbrp1bABaevCKT
	 W3zPqOgalkCP6kGEZ4Jok9CGqYMSxXoTT7NO4FDgsl4rkrLGXLscha6YswpIfR26K7/Jr
	 k+EKIGl9hHu6SycnN4/wbaGWuEpAeH7KK+42XmTp0LG9Ga68t2R49sR7hJRvF2oCygxC0
	 ZfVFC6NAnR9RsclNvowQysuh56Pc/ZjgSDiQAjPbVaz+6kMi18E1ZHbHhdZSzX9X75zbz
	 AewIVYWqv5LyzKvgLV66puJC4SRcUvRXWKf1fNbAHyORc2oqSykoLnAlRc7BsC0lpBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584835;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=p0SG/UcU30V2xHOD7lY1mRa6oni/p3PRzhrNY3Gt+7M=;
	b=dA9YX+61F+qH3FNjDEFT3lo6XFqBM68phsJMPtt8gHYD2i+QF0qq0ttWhPSFGHNfQDTP
	 4MOMQcL7mBf+KtqkOc/0v5GZq7QPGEYkevXMANtKZ48chwSvZmgYAwPjmIB9zkR3aFvMi
	 7ejWIZSZ82Xo8OqRujibwpSQuA+/i38ZMZSCRGpxPFS2qThnIh+4Uor9G35fI9unkPFED
	 7qV04FmRLWrwoesNJZu81GhccZx5g8XQsMUfj2mTGs1myjt7Hvl8t941MojWrJqt/tEuK
	 pnxhTc/wy6YpIKO8xTJNgTCejZ3Rb7poMx/kbliDWiyOxw9XqDftDc37B6G6HiymYOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FeHmIXaB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fERmXGWD;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FB8606A33D
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21FB8606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FeHmIXaB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fERmXGWD
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFR5SR551868
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p0SG/UcU30V2xHOD7lY1mRa6oni/p3PRzhrNY3Gt+7M=; b=FeHmIXaBYieL6OxG
	t6WUzojIA0ZKYBDTI8hL2F5VD7PdZyQVhoF8QNKqrS4mA4n6iJaAoIlvnhonIEDA
	Lm+z6C80W/reB6J2KTaV9ql5SlXhPCIx0S/e1r30MiTWPHpbPPeAOveG50n09PLP
	RuEIPw3JoY4Snyp2Ot0CQeamBYdrL/vpaJhgvLr7vb1zRDmqN3+qLw5Qv2PHPH1t
	yxSb3kAX74B/PyMVEmo+5VPpHHmddiEpPW9fk8EJXJL1zCoVNbtxdD9EsGtunU6W
	u3bby84HVmXrzZcBZKmoCOZT82WZuuh5ycecA34oL+5vjPSErYRuu7pShRxq4WKK
	h4OyaA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwbp9y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:13 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-999ef3a68adso125872241.3
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 07:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794584829; x=1795189629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p0SG/UcU30V2xHOD7lY1mRa6oni/p3PRzhrNY3Gt+7M=;
        b=fERmXGWDKC0DFc7eNl9p5nCD6MopVh5rz2Ybo37Tqlpo+aADJJOZv/f75BAZXxEWD9
         Ic/NY6NZhPDOS7h/eth5157Gqjpuxvexwa65cTrq33NLECDW/Tuf6TMC7x5rdqr1R/A6
         WuGxWPpE3IXnfP04pTEouMJUD3Jdh7aKuBy45zCVPr0bAFstXwVJ4Iuj59Q4kE8e+nuV
         Exht0CXXnyybMB9MFskXBGWVFZV53Kk2yQbB4rvEgflh0P3CS+a+pv/zc94KkPPuAuwp
         WNHRgCa/DtDFZEnZ1iU5XuNsV/5oSCJb24YbqJUZoMyvSvtNDG9CnPX/hKz2XcmGpdqT
         UmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584829; x=1795189629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0SG/UcU30V2xHOD7lY1mRa6oni/p3PRzhrNY3Gt+7M=;
        b=Uo02vDClYf3djg6+O9bbkXabRav2fMeGTOdNAFLOtU3Cu3bpucVLquutpU+Ft9zFA5
         nVqETgN2ZRGOhsHO3vKe5sdczohe7HsUjeeckJuf4QPLWERx7gKecBsWjDKB9FU2Xr4I
         eqv/E7ea7b0ixqnKwUSLo7ckyF1shFfrUpU2VT03r+Xp/8iBpFm7fhz3nrfIxixsmaTX
         3uU+cyIqegzmLq4f4/Krd0Au+7XAm2CIWYRjCPgURGrdUvW3T+PVaWwafJcsQsrS8KeK
         5FkuEnIAXvYWwX+RuNWMRxYnH6FPRN4Uu/0ZnfpUGqF2lxfjmxAuUQ09BmMNuZPbkOGL
         HLvw==
X-Gm-Message-State: APuU4Z8hEf868cBsl1u0Rcrv7s0XNcUM0w625FfyhDva+tyICYGWTFDt
	JJ96XJJ1wbaX6cuJUgzV/fDdHaJEV2BTVmAG4saOsmPjBj0dQeu9FxEdI4jRpI6rs0C6jmE7b1e
	r4N92TW+dJPs0scVuj9pUq0bUj2hzDdsxwZOH8OEzECmOszSO8FQ5dS9rJaPz7U9W
X-Gm-Gg: AYBFou2FQ+kcq9ANkm2NEbz1ZKIx5j+FZR6VFTqvZ4wjTAJy513MdgJEsceDDGuaDjp
	SokIUGUP4SQYLS0aB6o7poENnNyUkM1He+wIa0JiX2MY0EstrPLClDgpzKqyO7izs8d64uokizm
	aD+zdjUhbRBUCEMmueHNrRWrE46JFow6lPnMvJYe6Uf252xkio8rhQ4goum2XEZ+QU3+JN7k7Gy
	+7wXsVTdN8mxdzsqKmZiSkefQZ0wU7Va/smV0oWDgautQLd/NeDY8Nu/j1GLAiaPj3Iepd3Vb5p
	yJOuoLLqX/1KJbPRZqHuokUP1lPqw/h0JrEdsk7Wnz77kGBk/uyv9qNHdS7DWmCpaW6TviezWfu
	ZSWtEs2e8QvPIr8ykNW8i6jhraRAOrIgx00W9zmgehrunNxFMF+NC5+LFETU2k5VupP7TWEn3K0
	W5Jg==
X-Received: by 2002:a05:6102:4426:b0:7c1:5862:a97c with SMTP id ada2fe7eead31-7d64d874efbmr691227137.37.1794584829199;
        Fri, 13 Nov 2026 07:47:09 -0800 (PST)
X-Received: by 2002:a05:6102:4426:b0:7c1:5862:a97c with SMTP id ada2fe7eead31-7d64d874efbmr691221137.37.1794584828711;
        Fri, 13 Nov 2026 07:47:08 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm5636519f8f.21.2026.11.13.07.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:47:07 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:47:01 +0100
Subject: [PATCH v2 01/10] lib: string_helpers: export and rename struct
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
Message-Id: <20261113-fwnode-for-each-prop-v2-1-4edc23d5cf50@oss.qualcomm.com>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
In-Reply-To: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=m4NpZDP9wCk6X2lLRZntvYOO4JCGmA1kZu5D+y8yR/o=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq9zD34fNGOw3Us6Spsa8wQXUoWktbw9LNMm6id
 xSi/+Q9T62JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavcw9wAKCRAFnS7L/zaE
 w4MUEACv2DIA4WBHencGWJ8xeH2XgSLKF7rWa1HACKBslDnGDYzgFtvP+WP0BINXGHsfU9nEWv2
 R0Zm5zbET8Gud9t2ocSRdp2QCz5PYjYlIyW0exI9eU6MQkoyCiNwN3PqBtAAeuQYsozHdBLGZiM
 DJXl8D2TQ4ZCFALyp4kaXFiFCY9CsM2DBK2FYee8jDAlx6slky2/X1htkINXkjpJhfpzrm5UIm5
 Hxzp1Wqr1jMO4g8ioJSpMqufUAeeyY/lFruejpTFY/HZtzc2jGoCVUMN4qf8hbuRGux+Q4GjO2/
 7E5wjbT/k1oSyCFHIYLZnNjdqSJ6xD7X2GOB1rE87UEqPdNY+si1LIjCgKT6WMTwJv6kP23Qnne
 2hLkvRYovnawknJkWeuffSgA+ZqI+FIYin9iG6P4ik7sHTUjsrIeNNmnbgELRdTbXQ5GmsAPDuc
 ROpFolb5danon5vtph7Z5zqjvc4ZJ27Qbifn0GTweLFQtiUDImuojNNiDaXTLLRcbQe6I5SAoNa
 gCSF69hau+bYvtD+vgR9qZVpo51TFSpCKyJYNJ8FYD++1VQGvW2v2yL4nFR822R8NOD3n1hjFtg
 cUZPDoLO6nxfU60mWZJvYgLDArvSgi8rkk/yu38ZYS5DdSNmCxcM/Fq7jv7wMlHdm5w0uTqK4Zv
 Cn/CsMAdImuO2kg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af73101 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=NBg0Ud2t-6tr7aH_vnkA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: hvrXkxFRO_CR1OfKQm_4BrwJeLj4vnVG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX6ykCL0vf2/zE
 CZhxzYs0xfvlcrNq5K5FroYFWIlJL67eujZ2eL+oODoUyUhyEcMaVgS7Xl1OMf7NbBjQBKXnMyU
 NQsHxwdI09dEx+QUaukF8p4q7ROwpt3ehaWzboGt7h7hwKoepNMB8BFIxogmWj7v2zSUOyndmMI
 4nMe+w22njL/Yz/7kn0tAMRTZc7M7wUi4fCIy9C1HKXMmCDfF5ni8P5WgQxL9pVbRSn8x7z1hLj
 H4iWNZk/mDjwtVurWaTpO6rFh5qGyelQ03y86PxrT/BhIPM7eR7KxLojdbXh4fFzsbshhEG8vn7
 hTZzjs7rXuPZpQQlQ/Fc/WpH6Qi6PhAhq7y8XQo1NNeiVNKPLSATIRUpPCGvM6OV3AtYiK3pQ6N
 bC3FBvZx0S9XknWiXoEyz+NdOoNA6CrzB+itnNli26l7ZwzrmZX0g+ButMJuOsVxUptTio4vmRn
 VFbusEyBmHVJRtsO+RA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfXwBta9WDxEruj
 /HpABxAKA8G5pHesBHK7kx+8jkrMfEVkNtWfY0oXWsnHEqadXLDur0B2Svfgj9S34E0tIqWhp6X
 +BDrIMahAQFSqy0CDAmdtTAxZImNc0k=
X-Proofpoint-GUID: hvrXkxFRO_CR1OfKQm_4BrwJeLj4vnVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130062

Ahead of introducing a CLASS() for string arrays, make the existing
struct strarray public in linux/string_helpers.h. Rename it to kstrarray
to avoid any potential conflicts in the future and make it clear, it's a
kernel type.

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

