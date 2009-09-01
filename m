From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V5 0/2] Ambient Light Sensor support
Date: Mon, 31 Aug 2009 23:28:49 -0700
Message-ID: <20090901070129.F402D526EA5@mailhub.coreip.homeip.net>
References: <1251706025.3483.159.camel@rzhang-dt> <alpine.LFD.2.00.0908311303340.19451@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751989AbZIAG2y@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0908311303340.19451@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 31, 2009 at 01:04:35PM -0400, Len Brown wrote:
> I put this in the acpi test tree, with the expectation
> that it will have at least one minor revision update
> before going upstream.
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 

Breaks build here...

-- 
Dmitry

ACPI: als - fix compile errors

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

PREFIX was undefined causing compiler to barf.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/acpi/als.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/drivers/acpi/als.c b/drivers/acpi/als.c
index 6743ba7..51583a8 100644
--- a/drivers/acpi/als.c
+++ b/drivers/acpi/als.c
@@ -30,6 +30,8 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
+#define PREFIX "ACPI: "
+
 #define ACPI_ALS_CLASS			"als"
 #define ACPI_ALS_DEVICE_NAME		"Ambient Light Sensor"
 #define ACPI_ALS_NOTIFY_ILLUMINANCE	0x80
