From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: WARNING: CPU: 0 PID: 2623 at drivers/pnp/pnpacpi/core.c:96 pnpacpi_set_resource
Date: Wed, 30 Jul 2014 00:39:35 +0200
Message-ID: <8487820.GRUnuPqyXT@vostro.rjw.lan>
References: <5386F2C7.8080400@redhat.com> <2026468.U7VDB8Dm9m@vostro.rjw.lan> <CAHTgTXXejANtoEeeUB59DTy1kU3ROYoOsNi-fLu==PAr6Kh+-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHTgTXXejANtoEeeUB59DTy1kU3ROYoOsNi-fLu==PAr6Kh+-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinson Lee <vlee@twopensource.com>
Cc: William Dauchy <wdauchy@gmail.com>, Zdenek Kabelac <zkabelac@redhat.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, July 29, 2014 02:52:32 PM Vinson Lee wrote:
> On Tue, Jul 29, 2014 at 2:10 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, July 29, 2014 11:13:55 AM Vinson Lee wrote:
> >> On Tue, Jul 29, 2014 at 2:53 AM, William Dauchy <wdauchy@gmail.com> wrote:
> >> > Hi Vinson,
> >> >
> >> > On Mon, Jul 28, 2014 at 9:11 PM, Vinson Lee <vlee@twopensource.com> wrote:
> >> >> The warning first happens with 3.14-rc1. The warning does not occur with 3.13.0.
> >> >
> >> > Hitting the same issue here with a similar trace on 3.14.x. Did you
> >> > start bisecting?
> >> >
> >> > Regards,
> >> > --
> >> > William
> >>
> >>
> >> I bisected the warning that I'm seeing to this commit.
> >>
> >> commit 202317a573b20d77a9abb7c16a3fd5b40cef3d9d
> >> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Date:   Fri Nov 22 21:54:37 2013 +0100
> >>
> >>     ACPI / scan: Add acpi_device objects for all device nodes in the namespace
> >
> > Interesting.
> >
> > Does the appended patch make any difference?
> >
> > Rafael
> >

[cut]

> 
> 
> Yes, with the patch on top of 3.16-rc7 I do not see the warning.

Great, thanks for testing!

The patch goes again below with a proper changelog.

William, it would be good if you could test it too as I'd like to
push it for 3.16.

Rafael

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / PNP: Fix acpi_pnp_match()

The acpi_pnp_match() function is used for finding the ACPI device
object that should be associated with the given PNP device.
Unfortunately, the check used by that function is not strict enough
and may cause success to be returned for a wrong ACPI device object.

To fix that, use the observation that the pointer to the ACPI
device object in question is already stored in the data field
in struct pnp_dev, so acpi_pnp_match() can simply use that
field to do its job.

This problem was uncovered in 3.14 by commit 202317a573b2 (ACPI / scan:
Add acpi_device objects for all device nodes in the namespace).

Fixes: 202317a573b2 (ACPI / scan: Add acpi_device objects for all device nodes in the namespace)
Reported-and-tested-by: Vinson Lee <vlee@twopensource.com>
Cc: 3.14+ <stable@vger.kernel.org> # 3.14+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pnp/pnpacpi/core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-pm/drivers/pnp/pnpacpi/core.c
===================================================================
--- linux-pm.orig/drivers/pnp/pnpacpi/core.c
+++ linux-pm/drivers/pnp/pnpacpi/core.c
@@ -319,8 +319,7 @@ static int __init acpi_pnp_match(struct
 	struct pnp_dev *pnp = _pnp;
 
 	/* true means it matched */
-	return !acpi->physical_node_count
-	    && compare_pnp_id(pnp->id, acpi_device_hid(acpi));
+	return pnp->data == acpi;
 }
 
 static struct acpi_device * __init acpi_pnp_find_companion(struct device *dev)
