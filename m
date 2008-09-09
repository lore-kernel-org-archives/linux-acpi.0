From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 1/5] devcore introduce wakeup_event callback
Date: Tue, 9 Sep 2008 14:39:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0809091428000.2375-100000@iolanthe.rowland.org>
References: <200809090852.59461.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:43009 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753573AbYIISjh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2008 14:39:37 -0400
In-Reply-To: <200809090852.59461.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 9 Sep 2008, David Brownell wrote:

> > (As a matter of fact, I have no idea whether or not Intel's legacy =
PM=20
> > for UHCI is implemented in AML. =A0It may vary from one BIOS to ano=
ther.)
>=20
> One data point:  on the laptop used to type this message,
> the GPE code block includes stuff like this for each UHCI:
>=20
>         Method (_L0C, 0, NotSerialized)
>         {
>             Notify (\_SB.PCI0.USB3, 0x02)
>         }
>=20
> Without diving into the ICHx specs (which I believe DO have
> such details, thanks be!), my first reaction is that this is
> not a "case (c)".  Of course, the rest of the AML code is,
> as usual, cryptic (I'd rather have C code), and such stuff
> might be hidden elsewhere in the event sequence.

=46ortunately the interface is extremely simple.  It's an 8-bit registe=
r=20
in the PCI config space, where the two low-order bits enable=20
wakeup detection for each of the two ports.  It won't matter if the=20
driver and the AML both try to disable wakeup; the end result should=20
work regardless.

Anyway, the real problem here is not to enable or disable wakeup
detection.  It is to determine whether or not the device really did
issue a wakeup request.  With Intel's UHCI this involves reading an I/O
register.  On all the systems I have tried it works even in D3hot, so
we should be okay.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
