From: Darren Salt <ds@youmustbejoking.demon.co.uk>
Subject: [PATCH 2.6.29-rc4] Restore ACPI reporting via /proc/acpi/events for EeePC & other Asus laptops.
Date: Tue, 10 Feb 2009 14:54:56 +0000
Message-ID: <5030E5F170%ds@youmustbejoking.demon.co.uk>
References: <alpine.LFD.2.00.0902081251090.3048@localhost.localdomain>
 <gemini.ket9w800w44dc0hvg.linux@youmustbejoking.demon.co.uk>
 <20090209234911.GB862@elte.hu> <5030E21460%linux@youmustbejoking.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:50973 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754104AbZBJPB2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Feb 2009 10:01:28 -0500
In-Reply-To: <5030E21460%linux@youmustbejoking.demon.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-f>

The descriptions for the following two commits
  2a7dc0d8c60325e9bf820900bf919430e5a419ab (asus-laptop)
  2b25c9f01aa58d48129b2f93748dfb5d1f7ab0a2 (eeepc-laptop)
say that events should ALSO be exported via netlink, but the effect is that
they are INSTEAD exported via netlink. The latter commit breaks use of acpid
on my EeePC 901.

Signed-off-by: Darren Salt <linux@youmustbejoking.demon.co.uk>

diff --git a/drivers/platform/x86/asus-laptop.c
b/drivers/platform/x86/asus-laptop.c
index 56af6cf..42ecf6a 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -832,6 +832,8 @@ static void asus_hotk_notify(acpi_handle handle, u32
event, void *data)
 		lcd_blank(FB_BLANK_POWERDOWN);
 	}
 
+	acpi_bus_generate_proc_event(ehotk->device, event,
+				     ehotk->event_count[event % 128]);
 	acpi_bus_generate_netlink_event(hotk->device->pnp.device_class,
 					dev_name(&hotk->device->dev), event,
 					hotk->event_count[event % 128]++);
diff --git a/drivers/platform/x86/eeepc-laptop.c
b/drivers/platform/x86/eeepc-laptop.c
index 786ed86..8511891 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -561,6 +561,8 @@ static void eeepc_hotk_notify(acpi_handle handle, u32
event, void *data)
 		return;
 	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX)
 		notify_brn();
+	acpi_bus_generate_proc_event(ehotk->device, event,
+				     ehotk->event_count[event % 128]);
 	acpi_bus_generate_netlink_event(ehotk->device->pnp.device_class,
 					dev_name(&ehotk->device->dev), event,
 					ehotk->event_count[event % 128]++);

-- 
| Darren Salt    | d @ youmustbejoking,demon,co,uk | nr. Ashington, | Toon
| RISC OS, Linux | s   zap,tartarus,org            | Northumberland | Army
| + Use more efficient products. Use less.          BE MORE ENERGY EFFICIENT.

Never drink from your finger bowl; it contains only water.
