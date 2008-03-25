From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation callbacks (rev. 3)
Date: Tue, 25 Mar 2008 12:55:30 +0100
Message-ID: <200803251255.31482.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0803241519090.24400-100000@iolanthe.rowland.org> <200803242318.21052.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:54152 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbYCYLyy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2008 07:54:54 -0400
In-Reply-To: <200803242318.21052.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Am Montag 24 M=E4rz 2008 schrieb Rafael J. Wysocki:
> -/*
> +/**
> + * struct pm_ops - device PM callbacks
> + *
> =A0 * Several driver power state transitions are externally visible, =
affecting
> =A0 * the state of pending I/O queues and (for drivers that touch har=
dware)
> =A0 * interrupts, wakeups, DMA, and other hardware state. =A0There ma=
y also be
> @@ -122,6 +124,254 @@ typedef struct pm_message {
> =A0 * to the rest of the driver stack (such as a driver that's ON gat=
ing off
> =A0 * clocks which are not in active use).
> =A0 *
> + * The externally visible transitions are handled with the help of t=
he following
> + * callbacks included in this structure:
> + *
> + * @prepare: Prepare the device for the upcoming transition, but do =
NOT change
> + *=A0=A0=A0=A0=A0its hardware state. =A0Prevent new children of the =
device from being
> + *=A0=A0=A0=A0=A0registered and prevent new calls to the probe metho=
d from being made

How is a driver supposed to prevent calls to probe()? You can block in =
probe()
or you can fail it, but how do you prevent it from being called? User s=
pace
can trigger probe via sysfs. To be useful to driver writers, this has
to be clarified.

> + *=A0=A0=A0=A0=A0after @prepare() returns. =A0If @prepare() detects =
a situation it cannot
> + *=A0=A0=A0=A0=A0handle (e.g. registration of a child already in pro=
gress), it may return
> + *=A0=A0=A0=A0=A0-EAGAIN, so that the PM core can execute it once ag=
ain (e.g. after the
> + *=A0=A0=A0=A0=A0new child has been registered) to recover from the =
race condition. This
> + *=A0=A0=A0=A0=A0method is executed for all kinds of suspend transit=
ions and is followed
> + *=A0=A0=A0=A0=A0by one of the suspend callbacks: @suspend(), @freez=
e(), or @poweroff().

This could be understood so that disconnect() cannot be called.

> + *=A0=A0=A0=A0=A0The PM core executes @prepare() for all devices bef=
ore starting to
> + *=A0=A0=A0=A0=A0execute suspend callbacks for any of them, so drive=
rs may assume all of
> + *=A0=A0=A0=A0=A0the other devices to be present and functional whil=
e @prepare() is being
> + *=A0=A0=A0=A0=A0executed. =A0However, they may NOT assume anything =
about the availability
> + *=A0=A0=A0=A0=A0of the user space at that time.

Probably it should be mentioned that this is the time to allocate memor=
y
if you have to. And it is too late to request firmware.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
