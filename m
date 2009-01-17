From: Frans Pop <elendil@planet.nl>
Subject: [PATCH] hp-wmi: fix regressions caused by missing if statement
Date: Sat, 17 Jan 2009 01:55:01 +0100
Message-ID: <200901170155.02757.elendil@planet.nl>
References: <200901170013.55786.elendil@planet.nl> <200901170131.22541.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml16.KPNXCHANGE.COM ([213.75.38.116]:2726 "EHLO
	hpsmtp-eml16.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751549AbZAQAzF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Jan 2009 19:55:05 -0500
In-Reply-To: <200901170131.22541.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

From: Frans Pop <elendil@planet.nl>

hp-wmi: fix regressions caused by missing if statement
    
Error was introduced in commit fe8e4e039dc3.
    
Signed-off-by: Frans Pop <elendil@planet.nl>
---
> On Saturday 17 January 2009, Frans Pop wrote:
> > When I first booted .29-rc2 my HP 2510p notebook hung while loading
> > hp-wmi, which I have listed in /etc/modules. Hard poweroff was
> > needed.

And this obvious patch fixes the regression (tested).

Andrew: I've added you as the broken patch also went via you.

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 7c789f0..6260420 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -441,6 +441,7 @@ static int __init hp_wmi_bios_setup(struct 
platform_device *device)
 		bluetooth_rfkill->toggle_radio = hp_wmi_bluetooth_set;
 		bluetooth_rfkill->user_claim_unsupported = 1;
 		err = rfkill_register(bluetooth_rfkill);
+		if (err)
 			goto register_bluetooth_error;
 	}
 
