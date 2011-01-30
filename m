From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [RFC] merge 32/64 bits realmode wakeup code
Date: Sun, 30 Jan 2011 20:57:24 +0100
Message-ID: <20110130205724.2c3f7541@mat-laptop>
References: <4D41EA12.1030402@free.fr>
	<201101272354.00042.rjw@sisk.pl>
	<4D447C00.70709@free.fr>
	<201101292215.57292.rjw@sisk.pl>
	<4D44AE75.6020803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:41548 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186Ab1A3T5f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 30 Jan 2011 14:57:35 -0500
In-Reply-To: <4D44AE75.6020803@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org

Le Sat, 29 Jan 2011 16:19:01 -0800,
"H. Peter Anvin" <hpa@zytor.com> a =E9crit :

> On 01/29/2011 01:15 PM, Rafael J. Wysocki wrote:
> >
> > That's correct, but those changes can wait.  The most urgent thing
> > is to fix the resume regression at hand.  I guess we should ask the
> > reporter's in https://bugzilla.kernel.org/show_bug.cgi?id=3D27472 t=
o
> > test that patch, right?
> >
>=20
> By the way, guys: I'm on vacation at the moment, but I do monitor
> this thread.  I think at this point we should revert NX for the low 1
> MiB and worry about doing it properly for .39.

So #9 patch in https://bugzilla.kernel.org/show_bug.cgi?id=3D27472 is
okay, do you want some cleanup ?


Matthieu
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
