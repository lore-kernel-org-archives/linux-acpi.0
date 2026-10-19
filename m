Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868148FF8F
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395598; cv=none; b=cRyys43WZAX2jwsL38iRT0DKKoRhGzVO6On8aYaGuG+Q7YvY5UXmSWLxyzX4NvkpLRJvM52wJdQpWDEOCIkIxQRq0gWNYt6umjGdTQknppHHKEqiiWFaKx0PKIBbAOdnfDteCNJdLwG+QttBJBfqzyMECTcTJGLTMJtHrovtFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395598; c=relaxed/simple;
	bh=p07iEb35ew4rhOEg7En2KdbSWe0jhUN4Q6HAAyHT/Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1Pl0CYwVOYccza2IoRSi6RP0Y0/0K/apolcM8gB2ehzXT+PsRYQ+Q7wv5D1FOjVV17rDrgcIg7FBxcVnmQlb0+s3y4tZ/A9ooFVfeckhkLbDdM/9G0WEYB382Px/1Xp4vo+FAe4RpZS36Erfuh17LMzhBAj+oKqxp0PNcwIWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i60YYQ6o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NxI1aZNC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i60YYQ6o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NxI1aZNC"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4jJlA1408613
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 07:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+heyUUDe3z2
	ElJaSEfijE4i66Qx9XUHm2pk2TCmmnhc=; b=i60YYQ6opTE+P2AaIX7k6+kAEPi
	hEGbxsKldg20TQ6BLoMWv7jlgm7FZE4+SkA9makEDbuIZsgvhtCQasGRGWc/RMuL
	LEs+gYArnQITbEX50uLCBFOl/vBTaHN8oDl8FYFyvHqYDCDYg8GpwG22noBMWOy6
	ojp+286D+VIK+caEirxd/otCh2usPKV+isVqGoL+tMXxUnwthnDw20jSvPnMFP7r
	IMUC+nLWpAVVfUz8s1yA+m7pSqAUUtre9bLmU14P8r+TWu1Yj2kZiL1/no1G4wnp
	avcDWG0zG2aBohX24twb+MFC0cr+NumKAhWyiBnx9hnqVsxMktWk36A1U6A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdbvr8s5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 07:39:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb6391e89so419215185a.1
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 00:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792395586; x=1793000386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+heyUUDe3z2ElJaSEfijE4i66Qx9XUHm2pk2TCmmnhc=;
        b=NxI1aZNCc36JfnOxjfPB6ALuR/s2ZNC7IO9N8Jkw/ibeHUXTC9gGJ9Tp28CsaGgRNI
         PsnPhPkwgUAMggGm1tXn1SLJ15jynyOtgTspaX0nCBgxDcJKdli6SdPa/6zdx746TehF
         alHMsJCAh3BPykqvBOBCUEpaWUAc03udjm/Abyz9eY7NkH1aA5Yqkl6BJ+gI8R0lSnBn
         NNjet043o7BjhdlRu1nUGz1XpRCtmnsvEun4UibnZqlVqrZVaoEsSgMrPb9h6bDI7DgL
         F+reXigfzFoSxYDWmFNr6Bkop0Ht7LUjmXPbCXEhpJOvYBsxIcHyd1tx/qu885ZXLa20
         b8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792395586; x=1793000386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+heyUUDe3z2ElJaSEfijE4i66Qx9XUHm2pk2TCmmnhc=;
        b=bFxYBiCV5NxrxWj2x3dH7VKSZevxG/9m+ITMFsEUS/Iil9LoAVxEATOwvMOQ9xgk1H
         8MgZ4mM/WS3AypWrLzRRf856D6NUjJRE6wM989JKnWtiHVLneH7K3phgP/OOKlSrAR05
         f8glICpHQTjd71z0Q43IUUUISpB/+PnGlubbmTAWNn1S4aRyy3n7YtZAk0JMZUFXV2K4
         h268sL0XGQ3qOjZkKsAu9vC/aag/r7oef9Mit6ON9Dias/tP3h/9kVWEv8PUyULzxSL1
         hmOKqCvLrdS6SLgKtq76cye5j8wFrHKvThHVxWwh2vFYMMAIv7jyqTlqJetsdn3GKeBH
         4y+Q==
X-Forwarded-Encrypted: i=1; AKwUvBx2nPFf7a3QY331LV4FY2Fx+Ik57hpHRfTCrxESEQzaxjq2lXqrIUxPf8DG0R5xeG6ej/uNOj9sXOsl@vger.kernel.org
X-Gm-Message-State: AFq9FYLF61W2jQSuX6M4LiDM+SSn/Sy2GE9lRODlTNycVSnn5KeCVLW9
	i9iOpdH9OQs8M4lG2pCqVX9eUN5QpL8r0PUPiourT7TefztekWj9HRo+Kd0q25CtMSEMlOhxjUE
	ZHZ+dYU33epPWkPoWxhN7MRvnCyOKiGS+SDZGx2acR6Bd60frLmRNoYAsHbYQo3DZ
X-Gm-Gg: AYBFou1EMLEwsiZwSaSVj0bhPWEFJdYf0VSYjuv7qqllhmUuqwHO/WbE5Xm9A408tak
	nijv8Nrl7VPs0zsa7xkUc90CbuPPqClgO537/S8egRRBe67jywokghEFbu0MkN0+n3OcPuVKQeE
	NvRmDj4MfnGCB03iID5r078ACxNxCXynSGM/onY4MPNgbi6bSd8Wk3uO1tXHXrZygz9/2nAIqfS
	5EDhPD5D5anV07hhwka9v4RmqrducWvUu5kEoxvGv0Z+zuvp3nz6UKQNhwsOk1SvoDB5O+IKp0u
	YuWt+kLFkkWm5HwkGR7UXFrzL7HZklWUtv23whRcBKWbIom/Nxmn/UwyOleBxxJvPsfgcNqm93K
	8RQy0qQS/uPOoKyR2ATWrockGnO8=
X-Received: by 2002:a05:620a:454a:b0:93b:c58c:d3be with SMTP id af79cd13be357-93f29d42f1emr1211042785a.37.1792395585477;
        Mon, 19 Oct 2026 00:39:45 -0700 (PDT)
X-Received: by 2002:a05:620a:454a:b0:93b:c58c:d3be with SMTP id af79cd13be357-93f29d42f1emr1211039285a.37.1792395584963;
        Mon, 19 Oct 2026 00:39:44 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d01d:2002:4b7d:4c30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce325107sm212812955e9.3.2026.10.19.00.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 00:39:44 -0700 (PDT)
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
Subject: [PATCH v2 1/5] platform profile: Separate handler locking from sysfs lifetime
Date: Mon, 19 Oct 2026 09:39:04 +0200
Message-ID: <20261019073930.2352283-2-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfX4MkLSCMGrHok
 nnSOv2AI7mq0064zo9GML1CSQK+lUQXRbbwcp3SnlwIDXhG9ashw6IakfeoF8f0vSsA4CPxfcmT
 JPEUyg/5tR1r3sHhAatePTAt6asOLQBuNFt6xfqS6y4R+eWQjZ9HR2XcyJic4cs0OdBvqhNxBhk
 DQJu0Jj3doGVe+ZGF9NHqBFS8fwS2zijGDx23bW8Pr/TepBC1I45LAKgWScV1M4ewNxM5mVKMWk
 Cztf1ZEqyO0IfTKgTnNpIt/e8TuWGHI/1Kdo96lAbjrjhz0t4ocTCEUMmkHed9jAGgwd9/0FcAG
 epGzhQwmZCcAP5hBIY1sXF5gqKJgnNOA8HwqG1O6q01LCfAM2HyNm8A85joRa1+5ewKLcqUoY9g
 3PMLAs7iCtIIlycjyILtdCK+MuhFsGAjzcRyNzA00Vtrkon0GCNZFXcgL9EO5yfdLq8xBAilmWK
 Uat7fX/Ca+jDR4Eb1FA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfX7cF54azyfQWd
 w1KUM+pqkKHUUB6lCsURPUpfHiqHYPXN9l1uwtYOhl4yM+E814ezch9UIDljZ2N59n1dqb6fw5d
 ir8wicmJBgbrxg9G58kY0l2nfN/PWyw=
X-Proofpoint-GUID: UVe0YpyFi384HxKeYf3MW4_TsPxJRZtz
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad5c942 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=-LHEi2PMdtMAXt8Lty8A:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: UVe0YpyFi384HxKeYf3MW4_TsPxJRZtz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190030

Registration and removal currently hold profile_lock across
device_unregister() and sysfs_update_group(). These operations can remove
sysfs attributes and wait for their active callbacks to finish. The
profile read and write callbacks acquire profile_lock themselves, so a
concurrent access can deadlock:

  Removal/update path             Active sysfs callback
  -------------------             ---------------------
  acquire profile_lock            hold kernfs active reference
  remove a sysfs attribute         wait for profile_lock
  wait for its active references

The removal path cannot finish until the callback returns, and the
callback cannot return until the removal path releases profile_lock.
This applies both to per-provider device teardown and to updates of the
legacy aggregate attribute group.

Commit 041142d7d252 ("ACPI: platform-profile: Fix possible deadlock in
platform_profile_remove()") previously fixed this lock ordering by moving
sysfs_remove_group() outside profile_lock. Commit 55b1e68134bf ("ACPI:
platform_profile: Use guard(mutex) for register/unregister") reintroduced
the issue by extending the mutex guard over sysfs_remove_group(). Later,
commit 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI
platform profile") replaced that teardown with device_unregister() and
sysfs_update_group(), still under the same mutex, extending the problem
to class-device teardown and aggregate attribute updates.

Simply dropping profile_lock around these operations is insufficient.
Aggregate operations currently discover providers through the class
device list. A provider being unregistered could therefore still be
selected for an aggregate read, write or cycle while its sysfs files are
being torn down. Concurrent registrations and removals would also race
when updating aggregate attribute visibility.

Introduce profile_registration_lock to serialize registration, removal
and aggregate sysfs updates. Sysfs callbacks never acquire this mutex.
Retain profile_lock for profile operations and use it to protect an
explicit list of handlers participating in the aggregate interface.

Add a handler to that list only after device_register() succeeds. On
removal, unlink it under profile_lock before calling device_unregister().
Acquiring profile_lock first waits for any aggregate operation already
using the handler to complete; unlinking prevents later aggregate
operations from finding it. Release profile_lock before draining sysfs
callbacks, allowing active per-provider callbacks to complete before the
device is released. Apply the same unlink-before-unregister ordering to
registration error cleanup.

Walk this list for aggregate reads, writes and profile cycling, and use
its emptiness to determine aggregate attribute visibility. The class
devices remain the per-provider userspace interface.

There can now be an interval between removing the last handler from the
list and removing the aggregate attributes. Explicitly reject choices
reads and writes during that interval: the intersection bitmap starts
with every bit set, so an empty traversal must not advertise all profiles
or report a successful write without updating a provider.

This separates aggregate membership from class device teardown while
preserving the existing class and ACPI sysfs interfaces.

Fixes: 55b1e68134bf ("ACPI: platform_profile: Use guard(mutex) for register/unregister")
Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/acpi/platform_profile.c | 75 ++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 79d2e92e5c28..f98ce4cda02c 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -8,6 +8,7 @@
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/init.h>
+#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
@@ -15,8 +16,12 @@
 #define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, dev))
 
 static DEFINE_MUTEX(profile_lock);
+/* Serialize registration and sysfs updates without blocking sysfs callbacks. */
+static DEFINE_MUTEX(profile_registration_lock);
+static LIST_HEAD(profile_handlers);
 
 struct platform_profile_handler {
+	struct list_head node;
 	const char *name;
 	struct device dev;
 	int minor;
@@ -44,6 +49,22 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
 static DEFINE_IDA(platform_profile_ida);
 
+static int profile_walk_handlers(void *data,
+				 int (*fn)(struct device *dev, void *data))
+{
+	struct platform_profile_handler *handler;
+	int ret;
+
+	lockdep_assert_held(&profile_lock);
+	list_for_each_entry(handler, &profile_handlers, node) {
+		ret = fn(&handler->dev, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * _commmon_choices_show - Show the available profile choices
  * @choices: The available profile choices
@@ -306,20 +327,18 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
 	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		err = class_for_each_device(&platform_profile_class, NULL,
-					    &data, _aggregate_choices);
+		err = profile_walk_handlers(&data, _aggregate_choices);
 		if (err)
 			return err;
 		if (data.count == 1) {
-			err = class_for_each_device(&platform_profile_class, NULL,
-						    &data, _remove_hidden_choices);
+			err = profile_walk_handlers(&data, _remove_hidden_choices);
 			if (err)
 				return err;
 		}
 	}
 
 	/* no profile handler registered any more */
-	if (bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
+	if (!data.count || bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
 		return -EINVAL;
 
 	return _commmon_choices_show(data.aggregate, buf);
@@ -384,8 +403,7 @@ static ssize_t platform_profile_show(struct kobject *kobj,
 	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		err = class_for_each_device(&platform_profile_class, NULL,
-					    &profile, _aggregate_profiles);
+		err = profile_walk_handlers(&profile, _aggregate_profiles);
 		if (err)
 			return err;
 	}
@@ -423,15 +441,13 @@ static ssize_t platform_profile_store(struct kobject *kobj,
 		return -EINVAL;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		ret = class_for_each_device(&platform_profile_class, NULL,
-					    &data, _aggregate_choices);
+		ret = profile_walk_handlers(&data, _aggregate_choices);
 		if (ret)
 			return ret;
-		if (!test_bit(i, data.aggregate))
+		if (!data.count || !test_bit(i, data.aggregate))
 			return -EOPNOTSUPP;
 
-		ret = class_for_each_device(&platform_profile_class, NULL, &i,
-					    _store_and_notify);
+		ret = profile_walk_handlers(&i, _store_and_notify);
 		if (ret)
 			return ret;
 	}
@@ -450,22 +466,11 @@ static struct attribute *platform_profile_attrs[] = {
 	NULL
 };
 
-static int profile_class_registered(struct device *dev, const void *data)
-{
-	return 1;
-}
-
 static umode_t profile_class_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
 {
-	struct device *dev;
-
-	dev = class_find_device(&platform_profile_class, NULL, NULL, profile_class_registered);
-	if (!dev)
-		return 0;
-
-	put_device(dev);
+	guard(mutex)(&profile_lock);
 
-	return attr->mode;
+	return list_empty(&profile_handlers) ? 0 : attr->mode;
 }
 
 static const struct attribute_group platform_profile_group = {
@@ -502,8 +507,7 @@ int platform_profile_cycle(void)
 	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		err = class_for_each_device(&platform_profile_class, NULL,
-					    &profile, _aggregate_profiles);
+		err = profile_walk_handlers(&profile, _aggregate_profiles);
 		if (err)
 			return err;
 
@@ -512,8 +516,7 @@ int platform_profile_cycle(void)
 		    profile == PLATFORM_PROFILE_LAST)
 			return -EINVAL;
 
-		err = class_for_each_device(&platform_profile_class, NULL,
-					    &data, _aggregate_choices);
+		err = profile_walk_handlers(&data, _aggregate_choices);
 		if (err)
 			return err;
 
@@ -525,8 +528,7 @@ int platform_profile_cycle(void)
 					  PLATFORM_PROFILE_LAST,
 					  profile + 1);
 
-		err = class_for_each_device(&platform_profile_class, NULL, &next,
-					    _store_and_notify);
+		err = profile_walk_handlers(&next, _store_and_notify);
 
 		if (err)
 			return err;
@@ -583,7 +585,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 		}
 	}
 
-	guard(mutex)(&profile_lock);
+	guard(mutex)(&profile_registration_lock);
 
 	/* create class interface for individual handler */
 	minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
@@ -604,6 +606,8 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 		put_device(ppdev);
 		goto cleanup_ida;
 	}
+	scoped_guard(mutex, &profile_lock)
+		list_add_tail(&to_pprof_handler(ppdev)->node, &profile_handlers);
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
@@ -614,6 +618,8 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 	return ppdev;
 
 cleanup_cur:
+	scoped_guard(mutex, &profile_lock)
+		list_del(&to_pprof_handler(ppdev)->node);
 	device_unregister(ppdev);
 
 cleanup_ida:
@@ -636,7 +642,10 @@ void platform_profile_remove(struct device *dev)
 
 	pprof = to_pprof_handler(dev);
 
-	guard(mutex)(&profile_lock);
+	guard(mutex)(&profile_registration_lock);
+
+	scoped_guard(mutex, &profile_lock)
+		list_del(&pprof->node);
 
 	ida_free(&platform_profile_ida, pprof->minor);
 	device_unregister(&pprof->dev);
-- 
2.43.0

