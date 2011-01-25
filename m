From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to iomaps management
Date: Tue, 25 Jan 2011 17:43:22 +0800 (SGT)
Message-ID: <Pine.LNX.4.64.1101251740380.3737@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:61827 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab1AYJn3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jan 2011 04:43:29 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org


On Tue, Jan 25, 2011 at 5:37 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, January 24, 2011, Henrique de Moraes Holschuh wrote:
> It turns out there's a bug in intel_idle causing people a lot of pain 
> with CPU hotplugging.  Should be fixed now it the Linus' tree.

Uh, I see the git fix now. Thanks. The workaround I did was to manually 
offline all CPUs before suspend and that fixed it too.

As for the thinkpad-acpi, here a little patch to disable all hotkeys so 
that Fn-F4 works natively to suspend-to-memory when 
CONFIG_THINKPAD_ACPI_HOTKEY_POLL is not set.

Thanks,
Jeff

--- lx/drivers/platform/x86/thinkpad_acpi.c.org	2011-01-22 21:48:05.000000000 +0800
+++ lx/drivers/platform/x86/thinkpad_acpi.c	2011-01-22 21:55:14.000000000 +0800
@@ -8776,10 +8776,12 @@
  	{
  		.data = &thinkpad_acpi_driver_data,
  	},
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
  	{
  		.init = hotkey_init,
  		.data = &hotkey_driver_data,
  	},
+#endif
  	{
  		.init = bluetooth_init,


