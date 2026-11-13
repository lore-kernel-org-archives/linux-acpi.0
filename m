Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584834;
	b=EY9N0elkusP7bC6NC9qPvI/asmjNzYOtQkILkxEwaERlnd3oPZoMBmas5ah3ev/anBGr
	 vwtkhc49nxDLlr8IYd3LRTxLjBrCs8aW0SuUIC3Q3XwmP1mnygz4B1QLj4yVCwDakEhxo
	 M7jxi5HgXbi5USJz5R1fItXwus8Hkcr+hdALnGIlhSIIAc35t9cRnegEjmHJw+MWh/Jd7
	 WF661eKQrNLR/kw48x6YE2mPDvJa2qiQy5l9CamT09iggP8v+RY+rMQryf/zt8ddUGV8h
	 klqmNiVgB6ilape9iUJd4sCmoAlR/h51HYGDjTOQifoQG8kw2URUUe1iYcNtratiGGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584834;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Wed/p4dMAXGXPlOgd+Od6fs1ryzDmeVuvcuAAb2oZD8=;
	b=iaPNuB8ibMoqmJJrDKFHc43eHnMlPycd32qHb3zqTTb+KsCh9vwi5oWVye60paF/i5/v
	 mLNgaVJCc0acZ1ewte4ClIu40hBqZ+m+QVeZBt7Q2Y5cohBEGh9XmSlUlIJLdL/TOYzjV
	 SDtAr/Ie4BTcGTGdDWqfvumcPhTHl4zZHQU4BQG0xeZdCtPoToHDCNP+i9CWeptO7D7vu
	 V45KyI+MLpPMaQZ0EJdG7Kzk+R3PL4BEm5RmAV127Mj+iL0jetDD0hG9bxYWH44NBtKvc
	 64sYhealL/wYqwACqJwlH9s70dWisOzu9zsDZnneah7LiMr7d0WOvP8SoGkLhE2HKWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n4egnpxz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IStitQ2T;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1D1606A89F
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C1D1606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n4egnpxz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IStitQ2T
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFj6rj780569
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wed/p4dMAXGXPlOgd+Od6fs1ryzDmeVuvcuAAb2oZD8=; b=n4egnpxzMUjory/A
	EgpxLjmcnRjo/g0HqrZ3k1+S5ZhHMOrlwl1c6HX4lCY/+KurbdpSkhK0VSO7c82O
	le9ef+plrlRoqB8I719JVmeRxofV1IOQSyTsDzV2YBcwuYkwdpYfMMr4mDCjAj7M
	lvRG/lHlfk6udEk0GcftmLxA7lkn0T4nMDk0tkU4LsuNFC5nOk4+Ml60bpjAKyFL
	ZJGeQieIm4ne4VwBjti0xnBkT7HgO++agHVH1l8x0v4y/6cVpH54nME+W/hJV7/K
	MLc+EcMoN0Kz4umnQV2cokbUc2TUCyEOdSX1J8eUU25ZY1jsIhnPQWqO/pyGX7+X
	R+XxAw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwv37j671-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:13 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9806756ea40so1051233241.1
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 07:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794584831; x=1795189631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wed/p4dMAXGXPlOgd+Od6fs1ryzDmeVuvcuAAb2oZD8=;
        b=IStitQ2TlnbGRbMsuaUy0bSmAbsl3uGIZMXp9N8mU3PcUWmHAUZHQ+SCapFjWmzAB7
         NO3MZLctan6xAyxOT5+R+EmSDDMqcH17rNDYXsJm+/abgBvzWUD5cHWjDnhJa4eeF6as
         PxuxehHp0pC4zMPifbyfg7zPmLGsU/hC+ZzLkMybhZcrRJCvsHU6PEHg52esZHJc0eu3
         fob9pzMwd06uJUmaWJzQ4+Pma2w+oRIM7f0nX5cjPIYgzNjRDGrWjhAc+Ac+GHdKNEqv
         uETW/Su5gZYjO2nNOchJrAYDDr0cjkiVq+AANP3wkxVFL/ULHxS61HVz6jECbvnn7aPR
         AnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584831; x=1795189631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wed/p4dMAXGXPlOgd+Od6fs1ryzDmeVuvcuAAb2oZD8=;
        b=tmppYubYJ7FZ3ewnIHryP5OiWO0BslXL9pEsA8lod5XE+XF2v7YDQpNboukdfyKgbr
         5nH6M8IUhoM2f88cHRwgoK+EGzsqIoOq45Mrv3h9z+ekOC7f+ZUkq086g7sRIChLKelh
         FonaRL12f2ybw5JWTZd81h520lvyEGmjwd11YfvM5QSAqbrpILswQ/rMkF/y7wWM6/jK
         z3SQB7IChsYwzaP+0UsFHtp6HWxMP+Mck46wjuu+T7WpzIfK50WKjYh091L+4rNfybvc
         G6E5Xug1lGqwFqGA7E16PuJEuuIaDo68+HZd8hlFJTCxNgpW/xLfgd3t7vkdQoembitL
         Q/fA==
X-Gm-Message-State: APuU4Z8kITws8Vem7407+FJM3ALNcynEmhCUfZQtoDW3XcSBbaXrSsDj
	RHeBl9gym09W7slP5vNMgAjcqFN9EWZ8yCps+6EzXjpBRAdQ9v+8soOLC8HA1RhRrrIv48cBWQP
	Nfn9LWK74LWds2hk6u9VJKhKM+EWJ6DDiNlndu+uiKeFhPWMvXNLqJtTLGKne7c5I
X-Gm-Gg: AYBFou2dnQugQCLGl36fP4n/12zbEyM65vmu5DllfdTMCN1UWc6JV563uhjQusclj8+
	IBDaKCNfVCHrg/ZG0UTpdfSS+QjX1OSKjPjsr7hh1RnvbSR5xEHXGoJnEY6ZEQmQGxhjlo85xra
	yq+QeqqHJyLuqNH6GrAjTiNEq6JluJf7gMo/NVfa5tlxw1sNjBSL6On1PaIcuAmxVjs2f+r/LMW
	lGtfaO+2pKayhFEkoUT3uhnaoneHnq0e0h32pFvUvN1YV1qMkWquZYIjDbzGp4Cvvjx0JtDUFRh
	VVK9UjPv3mkTzXl6mFQczTK/dt0ZBY+Tl2ShClvMO7JmD6MBUvjvFHHU4uqr+YpqHj+MU27T8gy
	OfjndSD9/RTNsR6wnfxxlWuRmcntURejLFUFPMVBhwcpoC03+qTGhQcDin81c56LYL8Gi4XV5Ia
	CTsA==
X-Received: by 2002:a05:6102:c94:b0:7d2:cbb5:71fe with SMTP id ada2fe7eead31-7d64d8bc684mr1050068137.29.1794584831331;
        Fri, 13 Nov 2026 07:47:11 -0800 (PST)
X-Received: by 2002:a05:6102:c94:b0:7d2:cbb5:71fe with SMTP id ada2fe7eead31-7d64d8bc684mr1050056137.29.1794584830870;
        Fri, 13 Nov 2026 07:47:10 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm5636519f8f.21.2026.11.13.07.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:47:10 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:47:02 +0100
Subject: [PATCH v2 02/10] lib: string_helpers: implement a CLASS() for
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
Message-Id: <20261113-fwnode-for-each-prop-v2-2-4edc23d5cf50@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=t30FPQpb4Tnh5cjxh+syE/bSfLdlIjxN8NWgVucIhbk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq9zD3zxDfNmTZ1oYpGu3oDNSKeYhLlJcTGJy3w
 i9b5ljY2i6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavcw9wAKCRAFnS7L/zaE
 wzyeD/9liUwDxOgRuCtILa7ZmLSZouUUEBMZOFZYeJfLbxqPj5BOO3LrGyZBB4eot1x51iaTeaL
 seAk8C1sdvB1kdjX6QVoJ0tGLj3Ws44IQ2wvoebYW9lUY6deKsomvMU6U17LDKO3L/XaMt3FDjV
 e6/HReOyU8IGPJLMZdufybX2gEVS+Xi/MPiHXevqmFcPKSwOoRFNfchRO8E4tIOUoEJb4mIRsQB
 0rsnTeD1IDzbiN+9o8sigSIZVxc7md3ox8EmjUHcINHaClSoizGKJ5TEKAEW42pw0xIgalLcI/B
 Ta9vfewgPI6i03x3Bf99tJUk+JJ/arujVKmdsdTxAe1iIPmdsl8VIfL2upL5GNduYQ5LxyQRP0R
 wLCEUqksltK4bnonaZfrLbsYBG/jMOWQVFyDN5lARrMSAUS8set0dHoSVQRsG0HnuQymrmjVteg
 zDr9BzfXp7bdlYHJRThjawEDJTtrr3tqtNaBw9IHETOLc55+W5EbKbDdkCm9uib+NWXiiKN04kZ
 11miOyx0tXie3POOHvpLjdqe3gvgfBX6bMxZM7yAGpfgwWV66EHdGZMIXgHyKMg+vVC4m9mKL8k
 RoYXaq/lvXSIRKxVnv8lbV8T4AeSEaWmxBot0jOg9YtsPA/2tV6pyP2JS/lri4VVTt05v3Cpxld
 d+rv30AlQOrl1xg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX35BVgbBjQVzX
 DV3DOaV/nJJEY6GhhqN2NUqSO9rCm5VK+EAQJeWwFQCB885W5sKgerJBcoTA2DEDdHsQ0qkRTk8
 wbHb6+SAzS7BOQgt2/0PLbdC4nmmRvc=
X-Proofpoint-ORIG-GUID: bgWddZwMaDA5SQlnUopEQJnE9tPlBpoZ
X-Proofpoint-GUID: bgWddZwMaDA5SQlnUopEQJnE9tPlBpoZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX+S/jFvaHvFQy
 Ofwrhl++A/SIjnDpx17a9Bh2qQWdRwTMEKJV/FSVOAVZTBAG6Ee5z5alL/rVYpyquRKAOPTW+/W
 Qz1wKf5RwsdDX2BvWJkOZOw90dSk6EU2HrRyE1Kq9ZUq57aHlXnip4+BXOyUnDA87v3s3nW7C51
 PJN7RNF5gsTo+0haWcPZ8dRUfLNuZPmRJD1i9vX3EVkDMigRKbApgLy1GxZxyO63KCafN7hZb5Z
 9Hi6/jYvbbKuhZQM5qNGE89R4uCtPrWi2/V8rpHtDAzfJ3ek507pwYSFZAj8bujACanC2GCP5P5
 q5y6uXA+KmfTaiTOJHnqzmOeJegr32IIRQGBcR7ANMmph1u3++paEqCK5bl4M5gwecEY/jHIPQS
 oqq3ymNyRm1XSSQ/fwu08QCjPe+62ZrjHGYwXDkAR0cjUTfMSF3cWzwHheRdjwzzwygeNVeGdV5
 k1w3x4vAAdpRqLwtb/g==
X-Authority-Analysis: v=2.4 cv=ZeeIpcVA c=1 sm=1 tr=0 ts=6af73101 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=lR0QwHyGZrhmQDu0ocIA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130062

Provide a CLASS() for managed arrays of strings. It can be used for
automated release of temporary string arrays when they go out of scope.

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

