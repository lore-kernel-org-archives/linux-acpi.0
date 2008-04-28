From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup() policy inputs
Date: Mon, 28 Apr 2008 15:26:47 -0700
Message-ID: <200804281526.48217.david-b@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net> <200804261237.26499.david-b@pacbell.net> <1209386885.884.9.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:23013 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965847AbYD1W0v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Apr 2008 18:26:51 -0400
In-Reply-To: <1209386885.884.9.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Thomas Renninger <trenn@suse.de>

[ grr, mousepad sent an incomplete message for me ... ]

On Monday 28 April 2008, Zhao Yakui wrote:
>=20
> > > But after the patch is applied, some PCI device(the ACPI device w=
ith the
> > > _PRW object) can wake the sleeping system by default. And it is t=
otally
> > > opposite to the current flowchart.=20
> >=20
> > That's not true. =A0Behavior could only change for devices with
> > drivers which already call pci_enable_wake()!
>=20
> Yes. But in fact a lot of PCI device will call pci_enable_wake when t=
he
> system enters the suspend state. And the behaviour will be changed.

I'm not sure what your point is.  That "behavior change" is a bugfix.
The previous behavior was specific to ACPI, and obviously was not what
the driver writer expected.

And it's *NOT* how things work on non-ACPI systems which have both PCI
and functional system suspend/resume.  (Various PowerPC, MIPS, and ARM
systems meet those requirements, as I understand.)

I sympathize with the desire to avoid driver-related surprises.  In
this case, it's trivial to disable that behavior using sysfs.  And I
believe you'll observe that not many drivers could actually turn up
surprises here:  who calls pci_enable_wake()?

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
