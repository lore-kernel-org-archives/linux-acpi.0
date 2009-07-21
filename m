From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: mmotm 2009-07-16-14-32 - sudden OOPS at boot in ACPI code
Date: Tue, 21 Jul 2009 11:27:02 +0800
Message-ID: <1248146822.1852.32.camel@minggr.sh.intel.com>
References: <200907162134.n6GLY2kt019816@imap1.linux-foundation.org>
	 <9078.1248144738@turing-police.cc.vt.edu>
	 <d3f22a0907202021o525c98ebg4ef3f0d5d1c3016@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:8102 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754655AbZGUD06 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Jul 2009 23:26:58 -0400
In-Reply-To: <d3f22a0907202021o525c98ebg4ef3f0d5d1c3016@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@linux-foundation.org>, Bob Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>


> From:  <Valdis.Kletnieks@vt.edu>
> Date: Tue, Jul 21, 2009 at 10:52 AM
> Subject: mmotm 2009-07-16-14-32 - sudden OOPS at boot in ACPI code
> To: Andrew Morton <akpm@linux-foundation.org>, Bob Moore
> <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
> Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
> 
> 
> On Thu, 16 Jul 2009 14:34:02 PDT, akpm@linux-foundation.org said:
> > The mm-of-the-moment snapshot 2009-07-16-14-32 has been uploaded to
> 
> Dies a horrid death during early boot. Dell Latitude D820, and this graphics:
> 
> 01:00.0 VGA compatible controller: nVidia Corporation G72M [Quadro NVS
> 110M/GeForce Go 7300] (rev a1)
> 
> Traceback (hand-copied from a very crappy cell-phone picture)
> 
> strcmp+0x4/0x1f
> acpi_device+probe+0xac/0x13e
> driver_probe_device+0xc9/0x14e
> __driver_attach+0x58/0x7c
> ? __driver_attach+0x58/0x7c
> ? __driver_attach+0x58/0x7c
> bus_for_each_dev+0x54/0x89
> driver_attach+0x19/0x1b
> bus_add_driver+0xv4/0x1fe
> driver_register+0xb7/0x128
> ? acpi_video_init+0x0/0x17
> acpi_bus_register_driver+0x3e/0x42
> acpi_video_register+0x42/0x6e
> acpi_video_init+0x15/0x17
> do_one_initcall+0x56/0x130
> 
> Analysis shows it's the following code from (inlined)
> acpi_device_install_notify_handler
> 
> static int acpi_device_install_notify_handler(struct acpi_device *device)
> {
>        acpi_status status;
>        char *hid;
> 
>        hid = acpi_device_hid(device);
>        if (!strcmp(hid, ACPI_BUTTON_HID_POWERF))
> 
> but we never check if hid is non-trash before feeding it to strcmp.  Looks
> like something in this linux-next commit is involved:
> 
> commit ed444824932d2a563858d82ec1ea29b0aa775e91
> Author: Bob Moore <robert.moore@intel.com>
> Date:   Mon Jun 29 13:39:29 2009 +0800
> 
> I suspect something in acpi_get_object_info() is going astray, causing
> acpi_device_set_id() to set the ->pnp.hardware_id to NULL in this code:
> 
>        if (hid) {
>                device->pnp.hardware_id = ACPI_ALLOCATE_ZEROED(strlen (hid) + 1);
>                if (device->pnp.hardware_id) {
>                        strcpy(device->pnp.hardware_id, hid);
>                        device->flags.hardware_id = 1;
>                }
>        } else
>                device->pnp.hardware_id = NULL;
> 
> The else clause is new in this commit.

Hi, would you please try below patch?

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 6e83a68..6c64366 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -188,8 +188,8 @@ struct acpi_device_pnp {
 
 #define acpi_device_bid(d)	((d)->pnp.bus_id)
 #define acpi_device_adr(d)	((d)->pnp.bus_address)
-#define acpi_device_hid(d)	((d)->pnp.hardware_id)
-#define acpi_device_uid(d)	((d)->pnp.unique_id)
+#define acpi_device_hid(d)	((d)->pnp.hardware_id ? (d)->pnp.hardware_id : "\0")
+#define acpi_device_uid(d)	((d)->pnp.unique_id ? (d)->pnp.unique_id : "\0")
 #define acpi_device_name(d)	((d)->pnp.device_name)
 #define acpi_device_class(d)	((d)->pnp.device_class)
 

Thanks,
Lin Ming

