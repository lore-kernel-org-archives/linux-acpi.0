From: Matthias Welwarsky <matze@welwarsky.de>
Subject: Re: [PATCH 57/98] sony-laptop: Add support for extra keyboard events
Date: Sun, 29 Mar 2009 12:53:04 +0200
Message-ID: <200903291253.05030.matze@welwarsky.de>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <9b57896e62bfa752ee7435e6cfe57fb210c0db8c.1238214619.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-22-168.clients.your-server.de ([88.198.22.168]:28269
	"EHLO basyskom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbZC2KxL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Mar 2009 06:53:11 -0400
In-Reply-To: <9b57896e62bfa752ee7435e6cfe57fb210c0db8c.1238214619.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

On Saturday 28 March 2009 05:31:32 Len Brown wrote:
> The current sony-laptop code assumes that the keyboard event method is
> always located at slot 2 in the platform code. Remove this assumption and
> add support for some additional hotkeys.

I suggest the following patch to fix a couple of bugs on Vaio Z21:
- fix S1 and S2 hotkeys reporting same key event
- fix undecoded/unknown keys reporting bogus key events

--- sony-laptop.c.orig	2009-03-29 12:41:44.000000000 +0200
+++ sony-laptop.c	2009-03-29 12:43:29.000000000 +0200
@@ -865,7 +865,7 @@
 static struct sony_nc_event sony_100_events[] = {
 	{ 0x90, SONYPI_EVENT_PKEY_P1 },
 	{ 0x10, SONYPI_EVENT_ANYBUTTON_RELEASED },
-	{ 0x91, SONYPI_EVENT_PKEY_P1 },
+	{ 0x91, SONYPI_EVENT_PKEY_P2 },
 	{ 0x11, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
 	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
@@ -929,7 +929,7 @@
 		if (sony_find_snc_handle(0x127) == ev)
 			key_handle = 0x127;
 
-		if (handle) {
+		if (key_handle) {
 			struct sony_nc_event *key_event;
 
 			if (sony_call_snc_handle(key_handle, 0x200, &result))
@@ -959,11 +959,11 @@
 		} else if (sony_find_snc_handle(0x124) == ev) {
 			sony_nc_rfkill_update();
 			return;
-		}
+		} else
+			sony_laptop_report_input_event(ev);
 	}
 
 	dprintk("sony_acpi_notify, event: 0x%.2x\n", ev);
-	sony_laptop_report_input_event(ev);
 	acpi_bus_generate_proc_event(sony_nc_acpi_device, 1, ev);
 }
 


