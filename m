From: Rene Rebe <rene@exactcode.de>
Subject: Re: 2.6.21-rc5: Thinkpad X60 gets critical thermal shutdowns
Date: Mon, 2 Apr 2007 10:35:40 +0200
Message-ID: <200704021035.40672.rene@exactcode.de>
References: <460E0158.7090705@goop.org> <8393D4C0-57C5-4CD2-8CA4-E4241E74FB4E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx01.qsc.de ([213.148.129.14]:42886 "EHLO mx01.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933281AbXDBJEQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Apr 2007 05:04:16 -0400
In-Reply-To: <8393D4C0-57C5-4CD2-8CA4-E4241E74FB4E@mac.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Sunday 01 April 2007 20:57:57 Kyle Moffett wrote:
> On Mar 31, 2007, at 02:36:08, Jeremy Fitzhardinge wrote:
> > When I run 2.6.21-rc5 + Andi's x86 patches + paravirt_ops patches, =
=20
> > I've been getting my machine shut down with critical thermal =20
> > shutdown messages:
> >
> > Mar 30 23:19:03 localhost kernel: ACPI: Critical trip point
> > Mar 30 23:19:03 localhost kernel: Critical temperature reached (128=
 =20
> > C), shutting down.
> > Mar 30 23:19:03 localhost kernel: Critical temperature reached (128=
 =20
> > C), shutting down.
> > Mar 30 23:19:03 localhost shutdown[19417]: shutting down for system=
 =20
> > halt
> >
> > and the machine does feel pretty hot.  Interestingly, when the =20
> > machine reboots, the fan spins up to a noticeably higher speed, so =
=20
> > it seems that maybe something is getting fan speed control wrong.
>=20
> Well, 128C is more than hot enough to boil water and well above the =20
> thermal tolerances of most CPUs, so I would imagine that were your =20
> CPU actually that hot it wouldn't be capable of printing the =20
> "Critical temperature reached" messages, let alone properly rebooting=
=2E

IIRC a MSI Megabook S270 (I formerly owned) BIOS notifies this
"Critical temperature reached (128C)" when the battery run empty
when the OS did no action due to battery low indications. I guess
the BIOS people thought this is a good last resort to let the OS
really shutdown before the box just turns off.

Yours,

--=20
  Ren=E9 Rebe - ExactCODE GmbH - Europe, Germany, Berlin
  http://exactcode.de | http://t2-project.org | http://rene.rebe.name
  +49 (0)30 / 255 897 45
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
