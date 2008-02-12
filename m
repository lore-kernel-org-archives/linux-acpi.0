From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] acer-wmi - Fail gracefully if ACPI is disabled
Date: Mon, 11 Feb 2008 20:41:42 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802112038360.2920@woody.linux-foundation.org>
References: <200802080145.16774.lenb@kernel.org> <20080211091743.GA16459@elte.hu> <200802111923.31736.carlos@strangeworlds.co.uk> <200802111955.04562.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42173 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750732AbYBLEmP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Feb 2008 23:42:15 -0500
In-Reply-To: <200802111955.04562.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org



On Mon, 11 Feb 2008, Carlos Corbacho wrote:
> 
> WMI drivers, like their ACPI counterparts, should also check if ACPI is
> disabled or not, and bail out if so, otherwise we cause a crash.

Shouldn't "wmi_has_guid()" just return false if ACPI isn't enabled, and 
the drivers should just then always give up?

The proper way to get there would seem to be to just do this instead..

We should *not* add some random ACPI workarounds to individual drivers, we 
should just make the wmi subsystem so robust that nobody *cares* if acpi 
exists or is enabled on that machine.

		Linus

---
 drivers/acpi/wmi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index 36b84ab..457ed3d 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -673,11 +673,11 @@ static int __init acpi_wmi_init(void)
 {
 	acpi_status result;
 
+	INIT_LIST_HEAD(&wmi_blocks.list);
+
 	if (acpi_disabled)
 		return -ENODEV;
 
-	INIT_LIST_HEAD(&wmi_blocks.list);
-
 	result = acpi_bus_register_driver(&acpi_wmi_driver);
 
 	if (result < 0) {
