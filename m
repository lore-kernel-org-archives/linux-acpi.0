From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 09/16] platform/x86: wmi: Instantiate all devices before
 adding them
Date: Mon, 5 Jun 2017 20:03:02 -0700
Message-ID: <20170606030302.GC27270@fury>
References: <cover.1495862272.git.dvhart@infradead.org>
 <a25645295f6aaf80407ff851baa14ec039c885aa.1495862272.git.dvhart@infradead.org>
 <20170601204339.GA1842@kmp-mobile.hq.kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170601204339.GA1842@kmp-mobile.hq.kempniu.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 01, 2017 at 10:43:39PM +0200, Michał Kępień wrote:
> I know I have probably started sounding like a broken record by now, but
> I still have not seen any response (apart from the typos getting fixed)
> to my comments on this patch which I posted in January 2016 [1].
> 
> None of the issues I found back then are really critical, but I did
> point out a potential memory leak (granted, an unlikely one), so it
> might be a good idea to at least take a second look before merging.
> 
> [1] https://www.spinics.net/lists/platform-driver-x86/msg08201.html

Thanks for being persistent, some good points in there. I'd like to just squash
these into this patch (9/16), but I'll include them here for an ack from you and
Andy L. that this is what you meant, and consistent with his
intent/understanding:


>From 2512da1593574a66eb48d7105885e959b38db410 Mon Sep 17 00:00:00 2001
Message-Id: <2512da1593574a66eb48d7105885e959b38db410.1496717988.git.dvhart@infradead.org>
From: "Darren Hart (VMware)" <dvhart@infradead.org>
Date: Mon, 5 Jun 2017 19:54:03 -0700
Subject: [PATCH] =?UTF-8?q?platform/x86:=20wmi:=20Apply=20fixes=20per=20Mi?=
 =?UTF-8?q?cha=C5=82=20K=C4=99pie=C5=84=20(squash)?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Per:
https://www.spinics.net/lists/platform-driver-x86/msg08201.html

Eliminate the kfree of a wblock with a null bus now that we ignore
duplicate GUIDs in parse_wdg.

Move the out_free_pointer: label and kfree to the end of the function,
clearly marking it as a return path.

Rework the device_add loop at the end of parse_wdg to avoid leaking the
wblock, and symmetrically call wmi_method_enable() if (debug_event).

Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
 drivers/platform/x86/wmi.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index bfc0a3f..fbce876 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -863,14 +863,7 @@ static void wmi_free_devices(struct acpi_device *device)
 	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
 		if (wblock->acpi_device == device) {
 			list_del(&wblock->list);
-			if (wblock->dev.dev.bus) {
-				/* Device was initialized. */
-				device_del(&wblock->dev.dev);
-				put_device(&wblock->dev.dev);
-			} else {
-				/* device_initialize was not called. */
-				kfree(wblock);
-			}
+			device_unregister(&wblock->dev.dev);
 		}
 	}
 }
@@ -903,9 +896,9 @@ static bool guid_already_parsed(struct acpi_device *device,
 static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 {
 	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
-	union acpi_object *obj;
 	const struct guid_block *gblock;
 	struct wmi_block *wblock, *next;
+	union acpi_object *obj;
 	acpi_status status;
 	int retval = 0;
 	u32 i, total;
@@ -958,24 +951,27 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		}
 	}
 
-out_free_pointer:
-	kfree(out.pointer);
-
 	/*
 	 * Now that all of the devices are created, add them to the
 	 * device tree and probe subdrivers.
 	 */
 	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
-		if (wblock->acpi_device == device) {
-			if (device_add(&wblock->dev.dev) != 0) {
-				dev_err(wmi_bus_dev,
-					"failed to register %pULL\n",
-					wblock->gblock.guid);
-				list_del(&wblock->list);
-			}
+		if (wblock->acpi_device != device)
+			continue;
+
+		retval = device_add(&wblock->dev.dev);
+		if (retval) {
+			dev_err(wmi_bus_dev, "failed to register %pULL\n",
+				wblock->gblock.guid);
+			if (debug_event)
+				wmi_method_enable(wblock, 0);
+			list_del(&wblock->list);
+			put_device(&wblock->dev.dev);
 		}
 	}
 
+out_free_pointer:
+	kfree(out.pointer);
 	return retval;
 }
 
-- 
2.9.4


-- 
Darren Hart
VMware Open Source Technology Center
