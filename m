Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792882589;
	b=nGKWm+j7EqYkHZUQ0X7dUHHywiPt59XmcxvBgm1lZOxFAhoWJhdEepvB3xRJLApKDMCK
	 gSlVyuAYgU3p0Yx3H+WKa0DRn/OHjh9lGQkr8iZILAVCZdzrOnuGGpqqJX1cf23Ak6rh/
	 Krd4gMwRXJdhpuKypjbe0zGjjfAsMt1w4A+vI56eTm7MVDKNmQvUwS9Fd3SL/uAPPuDpj
	 BTnDFwbErN/ck6X8HNVT/s4Uju9orGESnr7XEHsPWhx27tMuU1qU85JyLds+HQygr89rQ
	 vG4G/mO9ASmMiXFJY1G5idN3Al4Y4yB2v1SCmsEtt5ZY3SxDj510NGqlMKuZscAtVLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792882589;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=f1HiuzAgbnoiP6XLEgSVQ76HAxeufd2AMG70LmlGRec=;
	b=rnWs/LHTlkO9zbTid0Z5gtgbtxhvtglCBv0s4WQ1GvSu3uirOuBxoLadnY/sHF7cXdZJ
	 cK+u4JGw7+++r9JRkedLHrvH6I+gBgjFoPkJYx9kP5J1xEbqvov/3udOM3mbrEGKdKnH5
	 op/ZOmVDaMSJLQIyoOEUTgLiFQevesxSJnfsM6geHbpV70Lj8BlQFVj/G1KtbJC9BWvs1
	 hKD1H3Zj5p28wcpuFLjW336N1ni90GV0AO2z7ouhPvLXOYE7K462nd5K4uHSOpUN9ShzZ
	 CrN1y53jxqWgTkaB0bwBmLNZKy4T1Y3VoFPyy9aVsgRv4FlovHew8oBpWAsbD49FrmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PizwXrXp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FGtEvaxW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF74606A320
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 22:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EF74606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PizwXrXp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FGtEvaxW
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69OLbggE3249130
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 22:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=f1HiuzAgbno
	iP6XLEgSVQ76HAxeufd2AMG70LmlGRec=; b=PizwXrXp+SPjrmqdYg9i6ij5B1G
	TZmW+sBXMnfz2c9Y+aqxy87GCWrhPL0G7LlSKAYx13IGlAGMpRLJoPInG4OMH4hH
	eJIFRvx1Vgz3lmQix8QsLjm/kMdkOHTO9XIHp/q97OO+KxiUBOPzuhluNq/YHunh
	g2lGmA+HI9Yc1DrczktFzBFiZ2SJM6D3rfUmb45SfsCfZ/Vun8x+YOQg1GZcDo+g
	7noF6UixRadUdlv/nWdxoo3v60x9gwF9Swkt4D+uyWj3iE6buZ8jUdm34plvOiK9
	Rq0koMe/EHpLMEIHVYHwgbn453Yp1uiimiIWVIESeUol7c3WZ1O1bR3WVRg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xj1fn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 22:56:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f2c0e6653so83809085a.1
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 15:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792882586; x=1793487386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f1HiuzAgbnoiP6XLEgSVQ76HAxeufd2AMG70LmlGRec=;
        b=FGtEvaxW5KKcAB5khzlZF5TTY0puzq5/dNS4AYRkBQ2kV4v7U4wed65MbME9/sbbl8
         IZo+1wYfn6gyhugmRvqoe8m3h1pksqqzJDB+ChCgv3A+JZlpXKgo7TDnnGGI5rw3c9ts
         zLXOeid/TirWP88v12cr4ti8U358o57nw+taK7+T/SKFGfBDBRIFHgGh+k+GSxQpT4x3
         4G+fM84/ZGRHPnjpAql73fM29E+wQnBbnBXeZOZgsCya8haC2Iexx7IxXVZ7t/hk8L5q
         esQjhthhcCnzeFyAMx70Q1LY2+McRh4uUA7OxSMPNbYJ9cZFv7QW7lchIomUou10QowN
         vKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792882586; x=1793487386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f1HiuzAgbnoiP6XLEgSVQ76HAxeufd2AMG70LmlGRec=;
        b=OyG0sPFyXe8lhZ2qJsvyL2iw17nPa+nJ+yIUnGjnp7kDsO0dCgSkKBhpDA9aTNXFat
         1Z8/rKbODxXDfJpBTiR8pAs2XirxyiPwBqPHM2F6sm+66hg4x4CVACdOkEmcGT1WQz4V
         hyIjNTaeheABxN4/ltLv80B7+Xf/DI2kgBXWmU9SUNZ3ho4XeH3Hu8MiUAQdOxr+kocc
         iZCzmqDEMN7DXhmjS638XYG5dyroOm+zd7NmCPf4cRTRPFVwPiYgMQrcMUyWwpMu7//L
         W+lWUjvaxZ26xDJEuhjesuQqBvrrb4cwm8AZaI5eA7n1YNlnxR2lIC6oiTb1ZqKTzEih
         mG9A==
X-Forwarded-Encrypted: i=1; AKwUvBxUJQu18VZTXpnRVdE/rmrR34iy6qrJyQjjt714TTADleQCZFLMjcEeQO9oif+SaYujj5p+o/sAlpQ8@vger.kernel.org
X-Gm-Message-State: AFq9FYIErE33Krm3ELO3Nfca3QAPZQnP1NQaESqMqaGFecZawfbRmww5
	QESYmj+DJxVX+4ZisSe1HsoZZ+GVQbN5WagPAJtDJnH+A/QeCXJkSR5QyX7b0xzZkyqpKn67sss
	vDpCUrb9xfY28lkPcFZVzksGOAN6NMZawnbscatwRHbDaoCnBsgHjnz57H2y2xrUw
X-Gm-Gg: AYBFou1z5BksMJpYyFapqKC/q2r5Xdl+S5vJMulYJaJoIyQsCtjTwjtGQxKnXXoQT1o
	Cm7d/1wfp9PBgAQUT49l3jqeWiIebwVJd2egsPTxCHocsCF5TiSfdDNk48eKMhAN4kN/W8Eq8MH
	Q3TfZ1qOh5YEZor8IXcEkdjz1qAXRB3TZLfpCzzfWNEkgNiFJwSOojqu73d7UzRN/TGYD3hRVwY
	+0EpE9qWgfVdJFfrckuw6GZ1KorIbjPrut/b+SezoEfGcvS120+SKEXJc8vdg4/dtzStlCjLuWw
	LcUK7VQo/ph8C2n2KbiUxrElI+uEBRNfLp1stX4/c3QX4piRXj7HqwUX509xMXcnyCuQ6y3jisi
	Xbv33/vXjaP7mQi+ZIri6EK4MxR0=
X-Received: by 2002:a05:620a:4042:b0:93e:6325:ae6d with SMTP id af79cd13be357-940ef8db90amr453550185a.40.1792882586438;
        Sat, 24 Oct 2026 15:56:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4042:b0:93e:6325:ae6d with SMTP id af79cd13be357-940ef8db90amr453548885a.40.1792882586057;
        Sat, 24 Oct 2026 15:56:26 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359ff2189sm98564145e9.1.2026.10.24.15.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:56:25 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Jai Luthra <jai.luthra@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Wu <jackbb_wu@compal.com>,
        "Mario Limonciello (AMD)" <superm1@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 2/4] platform profile: Complete class notifications and registration cleanup
Date: Sun, 25 Oct 2026 00:34:27 +0200
Message-ID: <20261024223501.1420953-3-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fKuX3YplQnWW7iDrxloRrXvv_Fw210Gp
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6add379b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=sNWLPp6fUqVo4Qx2xT0A:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA5MSBTYWx0ZWRfX4miykjjVw0Q1
 JBptg4roiyIx5d5OBtI2Kg4G3N+MHoeEiQPIwV2hybLqqdzok99+59VDSIfkcFCmYHrIBPe/A9v
 3IvTd+aABPb8R98shghC796NwrT7g2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA5MSBTYWx0ZWRfX2Y3R0DHyFJde
 JNxOGi1yhtUgbabvh9envymnluZ/2u6yz+iXSABvEKhn8YBGxRVcjRhJCgs0Jy8vhhGRaHVi/7S
 slkLL1tIoF1e+9ZvwJ7UvVoDsQNCFzLPLSduScHyY3ysAxMz0MqcZBiJMZ/11+SYlPYqhEABWIT
 cugMz72xGInIcgb+le+vzVqQyZniUCh23V7EkxIkdhl2xHbbX/6FH6v9gx7S9slmGZgfNe8C7cl
 Lomr6FYpTcll1eOumTaU3jIL56ApClmLZFKzTLNZ3UbCeZyB68QDBoDss9i+y7VOzSWp9pnbhQ+
 efqtKKPRb3jQGGjSVXcyKDNE57tGLDhR2+lus/r20NsB3CQRTZoyRnKwyj3ACfOElZxyxKQaq+R
 ModUuKzup78pr0VPuA+SyYm/Qop7xpJQ4UkVcWBFQUrnlsO6y3DRJpTCMUBpUOZTvI2wyrD7lMN
 jMyj4oVFAaBNkafJKcg==
X-Proofpoint-ORIG-GUID: fKuX3YplQnWW7iDrxloRrXvv_Fw210Gp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240091

The class profile attribute documents POLLPRI notifications for changes
made through userspace writes as well as changes reported by providers.
However, a direct write currently notifies only the legacy ACPI aggregate
attribute, leaving listeners on the provider's own profile attribute
unaware of the change.

Notify the class device after a successful direct write, using the same
helper as aggregate writes and provider-originated notifications. This
also makes notifications available when ACPI is absent or disabled.

Restore aggregate attribute visibility after unlinking a handler whose
registration failed during a sysfs group update. Keep aggregation exposed
only through the existing ACPI interface; the existing class devices
provide firmware-independent userspace access.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/platform/profile/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/profile/core.c b/drivers/platform/profile/core.c
index 57c3dad2732b..a850942131cd 100644
--- a/drivers/platform/profile/core.c
+++ b/drivers/platform/profile/core.c
@@ -256,6 +256,7 @@ static ssize_t profile_store(struct device *dev,
 		ret = _store_class_profile(dev, &index);
 		if (ret)
 			return ret;
+		_notify_class_profile(dev, NULL);
 	}
 
 	profile_notify();
@@ -330,7 +331,7 @@ static int _remove_hidden_choices(struct device *dev, void *arg)
 }
 
 /**
- * platform_profile_choices_show - Show the available profile choices for legacy sysfs interface
+ * platform_profile_choices_show - Show the aggregate profile choices
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
@@ -366,7 +367,7 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
 }
 
 /**
- * _aggregate_profiles - Aggregate the profiles for legacy sysfs interface
+ * _aggregate_profiles - Aggregate the profiles across providers
  * @dev: The device
  * @data: The profile to return
  *
@@ -391,7 +392,7 @@ static int _aggregate_profiles(struct device *dev, void *data)
 }
 
 /**
- * _store_and_notify - Store and notify a class from legacy sysfs interface
+ * _store_and_notify - Store and notify a provider from an aggregate write
  * @dev: The device
  * @data: The profile to return
  *
@@ -409,7 +410,7 @@ static int _store_and_notify(struct device *dev, void *data)
 }
 
 /**
- * platform_profile_show - Show the current profile for legacy sysfs interface
+ * platform_profile_show - Show the current aggregate profile
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
@@ -437,7 +438,7 @@ static ssize_t platform_profile_show(struct kobject *kobj,
 }
 
 /**
- * platform_profile_store - Set the profile for legacy sysfs interface
+ * platform_profile_store - Set the profile across all providers
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to read from
@@ -508,7 +509,7 @@ static int profile_update(void)
 }
 
 /**
- * platform_profile_notify - Notify class device and legacy sysfs interface
+ * platform_profile_notify - Notify the provider and aggregate sysfs interfaces
  * @dev: The class device
  */
 void platform_profile_notify(struct device *dev)
@@ -650,6 +651,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 	scoped_guard(mutex, &profile_lock)
 		list_del(&to_pprof_handler(ppdev)->node);
 
+	profile_update();
 	device_unregister(ppdev);
 
 cleanup_ida:
-- 
2.43.0
