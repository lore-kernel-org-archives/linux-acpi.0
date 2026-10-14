Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D77515894
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984623; cv=none; b=gFw6quiZJzSACmdKoQgIjijq0BfEF89Vhw5hEytDyftQzeJYpdNrAoAV9TJhD+D9J7FqOOazqm/ola0MbGfwOpRsYPtrwqHXjHw0g/QBbsuwY+E21oHK3DcxBKeamwM/8u0Cay8FApaLhq5+QlG7L17Kzfg5I8pukfpxeIbLhyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984623; c=relaxed/simple;
	bh=ZqlX1hRIaj1kNOTv80mV1ls3MopFwV4oAlEM09KwzP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flJXJYt6vSI27B+Qg1d6oJvdlpTnQdteyNLwWyPMZQEseZ5eSHKpXMHdD1vEr2MbJlcjmw0/MAb2aM5LPyGPhJ/E9YY7IyoXTOq3gATiL88ToKMhYKoAsGMFcdFq4OFbLH/QSeqy8oOj4Bbqr4xTz6edZ0feN41W/Q+ZrbN31fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lfAf9o9n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ITYDKnnK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lfAf9o9n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ITYDKnnK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EAR0GK466149
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 13:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=518A7MdhUG6
	ATdQPl9l39rO9JNHyIKuwzqURvGyB7UY=; b=lfAf9o9nHm8qqI2xH0NZRIRDEDd
	OoN7JDZF/OFnQnj+y4eoTcQCSZqvAeDNA5eL/OgGB/oW/jmtFaQJmm7Nl50OarrE
	LanoX4o9CCBw3+ZWwCdBEKDyJEYt86ntwr2BZKfK2rexRa3lyOpkDsmcBAMFJidn
	kvnOtRoxIEkFhao5ZlnOtBoHSSyiHw7fTrJi+SqXCwoNOPAzj2xEVsElTHiNeTMc
	1Ky4byKSGgpHjyOkbt33kclestv4En/Zzmpe9k6I/hn+KLycmt/v7QA1BjhM2Dp1
	45Q4xVff1u8I5hEwKf/XOa1xDRmPgllEH351ixvhwMQFQdbUL4WUBoaxdqg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80crp6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 13:30:11 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91b994cb09fso7944156d6.3
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 06:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791984610; x=1792589410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=518A7MdhUG6ATdQPl9l39rO9JNHyIKuwzqURvGyB7UY=;
        b=ITYDKnnKIsGRsCosOw0km7MudQqE9uUMvg9XynfdXcIyGlzb0ldEBDIy7zfIx+IGzm
         L7FSxtDRMCVv+4BrF2TLVzLwBsgMjMBsLkptdQQeIg330Y5uZIC20oJ3/pDejI4x0lVG
         7f2rHotNtyplV2f5gv2xgTxYvwLCHAcmJVqOTS1nAWFav1mIrHY/MDhc+quFH80ddbqN
         4p+MjQD2cTxfrO0Chn40UkpJOzVBVmggpVq/a1GA9AfM4Nl+YwYsPBzHfeYNbErVj3on
         5lI9BySGrZtwvdVn5NUr0ZLVa52MqIjbMgywq2hWHPl2Ax4OHzx0Xhq8UuS08m/ak9Kr
         oIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984610; x=1792589410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=518A7MdhUG6ATdQPl9l39rO9JNHyIKuwzqURvGyB7UY=;
        b=Y7VpmRXlkvUGF1RdKBPvUxRIMXASo9a5dEt73JN2rNixedWJHD/+FM2Z1vwF1XLX+m
         SiS6Hcp5/QcLDHZWxdVRPhYfNI/zBBxp1FgE1Zb3I7DNTqZChG/Ler9/0FEyPbj9s5VB
         q/ckeq93vYqYnI1w2TBZ7gHc05GXKs3mnEtB1Kj7GzsiSxJnbMG/3gVLp6lFLiUjmdx4
         +iqjAG0o89flJ4P+tSRZn08zbHFdgpHJUEHnLft0Sgxkt3yGCbyd7cFpvECnM8RsBtX1
         3x1Hyi0v+0alybtC6KQJ7WI8pyYhiKF8xms3dUydWS9eYV1He9VKPATKYzm52pMhw0q4
         NKag==
X-Forwarded-Encrypted: i=1; AKwUvBz++5me2vf2GSy6llmx1Zs9y3bwi+hZWR4PFqEob5c8x+yMW50w2OrzDKuY1fmqlxyjwLaXYoyITYxP@vger.kernel.org
X-Gm-Message-State: AFq9FYJMI8am3ziWZAdkzv4HJPXkM42pb4VcYXWZl5eBJ0RfayJzBe3r
	uXeHPOweKoEkp1qKt7EF1tV03yV3+7CNZDHty+bH0XOeHhgS2r8nQ401+JtLDi/WzIeBdFKWKYG
	3SZGbxpYp6Qs5oftfm7jIKCbaac04JFPAWOlZ7n8mlBiOauF9HmwzAMGRB03nufLr
X-Gm-Gg: AYBFou3OCdURYL+cgPKJbMsg6yB2i6/2d75ob0HkREUu/QEZPIZbIEpok+5GlS9nuNQ
	6dhXcgFFgMzbprSrlH+GzeXMDQlIkYdBRxmsWuX4Q9i7KMit2xP31DMuJ1es3xuCFJKWc9gg9sK
	CjvuCVHA1NvZoX++On9vqOxGLd/CaB4pPDqmy9Cd0OFkOGg2hgUuSjQ7RoqzOOYnkEZQKaHGpCe
	DSfOKAoXhFnTaRebm6af8kw4fQtIkwa7y77dsYTPEtvYpBMRuQws5+eai1Zgf6cYPWoDGCC0FS/
	Y7U2atNIESAyMVkdZCOnzKwKXNFnQ1AveWnEs8GHV5b5k/G6Ig/m2x7j8lhIAjnIZS5dZi9jRwN
	ynKhYYBFb2aPrUWXBJftLBcWmIkU=
X-Received: by 2002:a05:620a:2304:20b0:93e:d854:4b83 with SMTP id af79cd13be357-93ed8544be5mr1273681185a.22.1791984610287;
        Wed, 14 Oct 2026 06:30:10 -0700 (PDT)
X-Received: by 2002:a05:620a:2304:20b0:93e:d854:4b83 with SMTP id af79cd13be357-93ed8544be5mr1273676585a.22.1791984609774;
        Wed, 14 Oct 2026 06:30:09 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bcf552e8sm2027155e9.13.2026.10.14.06.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:30:08 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Jai Luthra <jai.luthra@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Armin Wolf <W_Armin@gmx.de>, Jack Wu <jackbb_wu@compal.com>,
        "Mario Limonciello (AMD)" <superm1@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 3/4] platform profile: Add firmware-neutral aggregate sysfs interface
Date: Wed, 14 Oct 2026 15:24:46 +0200
Message-ID: <20261014132500.3817549-4-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
References: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfX+eY0BshXReAn
 4ncRNZNr0AXRgrHq59YHMyD0QciFwgtOGnne/EFAV4BcdthEfq3le+ireFiMm2HnygbP56v0mKJ
 R6gePGXWoqG24A2B2BpEea4qRDpQiZ0=
X-Proofpoint-GUID: xZYxGXRfXY4rd_c_FzA-WqmJgR1jYIG6
X-Proofpoint-ORIG-GUID: xZYxGXRfXY4rd_c_FzA-WqmJgR1jYIG6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfXzg1wAw23rlSB
 Fbr3iPqtymC1Y64U6Rk80fCePuErbJOzhxyz8EU7OcODZxiwYmXnCqifwvBO6Qz8Kp7bPwmBrQn
 8usvmkGhl61Xzcsqz7QiBUkVTiVZGrH6bFlWkQFUUBzmRAjy8XyEkXrX/SMEUGtmkjXkr4sxYLD
 pT6fGgUpZhdBnRXyb68tD6Z5NQOWKRTTYZKEugTS+GXRFujPEi2dJwzLsNtDCd8G0bxQwAEkPpl
 NZmZFIa34AvCSigQOm8P5NSYYOd+sTx/nQgHvLKJOFwV6oNTPUUVPQvonYtALHAqn9CgiiD1S3e
 ioiHAyJ7+Imbt3yLNxnX05qIOryupN1xS4k5fr3p5CXqKGQ5D72SmczXwqOh2XtiVzywWbz47BX
 hpGyIoitjKZ1LQFPlN5XhPRQ/XIRV1Oq9AndUCKZsC/is0d7W8q8q6GNhXnd1ppRHLxHCGVHheQ
 drHdGHLGRJSC65dWTtw==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6acf83e3 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=8ZtbILYAgf2ziLaPuYcA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140053

The per-provider class interface is firmware-independent, but system-
wide profile selection is only exposed under /sys/firmware/acpi.

Add /sys/kernel/platform_profile/{choices,profile}, sharing the existing
aggregate callbacks and semantics with the legacy interface. Keep
attributes hidden until a provider is registered and remove them after
the last provider.

Notify both aggregate frontends on profile changes. Also notify the
provider class device on a direct profile write, matching its documented
POLLPRI ABI. Restore aggregate visibility after a failed registration.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/platform/profile/core.c | 60 +++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/profile/core.c b/drivers/platform/profile/core.c
index f18fd96b942c..507b96bdfdb1 100644
--- a/drivers/platform/profile/core.c
+++ b/drivers/platform/profile/core.c
@@ -26,9 +26,11 @@ static DEFINE_MUTEX(profile_lock);
 static DEFINE_MUTEX(profile_registration_lock);
 static LIST_HEAD(profile_handlers);
 static struct kobject *compat_kobj;
+static struct kobject *profile_kobj;
 
 static void profile_notify(void)
 {
+	sysfs_notify(profile_kobj, NULL, "profile");
 	if (compat_kobj)
 		sysfs_notify(compat_kobj, NULL, "platform_profile");
 }
@@ -250,6 +252,7 @@ static ssize_t profile_store(struct device *dev,
 		ret = _store_class_profile(dev, &index);
 		if (ret)
 			return ret;
+		_notify_class_profile(dev, NULL);
 	}
 
 	profile_notify();
@@ -324,7 +327,7 @@ static int _remove_hidden_choices(struct device *dev, void *arg)
 }
 
 /**
- * platform_profile_choices_show - Show the available profile choices for legacy sysfs interface
+ * platform_profile_choices_show - Show the aggregate profile choices
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
@@ -360,7 +363,7 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
 }
 
 /**
- * _aggregate_profiles - Aggregate the profiles for legacy sysfs interface
+ * _aggregate_profiles - Aggregate the profiles across providers
  * @dev: The device
  * @data: The profile to return
  *
@@ -385,7 +388,7 @@ static int _aggregate_profiles(struct device *dev, void *data)
 }
 
 /**
- * _store_and_notify - Store and notify a class from legacy sysfs interface
+ * _store_and_notify - Store and notify a provider from an aggregate write
  * @dev: The device
  * @data: The profile to return
  *
@@ -403,7 +406,7 @@ static int _store_and_notify(struct device *dev, void *data)
 }
 
 /**
- * platform_profile_show - Show the current profile for legacy sysfs interface
+ * platform_profile_show - Show the current aggregate profile
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
@@ -431,7 +434,7 @@ static ssize_t platform_profile_show(struct kobject *kobj,
 }
 
 /**
- * platform_profile_store - Set the profile for legacy sysfs interface
+ * platform_profile_store - Set the profile across all providers
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to read from
@@ -493,8 +496,30 @@ static const struct attribute_group platform_profile_group = {
 	.is_visible = profile_class_is_visible,
 };
 
+static struct kobj_attribute aggregate_choices =
+	__ATTR(choices, 0444, platform_profile_choices_show, NULL);
+static struct kobj_attribute aggregate_profile =
+	__ATTR(profile, 0644, platform_profile_show, platform_profile_store);
+
+static struct attribute *aggregate_attrs[] = {
+	&aggregate_choices.attr,
+	&aggregate_profile.attr,
+	NULL
+};
+
+static const struct attribute_group aggregate_group = {
+	.attrs = aggregate_attrs,
+	.is_visible = profile_class_is_visible,
+};
+
 static int profile_update(void)
 {
+	int err;
+
+	err = sysfs_update_group(profile_kobj, &aggregate_group);
+	if (err)
+		return err;
+
 	if (compat_kobj)
 		return sysfs_update_group(compat_kobj, &platform_profile_group);
 
@@ -502,7 +527,7 @@ static int profile_update(void)
 }
 
 /**
- * platform_profile_notify - Notify class device and legacy sysfs interface
+ * platform_profile_notify - Notify the provider and aggregate sysfs interfaces
  * @dev: The class device
  */
 void platform_profile_notify(struct device *dev)
@@ -643,6 +668,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 cleanup_cur:
 	scoped_guard(mutex, &profile_lock)
 		list_del(&to_pprof_handler(ppdev)->node);
+	profile_update();
 	device_unregister(ppdev);
 
 cleanup_ida:
@@ -726,15 +752,33 @@ static int __init platform_profile_init(void)
 	if (err)
 		return err;
 
+	profile_kobj = kobject_create_and_add("platform_profile", kernel_kobj);
+	if (!profile_kobj) {
+		err = -ENOMEM;
+		goto unregister_class;
+	}
+
+	err = sysfs_create_group(profile_kobj, &aggregate_group);
+	if (err)
+		goto put_kobj;
+
 	compat_kobj = platform_profile_compat_kobj();
 	if (compat_kobj) {
 		err = sysfs_create_group(compat_kobj, &platform_profile_group);
 		if (err) {
 			kobject_put(compat_kobj);
-			class_unregister(&platform_profile_class);
+			goto remove_group;
 		}
 	}
 
+	return 0;
+
+remove_group:
+	sysfs_remove_group(profile_kobj, &aggregate_group);
+put_kobj:
+	kobject_put(profile_kobj);
+unregister_class:
+	class_unregister(&platform_profile_class);
 	return err;
 }
 
@@ -744,6 +788,8 @@ static void __exit platform_profile_exit(void)
 		sysfs_remove_group(compat_kobj, &platform_profile_group);
 		kobject_put(compat_kobj);
 	}
+	sysfs_remove_group(profile_kobj, &aggregate_group);
+	kobject_put(profile_kobj);
 	class_unregister(&platform_profile_class);
 }
 subsys_initcall_sync(platform_profile_init);
-- 
2.43.0

