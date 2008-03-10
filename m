From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: *NEW* ACPI driver to support App Hot Startup AKA PNP0C32 -
	please apply
Date: Mon, 10 Mar 2008 11:23:36 +0800
Message-ID: <1205119416.10256.218.camel@acpi-hp-zz.sh.intel.com>
References: <20071110014448.471e384b.miknix@gmail.com>
	 <200711100321.22500.carlos@strangeworlds.co.uk>
	 <20071112000534.e0489eca.miknix@gmail.com>
	 <200711120002.24474.carlos@strangeworlds.co.uk>
	 <20071123152446.144ac193.miknix@gmail.com>
	 <20080119151929.1674103b.miknix@gmail.com>
	 <823A93EED437D048963A3697DB0E35DE0129BE5A@pdsmsx414.ccr.corp.intel.com>
	 <20080307112505.7281ef4b.miknix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13897 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbYCJDe0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Mar 2008 23:34:26 -0400
In-Reply-To: <20080307112505.7281ef4b.miknix@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

As there is nothing private, add linux-acpi in the discussion. :)

On Fri, 2008-03-07 at 19:25 +0800, =C3=82ngelo Miguel Arrifano wrote:
> On Fri, 7 Mar 2008 14:27:13 +0800
> "Zhang, Rui" <rui.zhang@intel.com> wrote:
>=20
> > Hi, Angelo,
> >
> > For a typical ACPI device driver, it usually works like this:
> > 1. Register the ACPI device driver is the module_init
> > 2. Enable the device, create the sys I/F in the drivers .add method=
=2E
> > 3. Remove the device I/F in .remove method.
> > 4. unregister the ACPI device driver in module_exit.
> >
> > With your patch applied, the sys I/F will be created even if no
> PNP0C32 device exists in the ACPI namespace. IMO, moving this piece o=
f
> code to the .add method will be much better.
>=20
> That's right, but the sys I/F being created are not in a per-device
> basis. I mean:
>=20
> Suppose PNP0C32 has three devices:
> ABTN
> BBTN
> CBTN
You mean three devces with _HID(PNP0C32), or three devices enumerated
under a PNP0C32 device? could you please attach the acpidump output?
> The sys files are created for PNP0C32 and not for every [ABC]BTN
> device.
>  So, moving the
> sys I/F code into .add, AFAIK, will get the sys files created several
> times which is not
> the purpose.
=2Eadd method is called for each PNP0C32 device,not for each button.
so in this case, I think it will only create two sys files...
>=20
> The sys files created are "buttons" and "pressed_button".
> "buttons" displays all devices (buttons) under PNP0C32 for, IMHO,
> easier enumeration by
> userspace; instead of having a file for each device.
> "pressed_buttons" displays the button used to turn on/resume the
> computer.
>=20
> But you are still right, the driver loads successfully (although
> displaying "none" on "buttons" sys file) when no PNP0C32 is present a=
s
> we can see on this user post which doesn't have PNP0C32 at all:
> http://sourceforge.net/forum/forum.php?thread_id=3D1959640&forum_id=3D=
754264
>=20
> On the code below, shouldn't (status < 0) be true when no PNP0C32 is
> present?
>=20
>         /* ACPI driver register */
>         status =3D acpi_bus_register_driver(&quickstart_acpi_driver);
>         if (status < 0)
>                 return -ENODEV;
>=20
> This was supposed to exit with -ENODEV before creating sys I/F.
No, acpi_bus_register_driver returns 0 if no matched device is found, i=
n
order to support device hotplug.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
