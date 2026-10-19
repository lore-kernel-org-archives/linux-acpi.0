Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A7F490BEC
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395602; cv=none; b=r9w157w1Qa7+eZFlLUC/01YlDCgoC5Sn5sTD5KZ9vfouDxqS+2WLv+PSOVfemzTStrR4BUfq6u9QQ6xi+GtafjacXxNv0z5jcXd+OYTOzOO0hq2Bq1iMu4lexHaNKsJu2X/7hkd+4cwuU6oBHryEIVesCCLxV9mDUIP0Gr6ezDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395602; c=relaxed/simple;
	bh=hJjJGa4eBm7XtrMdXHGCS4ZkQZ5TfCxifDEVQsme3NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkJXqfD9EN1SYsBGVH1qd4ha1+EsN8Ag1hUOi1tT3i5LXmDpCGO4TG7ZubFQS+nppg3PVkZY6jmkua/2c/P2i3XJdsSskJ3BF1dhZfMpUErGVdnshKWXqncAysj77Lo5JglZXJX2k2JonzkD/3aGYYmmZQQYWRnOD9OukdYgJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WmNiMSkg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MpSYbDRv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WmNiMSkg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MpSYbDRv"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4j17p237813
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 07:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tnpf683EmeZ
	q2xc7PTdD0vDegWDcKYsb++VcsnkPTqo=; b=WmNiMSkg5Mc/B0i1q7tBCLIZQv6
	3GIJZX8h+Hq1Jc3KHvwyxCnEBDUOsG38b1P7rvweKXkYsaxtwOar2R3PKgD99eaz
	1MhoMbb+oijoTJF5BlhS5WcNnHvk/iCgYfKS6q0XgFEZUTFDESKUpOLJQkfm5UjP
	Rx/0dJYLSk2p1PBQbBYhspEpmH7B8G6D8A5snqinSNZQlNNlqsozI7PzPeKZw042
	wUIHdB/WRXYi7eLMxdOle62rqiQ239kbKih7RjbTYFP7oS//31t+2Ls+nLCHmQmq
	a0QMjtinT5Zzj4Ga6Feh6oun/IyqQlJRzHp7CdGuozPwzV+EMc+CWxbUQnQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc26k5cmu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 07:39:52 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91bebff9fcaso46676706d6.2
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792395592; x=1793000392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tnpf683EmeZq2xc7PTdD0vDegWDcKYsb++VcsnkPTqo=;
        b=MpSYbDRvwyCy07DlCtjbZRBoEqZVOV1GoYxSThWehtI9o0tW5lG/TBS6KO+aB2zhVE
         KcXfq+Nt3MO1sBMyTFUs0TKUWX5Z7IbR8Eb19vYzvSLrXmOQPhsfzto7231hWOkM7NC+
         HRcsMbF3A9omHi2IZPN1iiZB8q7bbJtgllgTaM7GJaAkLxjEyId+kF1vaijIgFDZl9L1
         Ipb8/pGqO++SWu1sjy/kKJI1G8ewR7JaeAIChtleZ85Qjiogp+ADajOSiAkc1+UkrdVN
         2AuKnkK2QIwvnMRalxKYFfRVy5CLDp3mKf4nJLepHP6dDFFXtKk+EWawpXM/tZjFg8f9
         9/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792395592; x=1793000392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tnpf683EmeZq2xc7PTdD0vDegWDcKYsb++VcsnkPTqo=;
        b=nJzdji6lng32dCwqSdgULtbYOTe7V9lGkeX9wL7zJIv/gZ/HPnibSp+3Ecp5/GMtix
         nOIxrU+kH5byG1klq7rr3EZ1OklqibYvMO18PxGxKDlF+TATJd8Qoh/wSxwTjJNb43Om
         w0EZ4KdnmZUoS9PoWQ4uQao8yvx0XOh19lmTAjDNknbny6aekxSacw/IvXSoovjl+MlN
         ePveSVhXt2MAQhgL9KPd10bGYE7++dd9JYQiMSkWfspmrK6wBvViercSd+KY56qKaXSf
         l3k2e+fmwVfBNcSvL1jmV/6ledbHrepzXLwKaYm8cXRxvE6Q/nlQ/xLnbG772NF9kImu
         dQSw==
X-Forwarded-Encrypted: i=1; AKwUvBw2H83/7u5Yn9RYDKsGZC2+gu7m3WHpTebwie9mjNXn/GxgHoi5TDizCPx7E5Vo4NxcjyBru4p+3RMX@vger.kernel.org
X-Gm-Message-State: AFq9FYKjYpLvEdWbjOjAnhhtsVijZontr10MgS47AEalM8SXNMxMNv9x
	xAPaHOSeWZ6psbbYo+gkKGMDoFGDX7YTseVIqFGwisaRNXe5TL9ktXHLxjKbRw2WSeFrpvWmkNE
	6RGTz9ZZPSoRxPBza7rHHVpTUHwgcYDUJya+hjuie5lDXrSeD64j759FUWcpoEx9J
X-Gm-Gg: AYBFou0p4ml3KGiAUVPRIagMK15o+gZdmu6rQIJnPS8RVbLBitZ0kG0zr9EjX3vpX6G
	ezONjcD7kMlkP1UZn9tBYe0ynUPXYgtDOotz5F515KI7qI74xT/y/3U6bN2Cooww42OTpoS1E8O
	oqvjLKmdO+LHzs3QCnrejo65NT2Ok6okyvgf7x93O13TxyxGQK11NAh2yxg88ho+7Yha6DC2CV2
	5JdFEY2lMCBR3G+fLPMyCpEk46KpLArvmhTtjcK/VafC/YzwemWmIm3HIdlP87ykOnONNR/8+vX
	UZR5YhHlZJ6WZTXkqB7Hx8fVIQc3F5oVOE2WTfufaxzmur+RSL2gDIYX9pb2GSdkmLztlewSECW
	sBAo2N6SAXpMFFvj0GwggUWmfppU=
X-Received: by 2002:a05:620a:40c7:b0:93f:26d6:d70d with SMTP id af79cd13be357-93f29cf7ddcmr1207149685a.31.1792395591545;
        Mon, 19 Oct 2026 00:39:51 -0700 (PDT)
X-Received: by 2002:a05:620a:40c7:b0:93f:26d6:d70d with SMTP id af79cd13be357-93f29cf7ddcmr1207146085a.31.1792395591068;
        Mon, 19 Oct 2026 00:39:51 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d01d:2002:4b7d:4c30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce325107sm212812955e9.3.2026.10.19.00.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 00:39:50 -0700 (PDT)
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
        Armin Wolf <W_Armin@gmx.de>, Jai Luthra <jai.luthra@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mario Limonciello (AMD)" <superm1@kernel.org>,
        Jack Wu <jackbb_wu@compal.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Zhang DM <jixianqiang1540@gmail.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 3/5] platform profile: Complete class notifications and registration cleanup
Date: Mon, 19 Oct 2026 09:39:06 +0200
Message-ID: <20261019073930.2352283-4-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019073930.2352283-1-daniel.lezcano@oss.qualcomm.com>
References: <20261019073930.2352283-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfX3tPPlCibI0qU
 owZw5ogz2yHVcjcl5zbyn8c3qdGtEe3ESvU9nKqIjj3ZP1emAe1RsiOIIA3aT+XeXwrlQAyf7Sr
 XoeXTm2pTaCurAb2haMo9Lv7mqNRBr28+iVTMWUWqPWBNmStUV8b38FZxrXQjWPOa69wq3O5IFT
 JmgKxBJj/WZ/uKGhV3QUYX6P+gZTyHdRLw0b4Tyoyr9W1Jgr2UBv3i+yVVBgRjhVQVyChte3WfW
 krL1uzdZGz6onJ5boR7y6sfTk3E241MPQuud7WcKHgW1rIUARIEvJ7ckrphA1eIG5VTgptTR663
 ueAdCrzgMtOSsEaHUnKfQTwrMDH8wnQWDZykbDSzkUmzUK22tij/NQrjs90QIGuoJoJtbj9zE5L
 WgCMjmeZxvItzENAfaAhQlqYzedL2ecXsMXF/xpyCVFEzFaBscZDIVs0GceYQcUhxmoJMw1yl4m
 /A8Ewyioc9a0pvSyFwQ==
X-Proofpoint-GUID: TbROdEjZGkQCW3yaLsZPqRE9FIB1aKgA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfX03UFeIr/yzNo
 Evv1MpmodrlFpikjV+TK8jsyFMAgjn/MyHm/hUg8GwmnZ+YF/P3RDvIKLt0BjLcjTRcxqguEkp0
 1FdYmJ/UWSqMhiof/ziQXtb+Yu0S3bI=
X-Proofpoint-ORIG-GUID: TbROdEjZGkQCW3yaLsZPqRE9FIB1aKgA
X-Authority-Analysis: v=2.4 cv=Cowq4X4D c=1 sm=1 tr=0 ts=6ad5c948 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=sNWLPp6fUqVo4Qx2xT0A:9
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190030

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

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/platform/profile/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/profile/core.c b/drivers/platform/profile/core.c
index f18fd96b942c..320a5a964fea 100644
--- a/drivers/platform/profile/core.c
+++ b/drivers/platform/profile/core.c
@@ -250,6 +250,7 @@ static ssize_t profile_store(struct device *dev,
 		ret = _store_class_profile(dev, &index);
 		if (ret)
 			return ret;
+		_notify_class_profile(dev, NULL);
 	}
 
 	profile_notify();
@@ -324,7 +325,7 @@ static int _remove_hidden_choices(struct device *dev, void *arg)
 }
 
 /**
- * platform_profile_choices_show - Show the available profile choices for legacy sysfs interface
+ * platform_profile_choices_show - Show the aggregate profile choices
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
@@ -360,7 +361,7 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
 }
 
 /**
- * _aggregate_profiles - Aggregate the profiles for legacy sysfs interface
+ * _aggregate_profiles - Aggregate the profiles across providers
  * @dev: The device
  * @data: The profile to return
  *
@@ -385,7 +386,7 @@ static int _aggregate_profiles(struct device *dev, void *data)
 }
 
 /**
- * _store_and_notify - Store and notify a class from legacy sysfs interface
+ * _store_and_notify - Store and notify a provider from an aggregate write
  * @dev: The device
  * @data: The profile to return
  *
@@ -403,7 +404,7 @@ static int _store_and_notify(struct device *dev, void *data)
 }
 
 /**
- * platform_profile_show - Show the current profile for legacy sysfs interface
+ * platform_profile_show - Show the current aggregate profile
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
@@ -431,7 +432,7 @@ static ssize_t platform_profile_show(struct kobject *kobj,
 }
 
 /**
- * platform_profile_store - Set the profile for legacy sysfs interface
+ * platform_profile_store - Set the profile across all providers
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to read from
@@ -502,7 +503,7 @@ static int profile_update(void)
 }
 
 /**
- * platform_profile_notify - Notify class device and legacy sysfs interface
+ * platform_profile_notify - Notify the provider and aggregate sysfs interfaces
  * @dev: The class device
  */
 void platform_profile_notify(struct device *dev)
@@ -643,6 +644,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 cleanup_cur:
 	scoped_guard(mutex, &profile_lock)
 		list_del(&to_pprof_handler(ppdev)->node);
+	profile_update();
 	device_unregister(ppdev);
 
 cleanup_ida:
-- 
2.43.0

