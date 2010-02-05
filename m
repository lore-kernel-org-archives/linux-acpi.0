From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_idle: Very idle Core i7 machine never enters C3
Date: Fri, 05 Feb 2010 12:45:21 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002051238280.4050@localhost.localdomain>
References: <20100126084740.GA5265@jgarrett.org>
 <87y6jkee1b.fsf@basil.nowhere.org> <20100205160900.GA2736@jgarrett.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:64875 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933643Ab0BERpk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Feb 2010 12:45:40 -0500
In-reply-to: <20100205160900.GA2736@jgarrett.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Garrett <jeff@jgarrett.org>
Cc: Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Jeff,
What do you see if you apply just the patch below?

Also, in addition to "powertop -d" to show what the kernel requests,
please run turbostat to show what the hardware actually did:

http://userweb.kernel.org/~lenb/acpi/utils/pmtools-latest/turbostat/turbostat.c

eg.
# turbostat -d -v sleep 5

thanks,
-Len Brown, Intel Open Source Technology Center
---

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 7c0441f..f528625 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -763,7 +763,7 @@ static const struct file_operations acpi_processor_power_fops = {
 static int acpi_idle_bm_check(void)
 {
 	u32 bm_status = 0;
-
+return bm_status;
 	acpi_read_bit_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
 	if (bm_status)
 		acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_STATUS, 1);

