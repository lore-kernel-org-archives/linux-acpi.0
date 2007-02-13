From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/41] sony_acpi: Fix sony_acpi_resume call
Date: Tue, 13 Feb 2007 00:49:05 -0500
Message-ID: <1171345789246-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39577 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751034AbXBMFtv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:49:51 -0500
In-Reply-To: <11713457871537-git-send-email-lenb@kernel.org>
Message-Id: <2c06db8eba9efbb4e2d8e5bbddbb3ef84f4976b7.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Andrew Morton <akpm@osdl.org>

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sony_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index beb56b9..f323c2c 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -233,7 +233,7 @@ static int sony_acpi_write(struct file *file, const char __user *buffer,
 	return count;
 }
 
-static int sony_acpi_resume(struct acpi_device *device, int state)
+static int sony_acpi_resume(struct acpi_device *device)
 {
 	struct sony_acpi_value *item;
 
-- 
1.5.0.rc4.345.gb4d2
