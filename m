From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH 4/5] drivers/acpi: elide a non-zero test on a result
	that is never 0
Date: Tue, 25 Mar 2008 16:30:18 +0800
Message-ID: <1206433818.3047.50.camel@acpi-hp-zz.sh.intel.com>
References: <Pine.LNX.4.64.0803241909420.32740@ask.diku.dk>
	 <1206431411.3047.45.camel@acpi-hp-zz.sh.intel.com>
	 <Pine.LNX.4.64.0803250931440.22289@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55312 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbYCYIpA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Mar 2008 04:45:00 -0400
In-Reply-To: <Pine.LNX.4.64.0803250931440.22289@ask.diku.dk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi, Julia,

On Tue, 2008-03-25 at 16:35 +0800, Julia Lawall wrote:
> On Tue, 25 Mar 2008, Zhang, Rui wrote:
> 
> >
> > On Tue, 2008-03-25 at 02:10 +0800, Julia Lawall wrote:
> > > From: Julia Lawall <julia@diku.dk>
> > >
> > > The function thermal_cooling_device_register always returns either
> a
> > > valid
> > > pointer or a value made with ERR_PTR, so a test for non-zero on
> the
> > > result
> > > will always succeed.
> > >
> > > The problem was found using the following semantic match.
> > > (http://www.emn.fr/x-info/coccinelle/)
> > > //<smpl>
> > > @a@
> > > expression E, E1;
> > > statement S,S1;
> > > position p;
> > > @@
> > >
> > > E = thermal_cooling_device_register(...)
> > > ... when != E = E1
> > > if@p (E) S else S1
> > >
> > > @n@
> > > position a.p;
> > > expression E,E1;
> > > statement S,S1;
> > > @@
> > >
> > > E = NULL
> > > ... when != E = E1
> > > if@p (E) S else S1
> > >
> > > @depends on !n@
> > > expression E;
> > > statement S,S1;
> > > position a.p;
> > > @@
> > >
> > > * if@p (E)
> > >   S else S1
> > > //</smpl>
> > >
> > > Signed-off-by: Julia Lawall <julia@diku.dk>
> > Patch looks correct. Thanks, Julia.
> > But it misses the same problem in driver/misc/intel_menlow.c.
> 
> I did that one in a separate patch ([PATCH 5/5]), since it is in a
> different directory.
That's great. thanks.

> Your patch is certainly more concise, but perhaps it is a little
> strange
> to put an "else" on an if where the "then" branch ends with a return
> or
> goto?  That doesn't seem to be done very often anyway.

> 
> > And the return value of thermal_zone_device_register is also
> misused.
I guess you didn't fix this one, right?
Len, please apply this patch.:)


Check the return value of thermal zone device registration correctly.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -1125,7 +1125,7 @@ static int acpi_thermal_register_thermal
 			tz->trips.active[i].flags.valid; i++, trips++);
 	tz->thermal_zone = thermal_zone_device_register("ACPI thermal zone",
 					trips, tz, &acpi_thermal_zone_ops);
-	if (!tz->thermal_zone)
+	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
 	result = sysfs_create_link(&tz->device->dev.kobj,


