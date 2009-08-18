From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 7/7] PM: Asynchronous suspend and resume of i8042
Date: Wed, 19 Aug 2009 01:40:26 +0200
Message-ID: <200908190140.26730.rjw@sisk.pl>
References: <200908122218.13975.rjw@sisk.pl> <1250579010.5351.69.camel@rzhang-dt> <200908182157.53283.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56365 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbZHRXjr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Aug 2009 19:39:47 -0400
In-Reply-To: <200908182157.53283.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@linux.intel.com>, Greg KH <gregkh@suse.de>

On Tuesday 18 August 2009, Rafael J. Wysocki wrote:
> On Tuesday 18 August 2009, Zhang Rui wrote:
> > On Mon, 2009-08-17 at 08:21 +0800, Rafael J. Wysocki wrote:
> > > Set async_suspend for i8042.
> > >=20
> > it's the psmouse reset that takes the 0.4 seconds during suspend.
> > =EF=BB=BFso we should call device_enable_async_suspend for the psmo=
use serio
> > device in psmouse-base.c
> >=20
> > Or invoking device_enable_async_suspend for every serio device in
> > serio.c, as the keyboard also takes about 0.2s to suspend.
>=20
> Yes we can do that.  I'll test that later today.

The appended patch appears to work on my test box.

Thanks,
Rafael

---
Set async_suspend for serio input devices.

---
 drivers/input/serio/serio.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/input/serio/serio.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/input/serio/serio.c
+++ linux-2.6/drivers/input/serio/serio.c
@@ -576,6 +576,7 @@ static void serio_add_port(struct serio=20
 			printk(KERN_ERR
 				"serio: sysfs_create_group() failed for %s (%s), error: %d\n",
 				serio->phys, serio->name, error);
+		device_enable_async_suspend(&serio->dev, true);
 	}
 }
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
