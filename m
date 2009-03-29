From: Matthias Welwarsky <matze@welwarsky.de>
Subject: Re: [PATCH 57/98] sony-laptop: Add support for extra keyboard events
Date: Sun, 29 Mar 2009 18:38:14 +0200
Message-ID: <200903291838.14723.matze@welwarsky.de>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <200903291751.45455.matze@welwarsky.de> <20090329160212.GA9129@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-22-168.clients.your-server.de ([88.198.22.168]:14289
	"EHLO basyskom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757805AbZC2Qi0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Mar 2009 12:38:26 -0400
In-Reply-To: <20090329160212.GA9129@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

On Sunday 29 March 2009 18:02:12 Matthew Garrett wrote:
> On Sun, Mar 29, 2009 at 05:51:45PM +0200, Matthias Welwarsky wrote:
> > before the call to acpi_bus_generate_proc_event(). It was called
> > unconditionally, with whatever value ev happened to have at that time,
> > i.e. also unprocessed events < 0x90 or events where the translation
> > failed. Moving the call makes sure that only properly processed events
> > are reported. Without, I was seeing a lot of bogus events reported, e.g.
> > volume-down when the stamina switch was flipped, or when the rf kill
> > switch was operated.
>
> Oh, I see. No, you can't just remove it from there - that'll break
> older-style events. I'd add it there without removing the original, but
> then make the rest of the block conditional on the original event not
> being >= 0x90.

Whoops, just noticed that there was a bug in my patch. No wonder it confused 
you.  Should untranslated events >= 0x90 still generate ACPI events? In that 
case, the following patch would fix it. If not, the acpi event reporting must 
be moved into the else path, too.

--- sony-laptop.c.orig	2009-03-29 12:41:44.000000000 +0200
+++ sony-laptop.c	2009-03-29 18:36:31.000000000 +0200
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
@@ -955,15 +955,16 @@
 				printk(KERN_INFO DRV_PFX
 				       "Unknown event: 0x%x 0x%x\n", key_handle,
 				       ev);
-			}
+			} else
+				sony_laptop_report_input_event(ev);
 		} else if (sony_find_snc_handle(0x124) == ev) {
 			sony_nc_rfkill_update();
 			return;
 		}
-	}
+	} else
+		sony_laptop_report_input_event(ev);
 
 	dprintk("sony_acpi_notify, event: 0x%.2x\n", ev);
-	sony_laptop_report_input_event(ev);
 	acpi_bus_generate_proc_event(sony_nc_acpi_device, 1, ev);
 }
 

