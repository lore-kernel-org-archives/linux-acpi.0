Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253949F137
	for <linux-acpi@vger.kernel.org>; Sat,  3 Oct 2026 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791045639; cv=none; b=e/WRr6zI3SYxJZ5RezYePjs/pSD096ghgL1O3gSrY+T9jDjXrXaWn2JlEU2O0TLmmdos7GXHh3NAZ/ItCqFd+RhrRfwvI6hPTFwoVqTOd0tPGPaHqiSn1L7XtygcGVJvMhU/Xi7f4Lhy2b6BjZ+gYrmebkFkAWT0p8JRy/XLPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791045639; c=relaxed/simple;
	bh=XCtwfy+HsyCBzUEJZQGsfEPf1/p+pFFaeKMa/muG3zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A8CjMiF+C19SAvK3ZM/pac8PB48Kzye/IEgkRRe83EWzGKgS7dHqrLxTA5O2awRIasfRoXeIoj6xtzoH9+9lW7X2/iW4lUQSFjaKgAnO/l/39gOSC6TE4u3Hd9uSISsEEa7qN2I5vbEvFGyrhRX9nCb85tL8XQoxU2+7/Kpr6fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZGysHo+; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZGysHo+"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33fb4680717so966043eec.1
        for <linux-acpi@vger.kernel.org>; Sat, 03 Oct 2026 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791045636; x=1791650436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T1SycGCsAYEA1OfPrGG/qg1fDqfdjLPEyIDB48vQpa8=;
        b=LZGysHo+pajBaNfnXd3MFHIJcpVszuZHaiCkXV9OnKtKnyqBpF6ajRuc5IEZFuTElE
         BtAxS47pSCNoTaCffXqBDHtRFM67d5S9Ek23XaDMaA3WnX9X7kml7/aucylb0+c59sD3
         EuKE9Nkllo7UsnIoYrVKIGqX+acQRvDquVCPlyHNmBnz1A7bpTJBN1RAdHIOIwwMnmH0
         DBxVnbjemVS6yXls0H+N9NHCw6BZzc4uiAQxHS7qV2yk0uj71PVgk62r/4VIQj3/Lg3J
         8Fyb9a2WtwO1Ynz5VMlVXmBigswClUIeifkI2m0NNiSXXVmcIoJmWjvJ32Bq06Xdi5av
         KaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791045636; x=1791650436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T1SycGCsAYEA1OfPrGG/qg1fDqfdjLPEyIDB48vQpa8=;
        b=kHFemwMKZMbQqTyEN20uAdrQkaqSnnSY5kj2tkJAqrrJe/XPsQK3QGNdfX2ejUbwUk
         L4g+tO/tcBW52AvWVpqMrnGjHGDomzYTsEi1oKCsJBeGcU+fT49vQpBBon4+h3O2XAf3
         qJbsH08nt2RrcKY1izKp80ujyoG6RoZJ1s5jywuQXuxb1yYBxnVe0ncbD4qjZJcc4IAc
         UWjQvItb7+UomDXRcvWAStPggAAe8nF4UxWwXCsy48mbrrgk8iyk+n5dTbErKwlrxFyI
         xJiKPlj9PZde7CcX6lqVLIKyo6PXNVJb8N3JmYxj7YBkWMNhKrpEqsVeTRx/Fe3AHei5
         RTVA==
X-Forwarded-Encrypted: i=1; AKwUvBzZNVp3HabGL9LNr7YNFwRQBLRY1ANkqY0B+SvKG8bJXUSgbnkXbdS72SuPDhBQhyX6YTNI+QdaAYCf@vger.kernel.org
X-Gm-Message-State: AFuF++nhJBH9TAVSTrh4RzqqkYPSVdxI3jxfBQ8EA1PVo1LuHq5/ocQd
	XTsl/kjF1ZUTw4AVqo34RCf5Rvf5Sd0tQjOrpqR1opDDLQnGWS5qWtVo8ib0q2kyLIz4jg==
X-Gm-Gg: AYBFou0UZTgD4QZ/uH3CkzHTYbJZZS3e7drqdgFnYXlXVo7nnDK2mQVq584GOdfSurz
	gaohs2OVeEuZuvWjMTCOV45J+EIwtb5DKhGyjqNIgRez7VB2r4sEPOg5S8no6mCkQtm/fUHqonz
	1w7vD1/G/EiIxalmYwOjuquMjn11zqbtbfDPiYDm3Ar2zejyxIdyXLdIed3awsT40wG2/F8wxhI
	Q0kQmOhSeGx+Xf6tWapHZD4pPSyX9R7nV+A3H0toGEPWs7P3ReR83YuGue8cqcdr7Hg23/y3RTm
	JGWU5kVVD7KDF9U/Vs904XkiEDQsPJbF4DozS0QhkC/3TDXb8HTXS/DzP43FezA/CNIyIswcOtS
	kBiFd7kOKsp3LZ/2q+fGUCq0uj5qEpiPLYniZXmjoQkwFsXPu7p6UrpR5mPT0utIOHhaou+cX18
	oDbp8Y5S0V0C8jIP6E/RJwJEMI8J1ytkAp6kcAah1cMXzAq4Mwxy3E4q/UdxZCfOQPrKMQRVHcP
	j3TCovN
X-Received: by 2002:a05:701b:4253:10b0:148:306c:971 with SMTP id a92af1059eb24-151c3aa07dbmr4520821c88.22.1791045636270;
        Sat, 03 Oct 2026 09:40:36 -0700 (PDT)
Received: from Vibhor-ThinkPad ([2401:4900:8833:f3a7:6702:207d:bfc:f0f6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fa751693sm18483744c88.2.2026.10.03.09.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 09:40:35 -0700 (PDT)
From: Vibhor Goel <vibhor1102@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: dock: Retry probing battery docks after hotplug
Date: Sat,  3 Oct 2026 22:10:19 +0530
Message-ID: <20261003164019.11195-1-vibhor1102@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a ThinkPad T480 booted with the removable battery absent, reinserting
that battery can leave BAT1 missing from /sys/class/power_supply even
after firmware sends an ACPI add notification.

The battery dock platform device already exists, but its driver did not
bind while the battery was absent. During hotplug, acpi_bus_scan()
updates the ACPI device and attempts to attach it on the ACPI bus.
acpi_create_platform_device() does not create another platform device
because the existing physical node is still associated with the ACPI
device. Consequently, the existing platform device remains unbound.

Retry probing the battery dock platform device after hotplug_dock_devices()
has refreshed the ACPI state. Restrict this to battery docks. If the
platform device is already bound, device_initial_probe() leaves that
binding in place.

Signed-off-by: Vibhor Goel <vibhor1102@gmail.com>
---
Tested on a dual-battery ThinkPad T480 with an aftermarket external pack.

On Fedora 7.2.8-200.fc44.x86_64, tracing showed the firmware add
notification, a successful ACPI rescan, and no attachment attempt for the
existing dock.0 platform device. A subsequent manual bind registered BAT1.

On patched upstream v7.2.8, booting with BAT1 absent and then triggering a
firmware add notification automatically called device_initial_probe(),
bound acpi-battery and registered BAT1. UPower detected the battery too.
Removal and reinsertion after binding also worked, without a second driver
probe. Both captures completed without trace-buffer loss.

Physical reinsertion initially produced no add notification on this pack;
toggling charger mains while leaving the battery untouched triggered one.
This patch addresses Linux handling after that notification. The initial
notification behavior is outside its scope.

The baseline and patched kernels differ in configuration and Fedora
patches. The traces identify the missing attachment operation and show the
new call resolving it; this was not a same-source unpatched comparison.

Built the kernel and all 221 configured modules, booted with Secure Boot
enabled, and tested on the physical laptop. The patch was developed with
AI assistance and reviewed and tested by me.

 drivers/acpi/dock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index d7f3a8912..748df19d9 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -445,6 +445,14 @@ int dock_notify(struct acpi_device *adev, u32 event)
 				break;
 			}
 			hotplug_dock_devices(ds, event);
+			/*
+			 * The dock platform device already exists when an empty battery
+			 * bay becomes occupied, but its driver may not have bound while
+			 * the battery was absent.  Retry after the ACPI scan updates its
+			 * status, since the scan only attaches the ACPI device.
+			 */
+			if (ds->flags & DOCK_IS_BAT)
+				device_initial_probe(&ds->dock_device->dev);
 			complete_dock(ds);
 			dock_event(ds, event, DOCK_EVENT);
 			acpi_evaluate_lck(ds->handle, 1);
-- 
2.55.0

