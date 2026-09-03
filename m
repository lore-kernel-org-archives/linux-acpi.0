Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A614D2ED4;
	Thu,  3 Sep 2026 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451802; cv=none; b=sgTkhPiqD1bWXxnNlyXE8BNAHTJpq07l/791rRxjS6bY5VdpcKrg1lzvnkygf7a8LxJGKEc5gmcwcZKvwxfGgM7wS9symakMbhuQCloZTeaiiBL7hULzslPe/JbYiw8xUAJDa1OHNeMw0D2oP//seOgkh6CJUkcVq0Ak9MWvLEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451802; c=relaxed/simple;
	bh=XsPoPME6+zeGGKH+SuJrQTSPdgHH5u+5A1FWapwI7/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FF/IstGt4a2zXQd8WR5mbP5FTgqbvIsDUjUxPW6DTEIdxWDue2lIOPvM5S1Z6ajsRGNKfUZYzhf/xAAGTsuVzonw1j7KTN5sD2NRezic8aMoQUoSaBSOcVgBw2gUgJQC13srirUkvmiMMrnsE57FfxFWepEQkm63foGhYGPi9wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DalvjeNZ; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jrdWKkj0; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DalvjeNZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jrdWKkj0"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hbPgj0KFLz8v1n;
	Thu, 03 Sep 2026 18:09:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788451793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n3tQitakLlqQDYDPHdHUWoyy1Ad3Gb0VsyWcR09H3K0=;
	b=DalvjeNZsxU2PyWCP5+Z87wBy1Aa7voE01FYgLo/IP0YrD2VMB0yJWPXKBkESpFi5xgMtb
	QXjYXgeWeuouRe+zfmHKYLwW/GvxT7HyDNnpuCcyYxSG8eF6pS7f6LqAFeSPET4AKEsDEc
	IfSxAF0nu3ZsRKRTJz5+a2IEgybJmKiRfphA6Wp93oxCHgTfN01IqMWVBQC5kAKioaW7t4
	oYpWA2OZp0kF4xc+dLyZicD7TCC3gyPFW7GF1OlOQQKvmPItmdumsxI9OfbjyQqxVpv+ng
	qzlULpiaeYYJ7k5D33TvoWyZfGa4t1NcLbsy/a2CuF6EtoiThEcaWlCt+TT64A==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=jrdWKkj0;
	spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788451791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n3tQitakLlqQDYDPHdHUWoyy1Ad3Gb0VsyWcR09H3K0=;
	b=jrdWKkj0ltzIRS9srsGv3OtZbg90f3STwOAmkcHdCB6yjEW0kV/mXlKXfiDS4V+xgU7Pip
	delfT5kMoAJKg6GLYpAJHW53DOZdKpBL/Lidy/GjMW5i/Pp1rvrrPscsSVfTap+OLl7tCH
	ZGiW1XbOLaD9YhD1LW+iQqPHRUom397O+v5e/qTbowCQruf8eGEmd2Gaw0KCSUv9AtBJEB
	+MqLucQ0baMYwXSXoqk5E/+QYMr4xRTVGtoUjWTAVmFQywz4b3NeGtkycvdi8ajGuVd+F2
	QFFDnQW0x52OeIt+R/BMOl6LdD4AbpF+viqvx2y4I6sT3L1PUGMcErUam8DrHQ==
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: docs: Fix brackets
Date: Thu,  3 Sep 2026 18:08:45 +0200
Message-ID: <20260903160846.734870-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: q4irxp8iqnm98grkmd3taa43bdymty4z
X-MBO-RS-ID: 6b01038148216495900
X-Rspamd-Queue-Id: 4hbPgj0KFLz8v1n

Add missing ')' to functions.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/firmware-guide/acpi/enumeration.rst | 2 +-
 Documentation/firmware-guide/acpi/i2c-muxes.rst   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 168c43012..da7cc8528 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -374,7 +374,7 @@ For example::
 	{
 		Method (_CRS, 0, NotSerialized)
 		{
-			Name (SBUF, ResourceTemplate()
+			Name (SBUF, ResourceTemplate())
 			{
 				// Used to power on/off the device
 				GpioIo (Exclusive, PullNone, 0, 0, IoRestrictionOutputOnly,
diff --git a/Documentation/firmware-guide/acpi/i2c-muxes.rst b/Documentation/firmware-guide/acpi/i2c-muxes.rst
index 96ef4012d..d4ce90d00 100644
--- a/Documentation/firmware-guide/acpi/i2c-muxes.rst
+++ b/Documentation/firmware-guide/acpi/i2c-muxes.rst
@@ -35,7 +35,7 @@ which corresponds to the following ASL (in the scope of \_SB)::
                 Device (CLIA)
                 {
                     Name (_HID, ...)
-                    Name (_CRS, ResourceTemplate () {
+                    Name (_CRS, ResourceTemplate ()) {
                         I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
                                     AddressingMode7Bit, "\\_SB.SMB1.MUX0.CH00",
                                     0x00, ResourceConsumer,,)
-- 
2.54.0

