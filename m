Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11632438494
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342485; cv=none; b=W8gp3pDao8b7Vqwren0ZUKb8ght3VE1oxC3lkI1YEwqGhfoOIdRBASI24AOK3NStFeYeov3YxlOn65RGovpe56MPrEcPLMY/o4WKMbf7Kg8AWfzV5AZ5Z7N2YIz8RdMTp/c2Z0Qsv4JaH7ceNqxG+U3SDhqVUiq2+t0OtKbwN/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342485; c=relaxed/simple;
	bh=wgU5h29ChZnINHlE7+cpZ7/9ziX5loPoQOCDp71wUPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7e3vqN3gBcKWnRYYEBic64bBBQV9DAKij7C0Ad8hTizvLF5ynTnxovoFg9G3xXPsRLaOr8K64Gxwll7FQQNHKNCBUbKtlDUxuszUebOMzUjOj0qLasdShiiNcYD14m4FqU7TqMK9JfLkj9FZoGnqs5411wc9IVTTQHBZrOKQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=njSdUWnw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fYGPShAV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="njSdUWnw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fYGPShAV"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxUxJ317157
	for <linux-acpi@vger.kernel.org>; Mon, 6 Jul 2026 12:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	imuof45N7Xdladp2eaUFL5GJzPQRNKl57RWZRExjNv0=; b=njSdUWnwl3xuSbj5
	TlAvRuKwzHIC+phu+eifbRMk9cS7+qenMJ5P0s6paHP1ExwiBWnHF2oEDUqxatME
	llJ2EEvmKmWsVGHvduRmHzvYhRpLmyFW6Gdw/s+G1IZ7qBFumzsPMaxeLp5bu2nI
	6siQ/upDkAB6yb4WjtVNPqd1ZpFOGpXUgnB/K7+3SD68QPiTT2KfyqWumD+l+u2J
	vp1SPllXZedjBHwXYNWy5blLPAm02q8wFZ5kbP3PMBTOgUKi8WAB2BaK8aCay0Ic
	BSG4WTZnFf7l3acS6VgmCtgFJCCCW5wxsL67wDCp8cp6nPDIbT0hMby+UmyYMqRA
	dPfFPw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7hadc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2026 12:54:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91ed0e140c5so540428785a.0
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2026 05:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783342482; x=1783947282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imuof45N7Xdladp2eaUFL5GJzPQRNKl57RWZRExjNv0=;
        b=fYGPShAVeGsaNNyGhYbowedrBiKcZJYvBjiPAyXdCkHvWAP44Z32vmPtRkMuc2z8HN
         G21S08jACxx+aXhSwCNkKNIX32d5xdTxFICHN6IyO0HyCxA0KB2jbTGJi8QtPZxQxRMf
         1azoTpCNpTH+d66ijzSUjXNoMKjRPh8X+gaYUxcUzbbQPhSMqwSSXHXn9odkkT1WQlmf
         r7PkFDze3tu3LyhlgJ39oOM47hclHb9PDCVEUZaTIF23ZMkVCtEhPhoIBbGxGEXmIKtX
         +jz2KSawLHJGkppkko8iJsSV+NJKwfvutK4Bpqa6ntI2Xo4HBa9f/4fmswf3y/mJcj0g
         4ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783342482; x=1783947282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=imuof45N7Xdladp2eaUFL5GJzPQRNKl57RWZRExjNv0=;
        b=r+ws+jv6AMRFiiyMFbPrAb3vwQWcSxZQ+hqk2+mgztfBdOzss4E550gxhJWN1JiZ6p
         6S+E2tXVMAMquaSQiIO/68v8h2YhTaYKPCxohtViIKBdkkNMnx4GXNxLNQsqqB8263lC
         WMtKKhZW2AnI4rNtE9nAL69y3SE7eidD5XrTNiXfxJ3LOQfOd/phOSHofD9WkTX5LU04
         8CzicezOOEDbWrc170B1pKWTZ0fq2QftxTAtfz30Qb6Q9RvqEY4JyIts+SiYEAwCjDdF
         yOI5Y7tI91A0YzlBxHfIAU/+aeIPxhLhHY3UMdVKcMcb4VfRMoWYP0xWopuFE+ZJg4ep
         +ONQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0Zp6gPfSVUn2ffZm3L2knNHKnRGY35YdYBzf6tld1rm3d50iJQn8LZ8Sm4+wRPZ8OckTHaMsjCxJ3@vger.kernel.org
X-Gm-Message-State: AOJu0YyGaRA30KTV5IKMI0Rc/1X43+D8zXTvfo4vbXTqW9w5C3Hv7nMt
	7n2N8ngiOnByoM61/JtqcMQWHJHxF8QEaYUMdKG6w0osn62LrZOWaHDzlsAjmomtvaE2GykTJ1o
	ERut/5kdLeb+eMB4KOAPlCGl+DfwbysyHdbE4rn5Da5YSZc6nXum9bS3y/LtqZs88
X-Gm-Gg: AfdE7ck3LW5mWaV7mZoZxGPxxyxP2Cj4BUALsx70vBv9mAz/tbxZ9VRKd8a1fIRnuZ7
	QpVP0wVohRZnh5i0M6MaXLGXA+JS8chB8kduseIXPk0XHtRdwhyjAhfA5wFtcmOw0JaVsG72ny5
	EJymTATnzzMS68FPp582tvI2Of8T7n1F2JI6czovc5Y5lVOZFVDo9vTTijUfDFhx5tY3pw+TQYR
	L2RndsAHifFR1bKm0vXF0mzKozwd2LUvC5Gv6EC8npdObxTL3S1M86Y0itdvqANxB338cq6gcIP
	OzSAvwEBogEj2xGBJ0vmomtZZElgunl04VJF3OYtokDY2BqL1eb5gIwDbAsrf5w6rXTE/8YyFhI
	UiQPYG0zRcuu4Zr4MFjOEfOJZxiiJvdWCHtL6frpu
X-Received: by 2002:a05:620a:198b:b0:92e:5ffe:7833 with SMTP id af79cd13be357-92ebb5a2bcamr54652085a.61.1783342482399;
        Mon, 06 Jul 2026 05:54:42 -0700 (PDT)
X-Received: by 2002:a05:620a:198b:b0:92e:5ffe:7833 with SMTP id af79cd13be357-92ebb5a2bcamr54648185a.61.1783342482039;
        Mon, 06 Jul 2026 05:54:42 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm26856931f8f.7.2026.07.06.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:54:41 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:54:11 +0200
Subject: [PATCH v2 4/5] MAINTAINERS: add myself as reviewer of software
 node support
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-swnode-fw-devlink-v2-4-f39b09d50112@oss.qualcomm.com>
References: <20260706-swnode-fw-devlink-v2-0-f39b09d50112@oss.qualcomm.com>
In-Reply-To: <20260706-swnode-fw-devlink-v2-0-f39b09d50112@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=897;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=wgU5h29ChZnINHlE7+cpZ7/9ziX5loPoQOCDp71wUPw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6WGF3whIW+RLqDAnJl2komv2tggoOcvqqnfv
 ocHtTbK2ZeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakulhgAKCRAFnS7L/zaE
 wwaIEACE9xjgYSFMqIxeccykET/8UUPaY6JmKvllSX4L/pZkWNnEIoZlQYLc4yR+N/l8RSK/H4A
 CeEsKYUFGtKROlOlbDIYNRUI+z/sod7oTEntYOQ9n5+KVIanY7BC1VhFbF9VFyIycnu6DyB+IP5
 C/s60NpJgqoNBj9N1ZYBps3/n27llPa+Q+v3iNGh6/EgEEW0tCOuOOuHapXNuAN+7O/3pH/2kc5
 UyB60g+58cc1g1T9RZg+zhQei7eyYpjWj2QUc7/nCCgSf1gnr/eV6PyvmnMPW7OBX51vPhwJl2b
 1C/voXGoOpuDkFINlJ8Z2QI7NTF2fgHfOUei/IGlzNofuaEZ3qCqmUcPFvzy1xpHCOCkiSw+QCT
 1yYZ2fnx3Yc6hyFals3+5yytxFajc2rZfz5yg4A7TMB/+XS6us7riipgSe6e2Q2izjOc7pqV/Qw
 cB3JWo4TRsKvxyxM/+Za2P799buSsRIaljMqnqXhav3/vlZwFkyVzqrq5xZ2Tvzl2gcbhfB5y6D
 u/UjA2HyqLvtPX2GuKFyupLO1ME2KOxhHybEcLSkDhhQO8qP9lwsyEG0dNSrolNwwyxfVRHwLo/
 JRubEwo2kDbojKzthKid8G9zvU9sFnV0MwLpDSZpvSxz6MbTj/v2BQg14gi9/vAP3z3sQM7DEaL
 MiNUR9F+C9IQykg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzMCBTYWx0ZWRfX+V44FiHfUt0j
 jz1cbDn71LmbhkBjJeOAtRL0Hh7EYr4vLo4cnGMsEgpiC4nYl4w3XSyCAJfYg1SwmEUm/5zsc7o
 K1Wx82xMXYtAcXzDrv6lpKrmtsXtBYrufUJcC9BBxljgnyxcyxTCpAewO6KaKhUBTJnJbLALuDC
 R4kyFzoclyDzOFfcHRv7Az0Fiz0qL/EP34O37WJ8zbH1aUh0P9nQ9DueZVi58D4wFF7Ds5mbPSO
 QN0ObixJXjY/9a7YXx/YreGBgHqwnyPzjRJpfOu4CeGKMEd0/123x+FIP3emno+ODoRn/ikLQ79
 ZAA/c+I6KehLZ9ADRdwYLLRv8xHgVnhEiQzwbLcd3fCRXba9zucA62HM92QsDcfYo8ha/QuUebm
 zPxunL20avkxyz7dpURy6NPcvb7WuhXlCnJKEmvSKrmxwssZKLOd/n3p9i8GnW4EZ83aAf9cwpX
 dhgtmUpLqLbJis8O1fw==
X-Proofpoint-ORIG-GUID: BQDU238yOb5v4rTocxBBvpBSlLHcYcEb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzMCBTYWx0ZWRfX2s2LsUeYoDyD
 ln6Yc6Erf1W2/2pCcP1tYpHeII7fTKW+pVV1DORqPu7/YQNL0uzEJtvy7X0LjyqTHQPwpR4XQ3Q
 ig9sgPEQcLWWaz27H577yaOMp7uNTR4=
X-Proofpoint-GUID: BQDU238yOb5v4rTocxBBvpBSlLHcYcEb
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4ba593 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=0-iA9D7a5yEsystHw7UA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060130

I've been working extensively on software nodes lately and introduced
some changes. Add myself as reviewer so that I can help review any new
proposed changes.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7741614c941ceed9e46e9caea72bad77cfb7618..da886aa69f362f4cb9dc529a26f8dfc67649d7c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25101,6 +25101,7 @@ R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Daniel Scally <djrscally@gmail.com>
 R:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 R:	Sakari Ailus <sakari.ailus@linux.intel.com>
+R:	Bartosz Golaszewski <brgl@kernel.org>
 L:	linux-acpi@vger.kernel.org
 S:	Maintained
 F:	drivers/base/property.c

-- 
2.47.3

