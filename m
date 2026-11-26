Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685789;
	b=LhSPV3tzezOsxuQYEbtmFbUqdKHbSiVnHlw9jYb63tnxnb8Aw9dFIBKTfVJeYMYRSSCc
	 vp0WE0HfkWUUiw7glrQFi2IHgi/EomwCtvjG4Jx0W+C/y+QLZoyK3p4KFihqwrnqVUxqf
	 I6XGgd3DCN7i4hS+m0PBlbMiR2C4hfNeewI0k43Qa7F97g0BVT+nmJkotjRIoj5CZYUxN
	 4mFZoauaeneX8ySGoyLlOoSX6wkCx73uOV34koV1RSh32fbZy3UfxDSE9Q4u9z4MiFfXU
	 8NPWGO3TEEBmPG2yl+otjzukb+BpDTHD+QLhoXzjDBBpIV3Y0d2Uz1IWlBrNsepP3ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685789;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=;
	b=pEx7UhBejZeUabf71CuA8tnjvHvr5c7WIZLpAcwDniizUFBzy/RrNBkImhOYSKG1nlkY
	 /PjOvG6QEJlDhr2l2RqfRMt7QDrdG5u94pSX6SmgzGdfW0hoBQnZQPt/LxjJh829bhs3g
	 hAxLoGoSrU74FOLScqmxeWwpLWJ2j3mSfHmrgoPa/EUP60XUswjzd4wr8GfSgFBYo6HVf
	 JA7mnx4HiAyqBtRR/Ocu4eypTIMpMVla7wQmF+TzFReMEHs4B3myeZM49cxwnw5UYTbF1
	 7EHAfzJWjrY/WArCwn9V9QVykuWjKKFSjWKRqy5Qs08YOhk0HiNXvcwBSSmthbWq8Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NIXVhnzH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ST010TGo;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA269606A33E
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 09:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA269606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NIXVhnzH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ST010TGo
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7j0MY131131
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 09:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=; b=NIXVhnzHgu082yqW
	abalWNzDOxFZhGuNyI7ByVWj6XtldAX6FNnRjk1R3+UFYJawEMNoJZxSHvaHd1aa
	y/lylYTrMZMQPJjTH1xQ+WuXNYh//2rPDLR8TVy7nTNgJKN8EYGHFJGqkbjlrfk2
	HmbGJ+iFyZOW7sIfJzapKHmwx2uBeRjpcei/L75cvpnGBtL5uyde+1cjyB3jPOdu
	eUKoWKk2JIwfQBAocqIGMVU9nxYYTmjxMaD6TznCOscivByzNo+H4jWYMNLqqPN7
	xOuOVl859J0HizB7ni5LBcLUFJU99ngJ6vbqAZbaG8iD6rDY7wb+XX5lPB06zm2C
	iAOWXg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne0e2c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 09:36:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-92135a58c91so42604216d6.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 01:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795685787; x=1796290587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=;
        b=ST010TGo+ikyU8MVhQ+E8UTzGE/wik/S2XrcLddBG8RjEstLlS2CZyHIZGj2yibcM2
         ALscMSpxy4X67sPA8ye+mzGp4uezDvhDuaFrGW0QwwIEIHd+sBRgSExorA9Uf39do83q
         yqipOSHlVjcnhiZHbZ0Qk4jCsT0Rn+VPaZHK7cECmPWiGT2/+iij1RrCCDf1Atb8Ycxw
         CE0M0zHHfJp/ZOJzR/pAqssIoZH0/aOzri5Y5/hCswZy5k/Yuize3H5h1864GOBkkLsE
         1HsZHPIqtBqKpZMUpym1NtHp+XZw4rJOtAgS27rCm3lHv5+I4uB50yJaJnypRuavwEAc
         IdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685787; x=1796290587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=;
        b=CCbPLEkCeLjTILEsbsFhEt04SvxxV0JLE+O3kyyxIG67TCwqFhmpVLuK8LLgP6Kp3z
         NQNXlOUrlDcmY+mpIimvSIh8K/7oA7QgRecqldknqypAK8zWRRB+E52Q31WuObULh6kU
         UfVTqaKfCM7BqOxclFjTB9KxO33ZxKgXL1PwMacIT10gdq8FigqskNxe86/XmtvsUjY5
         S7IcSsGMyHJpoPAiHTnAljRt+O0U6F/mueXhGDsWeeGLIEMYyCbPzyg9DyFTyVAebPsP
         tsduwidlKAuYMT7Q6FhrYKQb3Hmr0RAsiPCGYzRnMFxxJqrmUT4NjKafW697B7vO9WP4
         ZNFA==
X-Gm-Message-State: APuU4Z+qfytXvg7d90P+qwFOX4y1//W1BC33Ng+N+HsXDYDJDXE071pU
	0x73cnWzilMFZdTTEJZ04G77PthWqdrPjIXd9kRgAFq2dF2D1ChfEidd/6DdHKc66AJcvSbZR74
	5IDqz1mcSMD39Gq5i0bWyq6FqqavjlK9tk74sBVSBsk48x3L/iDIFh4ZRZYVEiKD+
X-Gm-Gg: AZFdTZcRfUOBG5YMxkfC/sA82tIyJxLidspKjjKf/xyLKtwhCoMY2nDLcFQcXCJKOwN
	uxl3FXisp/ak5aYICFXEok+a9SAfX7foyOLeY7U0IKcSoJVGQLrr5LOIIye4QjNjCOEMGt/YITw
	TDvr1Z16AjVkEOfUR6/fKmzu0NRcHNc4h+EybhaQFaeHBI78/+ExiXzJXcMTjDPLAC6OhhYfA3d
	KDqxb2Ig2E0KRt+pN7wLHzVniBu7pCr+iZ0Tpx+1jPnPxRSVmn0xZT/dxLd7MFsvmQVb21xD9pY
	/xH5lsIYlUjYu0GEntOzShSpe1m0iS1D+J8ohqx0GfABQQmVFy3+J94dqKpHYFXkemPCEhxGZgX
	+CW9NpvSQ1ymCOP5WV3vCHK+sPrTzPpnlBY2hu2SjdNlu3scDhF8xxpmOkJVGfI7wQBPryxqElv
	k+Gg==
X-Received: by 2002:a05:620a:4446:b0:949:6574:f367 with SMTP id af79cd13be357-949bac8c5a9mr3645416485a.80.1795685786746;
        Thu, 26 Nov 2026 01:36:26 -0800 (PST)
X-Received: by 2002:a05:620a:4446:b0:949:6574:f367 with SMTP id af79cd13be357-949bac8c5a9mr3645411985a.80.1795685786268;
        Thu, 26 Nov 2026 01:36:26 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8960068fsm227079335e9.4.2026.11.26.01.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:36:25 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:36:18 +0100
Subject: [PATCH v4 01/10] lib: string_helpers: export and rename struct
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
Message-Id: <20261126-fwnode-for-each-prop-v4-1-d4b370ecfd52@oss.qualcomm.com>
References: <20261126-fwnode-for-each-prop-v4-0-d4b370ecfd52@oss.qualcomm.com>
In-Reply-To: <20261126-fwnode-for-each-prop-v4-0-d4b370ecfd52@oss.qualcomm.com>
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
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrB/2Tb3bU70k5uNCHd9DHKLI7AbP4/lR/4ThiP
 pB9xbKGQFmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawf9kwAKCRAFnS7L/zaE
 w0vSEACwAuSF5pl297MCgnmYK8Yx/HwO0ljwt+t8ccc8bpUGvx2jbcf2rDjTxnwzOuGQX68E9qn
 AHKXALKHUnUZS/uTHsbtEhU9F4S4EW14tOCqA87Giz5SHfWhgTfgKgwZoViFwveppCrg8NZmrLY
 X/WsJ04SptxP1NSU2RJee1r9IORHFOzFZMJLDbselGbIQp/qk5QQqmfzeo6+Epv3jRtF1c6dyYp
 sb0mR9B5mFraz3sfOPjX1fzbtwfVXoV4+AEOZY1pJglVaDPxvtLVhCl/rhloqFmCo7z6wp2cCSA
 OmlIfaokYSWE33yxltAu10AB8MZDBB9xm180nqQ+jQbeWSuuiay3N2RCjjsANEmiGBXqiWbSPk6
 Z+wKVa7f5yXFf65X0gO9RJ5bruxLNC7hhoSRxKImvqL2d+GvB8YukI90AadieAdyl35efNJtkOE
 RzLBI/RjMhlmOXY0iATAPVuOVb+kqAPJEVDhn41vM5hGekJ8Eak6iKn/PY0DEPbEt3M+Sz65fdJ
 U52WP61v0Uju2OXgKK97CxaYlpQTqws7Ija56y57kW3rzcUith+JsHzNgFqx5UUc6nobuKdur1G
 2IdeHPUaNO+jU8QPeRKkaQjxMYJeM3JJzyXoZLaTkhl4F/QDiU9WgZqOovcvQVmvEu+fHY/Ne0x
 GakZ0caFYJxEevw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b07fd9b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=NBg0Ud2t-6tr7aH_vnkA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfXzhr0QfkEhVKB
 NXrycOXRVRGjaEPdhTBH9g1LCEDZIA/nCQ8GJTnl+tCKOQg+D4QYHy0vy0WY/tetzdoJ1qi5glu
 3qDtCFvglOSTerGoV84WojPGGnB97ULh5CbDTDgC1ZfpU5JOl48YzuegFqGdablX6FDe7EwyDBK
 n94VwLn9quopAtGoaJB+FjlUe5OpVWo/adJ7/z2J2Rz9VPe0A8x+/EudEoY+JYhGQTbzGApD+Z+
 y3/v5u0/ELwC7ECT4SgkWE231IZ1gd3WapkuA5Mg82JUQYm3yhp5/SjGPsskehi55yNbipFNPtY
 NO+eDZVn1X7kZLyVw5zxOfyf2eLfpWyRTeWrjPUnZzNHPUoR9koJfICCjgdKUcntWz9hHfuORZU
 UiFOOK6kwCyfhSkl9fcBn/kdHKJvaHT78QJnRvkFfhHmK6pGY2C8H8m1/QrGFepUwlea2L4HedF
 VdnRHqnVqOGgwYVCIzQ==
X-Proofpoint-GUID: nJb998_WuY1DBQTe2JDR21MW3IUaQzO7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfXzA/mp1DeRLef
 HqTjASmepGVQbVBb5b6yTkantVCiniufZwoXWukbiFlsz0VoCikNqpsNAPdbx/Zs+QCW/imfkPO
 GQ70AwU0WPa2vpUNO/MrQEoiHxIsLG0=
X-Proofpoint-ORIG-GUID: nJb998_WuY1DBQTe2JDR21MW3IUaQzO7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260037

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

