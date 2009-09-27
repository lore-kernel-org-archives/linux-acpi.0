From: Ingo Molnar <mingo@elte.hu>
Subject: [origin tree build failure] [PATCH] thinkpad-acpi: Fix build on
	!CONFIG_THINKPAD_ACPI_HOTKEY_POLL
Date: Sun, 27 Sep 2009 09:52:54 +0200
Message-ID: <20090927075254.GA20847@elte.hu>
References: <200909260519.n8Q5JrB6016778@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:60893 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369AbZI0Hxb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Sep 2009 03:53:31 -0400
Content-Disposition: inline
In-Reply-To: <200909260519.n8Q5JrB6016778@hera.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@hera.kernel.org>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


>  drivers/platform/x86/thinkpad_acpi.c    |  632 +++++++++++++++++++---------

-tip testing found that these changes caused a build failure 
in drivers/platform/x86/thinkpad_acpi.c when 
!CONFIG_THINKPAD_ACPI_HOTKEY_POLL - the fix is attached 
below.

Thanks,

	Ingo

------------------------->
>From 7f6443f7238a0aa9014b11a0a31ab76825d75cdf Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@elte.hu>
Date: Sun, 27 Sep 2009 09:47:46 +0200
Subject: [PATCH] thinkpad-acpi: Fix build on !CONFIG_THINKPAD_ACPI_HOTKEY_POLL

This build error:

  drivers/platform/x86/thinkpad_acpi.c: In function 'tpacpi_hotkey_driver_mask_set':
  drivers/platform/x86/thinkpad_acpi.c:2238: error: lvalue required as left operand of assignment

Triggers because in the !CONFIG_THINKPAD_ACPI_HOTKEY_POLL case
tpacpi_hotkey_driver_mask_set ymbol is defined to a constant
literal - which is not an lvalue so cannot be assigned to.

The whole tpacpi_hotkey_driver_mask_set() function is not used
in the !CONFIG_THINKPAD_ACPI_HOTKEY_POLL, so enclose it with
an #ifdef.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/platform/x86/thinkpad_acpi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 3910f2f..a52dbc9 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2216,6 +2216,7 @@ static int hotkey_user_mask_set(const u32 mask)
 	return rc;
 }
 
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 /*
  * Sets the driver hotkey mask.
  *
@@ -2244,6 +2245,7 @@ static int tpacpi_hotkey_driver_mask_set(const u32 mask)
 
 	return rc;
 }
+#endif
 
 static int hotkey_status_get(int *status)
 {
