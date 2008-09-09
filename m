From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 3/5] pci wakeup handler
Date: Mon, 8 Sep 2008 19:56:47 -0700
Message-ID: <200809081956.48036.david-b@pacbell.net>
References: <20080908091926.785882370@sli10-desk.sh.intel.com> <200809081509.52070.rjw@sisk.pl> <76780B19A496DC4B80439008DAD7076C01AC7F30F3@PDSMSX501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:28753 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752712AbYIIDDv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Sep 2008 23:03:51 -0400
In-Reply-To: <76780B19A496DC4B80439008DAD7076C01AC7F30F3@PDSMSX501.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Monday 08 September 2008, Li, Shaohua wrote:
> > =A0 =A0 =A0 =A0if (drv && drv->pm && drv->pm->base.wakeup_event) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int dev_ret =3D drv->pm->base.wakeup=
_event(&pdev->dev);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D dev_ret;
> > =A0 =A0 =A0 =A0}
> >
> > Also, why do you think we should ignore the returned value if ret i=
s zero?
>=20
> Because we already identified the device which invokes PME.

Well, we *may* have identified *one* of them.  If the device
supports the PCI PM standards, we did.  If it uses legacy PM
(like Intel's UHCI controllers), that's not guaranteed ...


> Even the .wakeup_event() returns an error, we should populate
> It's this device which has wakeup event.

You haven't exactly defined the semantics of the return value,
or what a caller would do with it. =20


> In my mind, driver isn't=20
> required to provide .wakeup_event() unless device has non-standard
> regs for wakeup event or some special to handle. Generic PME handling
> should be fine for most devices (for PCI devices).     =20

I don't follow this then.  You're saying it will suffice to
just clear the PCI PM status, and the driver is expected to
work fine without even being notified about its wake event??

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
