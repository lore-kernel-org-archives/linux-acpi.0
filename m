From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Mon, 23 Mar 2009 21:48:22 +0000
Message-ID: <20090323214822.GA32460@srcf.ucam.org>
References: <20090320011837.GA23183@gamma.logic.tuwien.ac.at> <200903211222.36642.matze@welwarsky.de> <200903211453.49039.matze@welwarsky.de> <20090322175609.GA10304@srcf.ucam.org> <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at> <20090322203740.GA12285@srcf.ucam.org> <20090322220655.GA13887@gamma.logic.tuwien.ac.at> <20090322224652.GA13814@srcf.ucam.org> <20090322231029.GC17905@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37015 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbZCWVs3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 17:48:29 -0400
Content-Disposition: inline
In-Reply-To: <20090322231029.GC17905@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Norbert Preining <preining@logic.at>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Mon, Mar 23, 2009 at 08:10:30AM +0900, Mattia Dongili wrote:

> Yes it does.
> A vaio SR user sent me this list for 0x9c that after a call to SN07(202)
> becomes:

After looking at this, I think we actually want to be calling SN07(20C) 
on these machines - they implement an 0x127 function in the C function 
slot which also calls GECR. I suspect that this corresponds to the 
larger number of programmable buttons, so should be added to another 
table. Something like the following - some amount of tidying up 
required. That would avoid needing to add a multilevel setup.

Interestingly, the recent SRs also appear to implement the 0x124 rfill 
method, but at SN07(4) rather than SN07(3). This leaves me pretty happy 
that I've got the right idea about how this all works now :)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 2d142d3..5d95af8 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -850,6 +850,25 @@ struct sony_nc_event {
 	u8	event;
 };
 
+static struct sony_nc_event sony_127_events[] = {
+	{ 0x81, SONYPI_EVENT_MODEKEY_PRESSED },
+	{ 0x01, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x82, SONYPI_EVENT_PKEY_P1 },
+	{ 0x02, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x83, SONYPI_EVENT_PKEY_P2 },
+	{ 0x03, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x84, SONYPI_EVENT_PKEY_P3 },
+	{ 0x04, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x85, SONYPI_EVENT_PKEY_P4 },
+	{ 0x05, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x86, SONYPI_EVENT_PKEY_P5 },
+	{ 0x06, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x06, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x87, SONYPI_EVENT_SETTINGKEY_PRESSED },
+	{ 0x07, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0, 0 },
+}
+
 static struct sony_nc_event sony_nc_events[] = {
 	{ 0x90, SONYPI_EVENT_PKEY_P1 },
 	{ 0x10, SONYPI_EVENT_ANYBUTTON_RELEASED },
@@ -908,6 +927,24 @@ static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 		} else if (sony_find_snc_handle(0x124) == ev) {
 			sony_nc_rfkill_update();
 			return;
+		} else 	if (sony_find_snc_handle(0x127) == ev) {
+			int i;
+
+			if (sony_call_snc_handle(0x127, 0x200, &result))
+				dprintk("sony_acpi_notify, unable to decode event 0x%.2x\n", ev);
+			else
+				ev = result & 0xFF;
+
+			for (i=0; sony_127_events[i].event; i++) {
+				if (sony_127_events[i].data == ev) {
+					ev = sony_127_events[i].event;
+					break;
+				}
+			}
+
+			if (!sony_127_events[i].data)
+				printk(KERN_INFO DRV_PFX
+				       "Unknown event: %x %x\n", origev, ev);
 		}
 	}
 


-- 
Matthew Garrett | mjg59@srcf.ucam.org
