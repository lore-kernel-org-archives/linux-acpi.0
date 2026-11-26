Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685791;
	b=VcrHI46HilECzGkScMYcfQj1QQGNW59Yd+AgngcOH4ki3/7O8DNd4VFglILUr/ptMj3v
	 ++m0Whx1EOlPkX0vzHcCnkOLV6QiX0Fs0QLmHBWEjtEynnFSV+Jzqf5wCp7ZcHtpUb6NK
	 Wtgr4NELis9Pn8/xox3p9jnIipIEzIiepFn3K+MOKUn9DvvtIxG+JsgNjJFjQjZXA84aK
	 1mYIoUKydLSzLlzzCqs2hcpkGBIAPDiq4PdPJN+tNWzSGUa7RGcsaZ713TDTImGhZOU3z
	 p4JTyk7xOZAjxCelL7lyZAePa1tEWibBRqNnhKCK/HeADm15iXZeiVLmxWelaE2hKXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685791;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mRIovGB/GYq3DzNOvm/z3TLZdByFS+QCwZOU22JFuqA=;
	b=vnLv3kXXLq88ckXn9fAxOTjB6NDFj1EG1AqTXVMJZsu6gS6sU4IQbjlQnNCJyzZHNFtU
	 dFm9AMODvpxWntaDN9sa4GjdhsF7iW0HRFc88aenCdpfI4KbPgm7z1sdZXQtof1kJNR8z
	 u5AfYuxlv/jNWCaAql6mpEUTxtnXpxuDg+z6mL9vA8EhuYYqbTcKEwvoASMCqkpClK6ic
	 6INLjhbbbVbtjg6tdY7V4kJropO+q1EhH1ZbmjhHwS5DNfk+R+WK6GLw1KEAotRYjqmBD
	 vABNuiXgrEuXnr1kKGtnJIciOz7zWYlJlsS7ps0W8N/FCr02/KthJJFt/RsTPlG3aLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HvTU+1Lr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VMZDCdq8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AC606A695
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 09:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A0AC606A695
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HvTU+1Lr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VMZDCdq8
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7Ar0t2885419
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 09:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mRIovGB/GYq3DzNOvm/z3TLZdByFS+QCwZOU22JFuqA=; b=HvTU+1Lr0+TayoIV
	jjYxb6eyo99o+UgT/AVaicpY6fcDbW1BMaAX0d223RgCG3hu7zG9AVl6pJuaUzfy
	Eks6iYYvykbAa2pKrAnT6sHg4oGwjRknvKzaDP8pNRX1tuNpAFRhcbcWwkBU6m5/
	wbncP+VOqEGGJcwgS7ZZFH6WAa401chJSCR/I4qf1TDjTT4xmNYPjFoVTAxnCyoX
	k3iAh1KQl0yjEWlKbBQpp75dMJQin2AIa3TVJv7H14t3+3icXGyUAEGtcSJm0pSX
	kQ0WWtPX+r+owfwkZwxH/uyHiZtARvdH8Trx+pPCSIzMCaa7KXk56rJEYFFgbXRl
	mixz2A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6f8rgsue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 09:36:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f2c0e6653so276532085a.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 01:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795685789; x=1796290589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mRIovGB/GYq3DzNOvm/z3TLZdByFS+QCwZOU22JFuqA=;
        b=VMZDCdq8Jhiau+uf9VcKBg0uuapDL6IcC5y2d0p2II1nT0Lg1xcZwHL+Oe7E9++3Rx
         A1chdFopN+I0gOs1gbN20WdsHbR8Eu1IMmyrrZeH/IU925FxO4dMIYI9Z0bbqw6mAcCM
         EavIEhbs0qF5KgR0DuBdWxa+RWyJ7AQBcEF7MBHsG/rT6BTVV1w8p2s2COzSrOAFRLnd
         +rVMEnbgEiSRPbEyGwlEa0oR92ExmtXk8fABR64ZS2lidV4h0aB9hfWdKokQIvfi7ON2
         qzr9o7AubfEg/ndAqMf6p2M0BDs+D1wGjSQIM/xkEfQl5z8k8m6Mhi2WD9ZUlTo54ykT
         lpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685789; x=1796290589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mRIovGB/GYq3DzNOvm/z3TLZdByFS+QCwZOU22JFuqA=;
        b=bivedMszIqgtL7wVH6esu0oVz3BkFaNS5oRbruY63oUneasAjJGrF+B6gGKVFJOFoQ
         nPJx0uJdeagEbG1yF83cjxSJNQXDE2HKT7g+0kRZJrbgYAUXgBOPrgbBl3BECjKPWEDx
         5BFVHlK0vHEmh0NK2FMI0KD6+ccZ+Pd+qYDv19p8sWIUg1PCJXNkheDu85W8YRKhPHN3
         sbBgETmECIJn8UotNz8fEIG2kkp0TZH6Noh9qvbFtpIECXjMGEXWAsU6TYzpJFaUYXnt
         7beqqJT5+G4eLx6UTHQvwa9lL05K6a2o3lB0qD5U2vZlAJkuPPD+WYpQ1k4feRtt6o9s
         yYZg==
X-Gm-Message-State: APuU4Z+C68Mnet1utxZBkX3Dk/cRdv+qUnbi3pTNMlcj10IiqRKu7q2q
	8boWw73ouDny9bA++6hmxvWE/wpvRPoLdq2qe2IepsKUpxcMfyOtlMDU31xKA6WylzAr0cI6Cvp
	GHVLxE5aeiaOsnt1P1JqoXx+jQ5S2tXL/1oQYDQeQYgZKqguCZSamUV7fAYLt7KU3
X-Gm-Gg: AZFdTZfhVAUO3tRG/w2+ulsIed8ayyE5GTKWpP3vShZKzWf4QeGcbvcOw38h6Sjz6In
	d6UfyKjcy5yoXjuExqgLXvJEiJlXQEjdnVOSROmNtu5x5hm3RdbVdjyYoNZWnhopWvW8U5uzUSz
	9ho5vnjR5ufMVuM9xU55MWB5GxWFWoTpfZ6JzH87/OxqD1mowhVjOVbUwH4tylxr1lWpcs0bcTg
	XPwcYo3GQU/TUMObX9364b1YVlwqecIsUNAfXPsbKitu0NkxjZAGLLZjo001GXvFon4e4z4keP2
	sbILuTIwaoyE2c1WdPsPhBXrehpmcYb/bSNFwiQJqA4MdtN156jJPcSW1OQM129fqZfHRsAeWdz
	o5CuHsm5Ad9G9XeA4NDUBqC4EHBl3gt3fei0A0nAaUaWi35lkNIYRGWS/9kI6nQS4VDiC5vkNDN
	chKw==
X-Received: by 2002:a05:620a:2a0a:b0:93f:43a4:a47e with SMTP id af79cd13be357-949bab1dadamr3832613485a.43.1795685788866;
        Thu, 26 Nov 2026 01:36:28 -0800 (PST)
X-Received: by 2002:a05:620a:2a0a:b0:93f:43a4:a47e with SMTP id af79cd13be357-949bab1dadamr3832608285a.43.1795685788429;
        Thu, 26 Nov 2026 01:36:28 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8960068fsm227079335e9.4.2026.11.26.01.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:36:27 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:36:19 +0100
Subject: [PATCH v4 02/10] lib: string_helpers: implement a CLASS() for
 string arrays
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
Message-Id: <20261126-fwnode-for-each-prop-v4-2-d4b370ecfd52@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=JgjwkDVUHWhy6uin4cUa0Wd2V5XuhJ8xnn7npsp7KAA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrB/2UmlNPXMYUFj1OkyjJlNtUg+TUKM1XF8Nu7
 d7XYDXF1R2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawf9lAAKCRAFnS7L/zaE
 w8xCD/9IYhGx3cvDc9WQWKHuSblgrzMbds4fs/OJHOvppEcKmijm7eXlATdeZIwTvT3isiBUj4X
 vMkHZeEcEb3x5E6sPII4oL2sLrwLi6Sc0G687C90sYbHjuaF/cvPNwQ34R53OhVsSusUhpn8UHL
 ba9XnX808PqRAwtsHkPJei/FdYKzTAjyLVJTlIjXVh8ePI8zN6IjdXJRCSsPodY5I64A/swlRIx
 fpIfZWyra+oHPh/oY6PilA0cVcLLOLrKe/pvRKp6RxQaCenoPI3s+HYRsODp8vMD+YFabDJRoBF
 Ttfb9xQb8DiNf6sW9Vs6Hz4vwtoINt/h2jzIRwaRntNqP9wbgGcgdDZCMqoSXfX8XPLJ0eY401A
 SlgEgNSWLenIYKcrGhH25okc+JMMYO3oJ55c6yKNT4XbAxUTpMzsB7obKMj/c3dWzHJnQ9QoJ7h
 pqZ2qtHyWZ92+t7QLHW8TqRS7pvmu7vuvBeAJOSI4K3CkAzlm5XUE6Y6NOs72ti+GUvdN9Kj0KD
 DMwOqA0PUUR/Rz379B1UlFOzYoGhxCGxC7Kkwy90FcAsR9whZuHVEf6/oVrPLf6K244LKS7AlzP
 AC6jyUhZAuwrmwu0In9diKO6B6mIe7ozf7LbBcG5/Cl8f9QkcSYK6xla6At0MSFKKhgCB7waqvE
 xLx5I9axDKDlkjw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfX1MhvrCtf0aDr
 1IDbYIapO1piilbwanrBWoEGSVhZBSSYqPLgmEUMnihj0jBNrpcuB7uP/C2OIwwL6x3E6Tfuvlw
 n78R1g5xpGC4Cnz6VZnCA7dC1kN17lofPcOcam3MKY8N9989k9mssCgwaimCH8k/0n+7kgdxQei
 vY1m9VsxxQoE/UI4WHy9DA35k/WvLO8RGXsdFc0yVGtW/2OU8Fv87Vdyo3nuVxyrzKUWOe6bskF
 lXe8HMgmutWBhlscqXLw3TircYuKU3MDiW2/72wmoRUl8way/QnqNdkOdipDCs/KhLtFvxauJ23
 34Y+a3QmgTWQdCOYaDXkxjbXIPqm8fwbO9ZmzDucvVv2MPRCD2zHYf9nP90Kwt4PBv9DryVf1CV
 4HoNXhSllAKjNA64fREeM8/LdT6j1EjZUBUqT4TqRgUWoUjmwbUEtcOw5KPQ5tFZ+l/2mdq8fIT
 /RQJNPkZ4hYIWqNtVEw==
X-Proofpoint-GUID: HB1IN5l1qNsvuqEuo64GooCGoreWf8Yc
X-Proofpoint-ORIG-GUID: HB1IN5l1qNsvuqEuo64GooCGoreWf8Yc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfX16eOwdSIEFMP
 0e0xw85+CpORfGxHOhY1DgZJc86pFb16mIKpmQWhMR1DMaJJH5vIdj/9tI+1sPVTBQ6W6+mHNCV
 7ekVdTKVeImHGGKomWi5B7YrbKH1Mgs=
X-Authority-Analysis: v=2.4 cv=FuOQbGrq c=1 sm=1 tr=0 ts=6b07fd9d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=lR0QwHyGZrhmQDu0ocIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260037

Provide a CLASS() for managed arrays of strings. It can be used for
automated release of temporary string arrays when they go out of scope.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/string_helpers.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index c9f08066439bdd33cc26e2054dbe1ba2e867aee7..4db73bc7d4623cf45954cc8794c5baff6fb23241 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -3,6 +3,7 @@
 #define _LINUX_STRING_HELPERS_H_
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/ctype.h>
 #include <linux/string_choices.h>
 #include <linux/string.h>
@@ -124,6 +125,12 @@ struct kstrarray {
 char **kasprintf_strarray(gfp_t gfp, const char *prefix, size_t n);
 void kfree_strarray(char **array, size_t n);
 
+DEFINE_CLASS(strarray,
+	     struct kstrarray,
+	     kfree_strarray(_T.array, _T.n),
+	     ((struct kstrarray){ .array = array, .n = size }),
+	     char **array, size_t size);
+
 char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n);
 
 #endif

-- 
2.47.3

