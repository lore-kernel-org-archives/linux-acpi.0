From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PM: Move ACPI video resume to a PM notifier
Date: Thu, 4 Mar 2010 20:12:36 +0100
Message-ID: <201003042012.36416.rjw@sisk.pl>
References: <201003040125.30091.rjw@sisk.pl> <b170af451003040311g3cea44caj1cd0e23e55814696@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48973 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274Ab0CDTJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2010 14:09:57 -0500
In-Reply-To: <b170af451003040311g3cea44caj1cd0e23e55814696@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Thursday 04 March 2010, Rafa=C5=82 Mi=C5=82ecki wrote:
> 2010/3/4 Rafael J. Wysocki <rjw@sisk.pl>:
> > There is a problem with the ACPI video resume routine that it's
> > executed before the GPU that may be accessed by it.  To fix this
> > issue, move the ACPI video resume to a power management notifier,
> > so that it's executed after resuming all devices, including the GPU=
=2E
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
>=20
> Tested-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>

Thanks!

> It partially fixes bugzilla bug #15096 and it first needed step to fi=
x
> it completely.

To fix that completely we'd need to avoid calling acpi_video_resume() i=
n the
non-KMS case, but it's not clear how to tell the ACPI driver which case=
 we're
in.  It's not certain how to reliably distinguish the KMS and non-KMS c=
ases at
this level in the first place.

> Can we send this to stable for .32 and .33?

That depends on Len.

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
