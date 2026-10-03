Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254373815E6
	for <linux-acpi@vger.kernel.org>; Sat,  3 Oct 2026 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791066561; cv=none; b=ews3qDFGZAtKvTxruuEx+6rKFrhStAqsYr5XDLXiVK+zy8dyl2F6Im0+sKvwC7/Th4hyeY5iRpPUj/nMNFxozhBC4kdxJg+JOWC7uG+aQDahOjWLKrhNLySPFz/SQYpPPHCWGvcFDWLfOnr/GHL1Mk6LPknRg8U/JQbfb7VmKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791066561; c=relaxed/simple;
	bh=poqId5qHz6ksF9unZawVCMAK8JVyHldDpw2wkuxUWqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NyHULo5b3rQEBnd6BhyVfzpAv/JjKvjNsSV7O4dyGCNBf4P93mE89NwHAmMo4JagOM2lf69m51TA68YeZEK4TrNNNA3MWI8/lfb0oVoWQjSxsgBBFn0xa4wBwsFX3U0Z+971450LzhghZs73UNOJNSuCzV8FF/FSUBlqP05XVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVoC6klj; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVoC6klj"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939ca12ab70so58581885a.1
        for <linux-acpi@vger.kernel.org>; Sat, 03 Oct 2026 15:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791066559; x=1791671359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z6BWckxqNOzx6GZ/iwpqxlB6xcNOWQfGZLizbnT6FFM=;
        b=SVoC6kljKYrjZ8SjwPl6LM8tYXPAmNN+qEE0N3eHX7BR0ePfoDw65x7V6X2wsYkaoi
         Vi1gRnioWJuH9DSdU4utuZ6aYJznI+CKHIFZZ41euuShjw//hSLSf/DCIQoRIHkBo5ZL
         ZtqbfMRUxQBuDtvkG2s0orKwgZvzg+i35WI8o3IsruWzf9d5z9YiBZRA65JK4upwZ23+
         pWCAG93vurycm8sH1EE4dq5OPYBLLr/2q3KuAmiO7tQZSruwO460wkPolUVj7+R8/kSK
         1IJ64J2jlXvBPXXMtQed8RR1sOWr4W2+DrDCZq8wow8Ae6VCHW5iNep0kkxAq65dsfMP
         0JIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791066559; x=1791671359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z6BWckxqNOzx6GZ/iwpqxlB6xcNOWQfGZLizbnT6FFM=;
        b=KujS3+8wHhPumqyXYoYrXSgHLiehjDKyH0UpOihgy01PvTVCaK8yI4EzpZ5+1JWXOq
         z8otxHkTxcAIN10xTfxiVYoYo3jYx/Hf3Eka1o7MubhTEPW5L3Ly1KV2obHdq0HYlBKJ
         7lWszsyCrlXw1t1LvlkqdV4e0lfTaQPqsa7jsWvTpBzc43yIvb0Ej9IXKqAeNbe4pSJO
         0Bt41IEYZbLGWBZ1FMKSbnL2m956D+X41kslDX4uJxLq05/KrB806nz3qyJyejvNr6kT
         IcNTbXkcZ1mHCfm0YhgsAiJdzsXKKVKpgGGmEFPcC/Ay9NLhderd7ZuNQdE9lGxQsLQr
         qKKA==
X-Forwarded-Encrypted: i=1; AKwUvBzU/7QxdukOI65HpxjVV6RbLhSBka3tAQZb85X/LSMyfGVG/B+bSNWRP2shGyt/f74NIraxYswVYnIu@vger.kernel.org
X-Gm-Message-State: AFuF++kXky5ley6jzj/SjLn2qa63uFyDMjy/PkanMhTe3pw1sRWIR9UU
	6/XN1FayneET2XPlcZ/TI5h2kuxkZOtW3Ro27cb9taXfRIfmFoKC583R
X-Gm-Gg: AYBFou1JularvbZlVscZ1UHqDwajxb3UvWoWA146Js7pGdkqQj3bj2RBn2IwnReEfeS
	mJIY/O9NTf916pZKD1x6Vzas27Ooh+0dYNeUjzWmDVNEz1nJCp4WAT1o/ZQyu5IGeT9cwIxwIsZ
	pZwlyvXaUV+wId2YLRyCoxV4OfibzmHfd0p3LUH7nMWwX9jyN6OXKBzgO5NO2cT6MWW6E2rM+tI
	jTWS/KlAOuaWgA41QAZVipSWWKmwSxFt0xcFVpiqORmhwC4IBuy1a9v8C9aNKuUVOsKooHcSb12
	+icRDnVzVl9XzBAGwGVIP+qh8+99BfNzfl1NkS/Z6DXmytLdXAHx0yZORUkbVyvZCvEmSChlYAv
	T5426ztmMIMJWLk2UYW3K2QMtiTNvsn2scj8sgh7wfWzCh7gXNZaoJC6eTNZgXqAge2PyrCrWHD
	/jqJwHoeCOg0qeYOUiFeurTDybYOCELFnb4uEh0Yd3eQXeURwnRTazTmnKCLGsLjC1V+4aCkV3r
	KNZPo6XejE8EBdBoANxSNQe81CO+CAgQNoa8+wjVrj63TvRhPnpe0GsFYvz6cQv7Us/N+PWkrOi
	LcK/iJ4NTe5Bqw==
X-Received: by 2002:a05:620a:1a03:b0:93e:4594:f5bb with SMTP id af79cd13be357-93e4595079dmr1022393185a.59.1791066558815;
        Sat, 03 Oct 2026 15:29:18 -0700 (PDT)
Received: from pointbeachlab-yoga.lan (ool-457df6e1.dyn.optonline.net. [69.125.246.225])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca297e84sm539341985a.37.2026.10.03.15.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 15:29:17 -0700 (PDT)
From: James Fairweather <james.a.fairweather@gmail.com>
To: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: James Fairweather <james.a.fairweather@gmail.com>,
	chrome-platform@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_usbpd_notify: Only use parent drvdata when parent is GOOG0004
Date: Sat,  3 Oct 2026 18:28:53 -0400
Message-ID: <20261003222855.23707-1-james.a.fairweather@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cros_usbpd_notify_probe_acpi() takes the EC device pointer from
dev_get_drvdata(dev->parent) and assumes it is a struct cros_ec_device.
That only holds when GOOG0003 is a child of GOOG0004. On older devices
without that hierarchy, such as Google Nami, GOOG0003 and GOOG0004 are
siblings under the ACPI EC (PNP0C09):

  PNP0C09:00 (acpi-ec)
  |-- GOOG0003:00 (cros-usbpd-notify-acpi)
  `-- GOOG0004:00 (cros_ec_lpcs)

Before commit db65a06d10b3 ("ACPI: EC: Convert the driver to a platform
one") the parent platform device had no driver data, so the driver
warned and continued without an EC pointer, as intended for these
devices. Since that commit the ACPI EC driver stores its struct acpi_ec
there, so the driver treats a struct acpi_ec as a struct cros_ec_device
and calls cros_ec_cmd() on it for every USB-C PD host event. Plugging
or unplugging a charger then intermittently oopses, followed by soft
lockups and a hung system:

  BUG: unable to handle page fault for address: ffffffff9cf03220
  #PF: supervisor write access in kernel mode
  Hardware name: Google Nami/Nami, BIOS  09/19/2019
  Workqueue: kacpi_notify acpi_os_execute_deferred
  RIP: 0010:native_queued_spin_lock_slowpath+0x29d/0x330
  Call Trace:
   _raw_spin_lock_irqsave+0x59/0x80
   __mutex_lock.constprop.0+0x129/0x930
   cros_ec_cmd_xfer+0x2a/0xf0 [cros_ec_proto]
   cros_ec_cmd_xfer_status+0x1a/0x90 [cros_ec_proto]
   cros_ec_cmd+0xb7/0x140 [cros_ec_proto]
   cros_usbpd_get_event_and_notify+0x42/0xc0 [cros_usbpd_notify]
   acpi_ev_notify_dispatch+0x4e/0x70
   acpi_os_execute_deferred+0x1a/0x30

Only read the parent's driver data when the parent's ACPI node is
GOOG0004, and otherwise continue without an EC pointer. While at it,
drop the reference taken by fwnode_get_parent().

Fixes: db65a06d10b3 ("ACPI: EC: Convert the driver to a platform one")
Cc: stable@vger.kernel.org
Assisted-by: claude-opus-5-5 checkpatch
Signed-off-by: James Fairweather <james.a.fairweather@gmail.com>
---
Tested on a Google Nami-based Chromebook (BIOS 09/19/2019)
running a 7.2.5 distro kernel (linux-omarchy 7.2.5-3). The unpatched
driver oopsed twice in two days, each time on a charger plug/unplug.
With this patch built as a module against that kernel, the probe logs
"Couldn't get Chrome EC device pointer." (confirming GOOG0003's parent
is not GOOG0004 here), and 12 charger unplug/replug cycles produced no
oops, with charging negotiating 20V/3.5A as before.

Not done: I have not boot-tested a full chrome-platform for-next kernel;
the change was built and run as an out-of-tree module on 7.2.5, where
this function is identical apart from a comment typo fix. Only Nami
hardware was tested. Because the original crash is intermittent, the
clean run shows the fix doesn't regress charging rather than proving
the absence of the crash; the main evidence is the probe warning above
plus the oops register state (the qspinlock tail encodes CPU 74 on an
8-CPU machine, i.e. a non-lock word was being treated as a lock).

AI assistance: the crash was diagnosed and the patch and changelog were
written with Claude Opus 5.5 (Claude Code), from the journal oops traces,
the sysfs device hierarchy and the driver source. I reviewed the change
and ran the test above.

 drivers/platform/chrome/cros_usbpd_notify.c | 39 +++++++++++----------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 6f5eea493..25da31ec1 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -110,26 +110,29 @@ static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
 	if (!pdnotify)
 		return -ENOMEM;
 
-	/* Get the EC device pointer needed to talk to the EC. */
-	ec_dev = dev_get_drvdata(dev->parent);
-	if (!ec_dev) {
-		/*
-		 * We continue even for older devices which don't have the
-		 * correct device hierarchy, namely, GOOG0003 is a child
-		 * of GOOG0004. If GOOG0003 is a child of GOOG0004 and we
-		 * can't get a pointer to the Chrome EC device, defer the
-		 * probe function.
-		 */
-		parent_fwnode = fwnode_get_parent(dev->fwnode);
-		if (parent_fwnode) {
-			parent_adev = to_acpi_device_node(parent_fwnode);
-			if (parent_adev &&
-			    acpi_dev_hid_match(parent_adev, CREC_DRV_NAME)) {
-				return -EPROBE_DEFER;
-			}
+	/*
+	 * Get the EC device pointer needed to talk to the EC. The parent's
+	 * driver data is only a struct cros_ec_device when GOOG0003 is a
+	 * child of GOOG0004. On older devices without that hierarchy the
+	 * parent may be bound to an unrelated driver (e.g. the ACPI EC
+	 * driver for PNP0C09), so don't touch its driver data and continue
+	 * without an EC pointer. If GOOG0003 is a child of GOOG0004 and we
+	 * can't get a pointer to the Chrome EC device yet, defer the probe.
+	 */
+	ec_dev = NULL;
+	parent_fwnode = fwnode_get_parent(dev->fwnode);
+	parent_adev = to_acpi_device_node(parent_fwnode);
+	if (parent_adev && acpi_dev_hid_match(parent_adev, CREC_DRV_NAME)) {
+		ec_dev = dev_get_drvdata(dev->parent);
+		if (!ec_dev) {
+			fwnode_handle_put(parent_fwnode);
+			return -EPROBE_DEFER;
 		}
-		dev_warn(dev, "Couldn't get Chrome EC device pointer.\n");
 	}
+	fwnode_handle_put(parent_fwnode);
+
+	if (!ec_dev)
+		dev_warn(dev, "Couldn't get Chrome EC device pointer.\n");
 
 	pdnotify->dev = dev;
 	pdnotify->ec = ec_dev;
-- 
2.55.0

