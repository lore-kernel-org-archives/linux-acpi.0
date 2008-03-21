From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc6 1/7] crosslink ACPI and "real" device nodes
Date: Fri, 21 Mar 2008 02:04:15 -0700
Message-ID: <200803210204.15843.david-b@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net> <200803210031.35174.david-b@pacbell.net> <1206088471.4109.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:38233 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752007AbYCUJES (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Mar 2008 05:04:18 -0400
In-Reply-To: <1206088471.4109.56.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-pm@lists.linux-foundation.org, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org

On Friday 21 March 2008, Zhao Yakui wrote:
> On Fri, 2008-03-21 at 00:31 -0700, David Brownell wrote:
> > > > The PNP device gets a "firmware_node" link pointing to the ACPI=
 device.
> > > > The ACPI device has a "physical_node" link pointing to the PNP =
device.
> > > > Linux drivers currently bind only to the "physical" device node=
s.
> > > =20
> > > Very good idea.=20
> > > But maybe there is a lot of ACPI devices on the laptops. And we t=
ake a
> > > little care about the association between the acpi device and "re=
al"
> > > device.
> >=20
> > Are you suggesting that the ACPI nodes shouldn't exist at all?
> > Or that something is wrong with how they're set up or used?
>=20
> No. The ACPI nodes should exist. What I said is whether it is necessa=
ry
> to create the link for all the ACPI devices between the ACPI device a=
nd
> "real" node device.  Of course it is also OK if link is created for t=
he
> ACPI device with the ability to wake the sleeping system.=20

The confusion exists for all ACPI device nodes that
mirror "real" device nodes (like PNP or PCI devices).

It's *not* limited to wake-capable devices.


> > For now, there's some confusion. =A0Devices listed in ACPI tables
> > have one or two extra sysfs device nodes. =A0I think *something*
> > should help sort out the confusion ...

(Minor correction:  *most* devices listed in ACPI tables have
the problem of extra sysfs nodes.  A few don't; like buttons.)


> Sorry. What I means is that the link(point to the ACPI device with th=
e
> ability to wake the sleeping system) is created in the /sys/power/.=20
> After doing so, we can easily check which device has the ability to w=
ake
> the sleeping system.=20

There's no need for symlinks to do that ... or ACPI.

I've been meaning to repost my script that scans sysfs
for the wakeup-capable devices ... I updated it a short
while ago to work right without "legacy" sysfs nodes.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
