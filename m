Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507545;
	b=Agzf4mXNn35zt2pZneVfp2kbqOLeq94G/yqTXH2prXP9vswZSpJu9lUXRsGz7iMkYI7D
	 wV/8ixOieLVc8lpQy8+62Pts+N0JLUFpqebnNBpY7aVAc2hyksSsq/aHKzDmf8J0XgkXG
	 etdn450y9/H+/6e878VYQLBhCBTQ1WREbMzNpXj3ILpboF2b4GuCg8zzsDYSqb0W3sa2m
	 nAfCdkWgzZfhMMd31koJyzwQ90VRZePwuBUJs6Orc0giS+akQ84cgHxZsngMt6912Z+2L
	 eEjiRazbtalcgg5wQznFqLYQ7lUYnqbr3Tn6FXFavFaMKS1Ccd8DzCl8Zlw7tn1O3DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507545;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8dbti84VQZnRoyeZV4350aERHO6muqhqQOQJux036u0=;
	b=jqsuIIUpvVYxy3/3iQmavsfUT4o/ycewhduPrGulZPoBGkz/JbxV/Htq73Auxp1D4357
	 Py3Ba5j40Zq44nnpUybv34e4jNTIqvGaGgqsi9ELouq0Gf9yoQRzZOnrA+H9+TfRjvI7d
	 YPD9+RpmRNj50FKzkLFUgI5L2u9aS0YdJFIXWFPR685sjs3f5h0NQTDHYUZIRMNeKAqsu
	 XUCygxREV6NPykJmBfuOx9XhgekEQCHWYCAvf077rBvM7cG1GIIYH34CKSJJv0br+ug5M
	 Sw/NeMU6LswkKM0rde3mywEG1ud5f+pn+kcIlw/N5g9NwqAf3TsacfyRxSYGDx+cTSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hLMMg0QP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AiixKM7c;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07494606A31B
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 14:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07494606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hLMMg0QP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AiixKM7c
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDACKC1429966
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 14:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8dbti84VQZnRoyeZV4350aERHO6muqhqQOQ
	Jux036u0=; b=hLMMg0QPCCSRW1jxQN0pwOX162ofZo2sdj7Uph673jP7aGe2K7a
	/+rirvtt/Grar/hgd667SoVlXSplzEGDDDZ2NfWUXoDCmVN5b4qUntDRnmbmPLZW
	TgfzPoiQyXQCf1RoWSLOXotJ0wH6C0ONGfHtpf68OfTxQ9XpSXEmemUvvSEcUhfK
	xtCT8PjJSns+Z0jTYP0aRN2P5+wRFQUunr59qVRYQeM5LCKy2dIRZR2ECaXM3M7F
	b5227oqMXtn7yoi7dcJdPnsYWxi+5W/PlyDAdAb7PqjJvuopDwM6yUDomyci9D0t
	X3Yb9E/vByA3podX9AoPFZUamMaceyvF+2w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5qaxun-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 14:45:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cbf2fd504so567163685a.2
        for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792507543; x=1793112343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8dbti84VQZnRoyeZV4350aERHO6muqhqQOQJux036u0=;
        b=AiixKM7c3pezyKQVLd/LBGuIZLym/YwVBCn9cslknsPTk4Xe3rW5o16DpINd83xK7n
         7dy251gV7On5WREI5Zz5V7cJRsh1Pnp0vdTP/5/9iq7MQBmlGoP3B+OHllIqnyzQV6/8
         f65Cadulv4P8cVSjtR0XdWhMLBS4ys2GB4uxTSk07czc3yXG5d43ROJFwKnY3URIVHBW
         whpLFqRFJs3F8P/3xeY/qKvLzmDNjw0L7D7k1Nu7X3MEH22vVYneJ6plDKaSjifZvMFo
         84Ws5i7zoCDmxUIqZT4PWJb8WT41PpWsRbcZzRvaMqlEZhkmJLICUFDLiIqqQmsFG4e/
         LygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792507543; x=1793112343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8dbti84VQZnRoyeZV4350aERHO6muqhqQOQJux036u0=;
        b=qWp1Ota9W0cl8N/QTM64eucjmAbAkkdrYebFCDVX8wxZiBMqNMk9f8923Bd4tgWJNO
         Iecx2bTLTDPsJo9PP4+u3KNPgDPQ6upVrDvpVWrMSEArt+Mog4kGJX6/gqcIfPqvqYwH
         Uryx7ajACNKs3swf6dVG4MJ+W+HPTf79wB3E4P+Usn330AZAiWzY0g7vuCy2NeLh+5mO
         it06dDMNPrGgjptmm1pWIS+eoYVO8wuBbrqW2kgSj7VeV3NKijnejHrPjCPB441ekI6n
         Q2R49bFpxSvnWAaw7/jcoNE1DBdsluQziRoRCn8E4wdPGqweNO1gtG6+ggADQfMisEix
         fOlA==
X-Forwarded-Encrypted: i=1; AKwUvBzLrVw5seXOpnWvjmz7iQcMssCt1Yetw4ixTNg0zUXpTxyROZbbca6wIsCjKR2uG+BIe5eTH0dmoMeY@vger.kernel.org
X-Gm-Message-State: AFq9FYIweeAP5NSqMcZV7Yb4zgJrQ+o9lhNjE0zdkWT8Rf6kk3UkmtdC
	bZpfj6gYt/BqOysJ1EgZHK2GzSeG8uy+lSdwR3XzWX9ykhYmoz4G05Ki5/5qLWw3fc+kAZ1SFyw
	uQBdK7l/0AJp1KRlUPS5Vjk1qeH7+4TapiZdww33Zr29K8KoxURy6ia1EWJm01W7y
X-Gm-Gg: AYBFou1+Hs1dP9xsYyv4K5w5eeMcEKKF4BX65pkheJiMgTFU/uuoGtDw4KGIMOplXas
	R4EijD3xDKz4jQFDPRYKiCfeFKKoZRpD4+TwiUqW1xb7RZPyWWSPVKdV3R2xyuj1q2oySLUVCaw
	qOL5gVfIp+XZmKQTTZz0kneOCcfRXO0Fi+gbNiXBNOxxOQ0npXLDVACQz2dRfxvytX6IkHHa34K
	G2JYmgCIcU22efLsYkEy/wBuxlIahqgrDUDNEZyNV0m+UwCw0r72iulu+kIlSFBdx0gucli4d8N
	1EQ21xN7bff1W85oEouLZW4JCwjo5fcDUx7sJslFWUkRWs68pqw43lM0UBeLm2+n0vb79B4DfbY
	0WjoqtCLfkWVWzRmiriermKaeSlQ=
X-Received: by 2002:a05:620a:7014:b0:912:1206:ddd1 with SMTP id af79cd13be357-93f29b46ad7mr1631408285a.1.1792507543136;
        Tue, 20 Oct 2026 07:45:43 -0700 (PDT)
X-Received: by 2002:a05:620a:7014:b0:912:1206:ddd1 with SMTP id af79cd13be357-93f29b46ad7mr1631380385a.1.1792507540863;
        Tue, 20 Oct 2026 07:45:40 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:4884:6e9a:d9ff:9fa6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1df370381sm179377585e9.1.2026.10.20.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:45:40 -0700 (PDT)
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
Subject: [PATCH v3] platform profile: Separate handler locking from sysfs lifetime
Date: Tue, 20 Oct 2026 16:45:25 +0200
Message-ID: <20261020144525.3265851-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-ORIG-GUID: r_a1pZ9cjiBqCJMuK28Q99WfFf-1Q7kO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1OCBTYWx0ZWRfX+zAW+Pe+4l6K
 RZLfMMzezMtEh/dQ0oYSUu+NHu9pBQqEj1eNQQjjh840Ce54a0hWhBCYnn5XcUlLzQzilLU0z+4
 ZVPaXjQo5UqPURVFnzRBRnUS0mueYqJTiq3ZjL+mzpqtGRkDpm50idIvAwkY9VyU0ayUtbazNjG
 UUQ/vVslY8LkX6/BXHW7VCF9Gc5suKKEvhl+561i8Ox3fmshJCE1fhHSIVDXRyM4Twky4GqgtKq
 g7FOXtNUJIBDQs09TaIYAEsnwJEvkDQdlAoa/p+GPrHEeFEDOxEftVV+GrJr5WKq9FJyZER74W5
 zXy6r5ETC3Qv1DfTTfXKkixuRILKO6iumYcEfQr01Us0IqStsNdY76TFd/J3UPeS4ZZr4X5/CG5
 mqaBx5MqhVcfg8+L029qw4DmG/33Wwb+xawjKxYwxPYMlA1ltENMI8auqKgin9dXWZs836NOg6l
 PqcNy81HhmK9wtDem4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1OCBTYWx0ZWRfX3r+IdJbqhglD
 4dabDmr+sheV6+1/XTS7L0gB2hB5+8pJl4buYo/qikYAppU7tIn+XWwKlO/9eqFnrrPX21CRVkd
 9EMlVs2cW9Cp7cuvQtx/ldJOTbMUbLo=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad77e97 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=4c0kPULnjDDMktAHOzUA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: r_a1pZ9cjiBqCJMuK28Q99WfFf-1Q7kO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200058

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
Changes in v3:
  - Send the locking fix as a standalone patch, independently of the
    firmware-agnostic extraction and legacy-interface deprecation series.
  - Document that profile_lock protects handler-list membership and
    serializes profile operations against each other and handler removal.
    Explain why it must not be held across sysfs teardown.

Changes in v2:
  - Expand the deadlock and handler-lifetime explanation.
  - Add the Fixes tag and describe the earlier fix, regression and later
    extension to class-device teardown and sysfs group updates.

 drivers/acpi/platform_profile.c | 80 ++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 79d2e92e5c28..d79080a20e21 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -8,15 +8,25 @@
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/init.h>
+#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
 #define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, dev))
 
+/*
+ * Protects profile_handlers membership and serializes profile operations
+ * against each other and handler removal. Never held across sysfs teardown,
+ * which can wait for callbacks that acquire this lock.
+ */
 static DEFINE_MUTEX(profile_lock);
+/* Serialize registration and sysfs updates without blocking sysfs callbacks. */
+static DEFINE_MUTEX(profile_registration_lock);
+static LIST_HEAD(profile_handlers);
 
 struct platform_profile_handler {
+	struct list_head node;
 	const char *name;
 	struct device dev;
 	int minor;
@@ -44,6 +54,22 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
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
@@ -306,20 +332,18 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
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
@@ -384,8 +408,7 @@ static ssize_t platform_profile_show(struct kobject *kobj,
 	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		err = class_for_each_device(&platform_profile_class, NULL,
-					    &profile, _aggregate_profiles);
+		err = profile_walk_handlers(&profile, _aggregate_profiles);
 		if (err)
 			return err;
 	}
@@ -423,15 +446,13 @@ static ssize_t platform_profile_store(struct kobject *kobj,
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
@@ -450,22 +471,11 @@ static struct attribute *platform_profile_attrs[] = {
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
@@ -502,8 +512,7 @@ int platform_profile_cycle(void)
 	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		err = class_for_each_device(&platform_profile_class, NULL,
-					    &profile, _aggregate_profiles);
+		err = profile_walk_handlers(&profile, _aggregate_profiles);
 		if (err)
 			return err;
 
@@ -512,8 +521,7 @@ int platform_profile_cycle(void)
 		    profile == PLATFORM_PROFILE_LAST)
 			return -EINVAL;
 
-		err = class_for_each_device(&platform_profile_class, NULL,
-					    &data, _aggregate_choices);
+		err = profile_walk_handlers(&data, _aggregate_choices);
 		if (err)
 			return err;
 
@@ -525,8 +533,7 @@ int platform_profile_cycle(void)
 					  PLATFORM_PROFILE_LAST,
 					  profile + 1);
 
-		err = class_for_each_device(&platform_profile_class, NULL, &next,
-					    _store_and_notify);
+		err = profile_walk_handlers(&next, _store_and_notify);
 
 		if (err)
 			return err;
@@ -583,7 +590,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 		}
 	}
 
-	guard(mutex)(&profile_lock);
+	guard(mutex)(&profile_registration_lock);
 
 	/* create class interface for individual handler */
 	minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
@@ -604,6 +611,8 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 		put_device(ppdev);
 		goto cleanup_ida;
 	}
+	scoped_guard(mutex, &profile_lock)
+		list_add_tail(&to_pprof_handler(ppdev)->node, &profile_handlers);
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
@@ -614,6 +623,8 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 	return ppdev;
 
 cleanup_cur:
+	scoped_guard(mutex, &profile_lock)
+		list_del(&to_pprof_handler(ppdev)->node);
 	device_unregister(ppdev);
 
 cleanup_ida:
@@ -636,7 +647,10 @@ void platform_profile_remove(struct device *dev)
 
 	pprof = to_pprof_handler(dev);
 
-	guard(mutex)(&profile_lock);
+	guard(mutex)(&profile_registration_lock);
+
+	scoped_guard(mutex, &profile_lock)
+		list_del(&pprof->node);
 
 	ida_free(&platform_profile_ida, pprof->minor);
 	device_unregister(&pprof->dev);

base-commit: d0cd1e850e1602729dd60dc3c5fd96f80e0cdc5d
