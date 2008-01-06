From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH 1/7] Suspend: Introduce open() and close() callbacks
Date: Sat, 5 Jan 2008 16:31:18 -0800
Message-ID: <200801051631.19629.david-b@pacbell.net>
References: <200801052332.44500.rjw@sisk.pl> <200801052338.52923.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:34602 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753925AbYAFAbW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jan 2008 19:31:22 -0500
In-Reply-To: <200801052338.52923.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>

On Saturday 05 January 2008, Rafael J. Wysocki wrote:
> + * @open: Initialise a transition to given system sleep state.
> + *=A0=A0=A0=A0=A0@open() is executed right prior to suspending devic=
es. =A0The information
> + *=A0=A0=A0=A0=A0conveyed to the platform code by @open() should be =
disregarded by it as
> + *=A0=A0=A0=A0=A0soon as @close() is executed. =A0If @open() fails (=
ie. returns nonzero),
> =A0 *=A0=A0=A0=A0=A0@prepare(), @enter() and @finish() will not be ca=
lled by the PM core.
> =A0 *=A0=A0=A0=A0=A0This callback is optional. =A0However, if it is i=
mplemented, the argument
> =A0 *=A0=A0=A0=A0=A0passed to @enter() is meaningless and should be i=
gnored.
                                ^^^^^^^^^^^
Surely this should say "redundant", not "meaningless"?  =20


> + * @close: Called by the PM core right after resuming devices, to in=
dicate to
> + *=A0=A0=A0=A0=A0the platform that the system has returned to the wo=
rking state.

Or the state transition has aborted ...

> + *=A0=A0=A0=A0=A0This callback is optional, but should be implemente=
d by the platforms
> + *=A0=A0=A0=A0=A0that implement @open().

"..., but platforms which implement @open() should also provide a @clos=
e()
which cleans up transitions which aborted before @enter()."

Otherwise it seems rather unclear why this exists, since all platforms =
know
that things are "normal" as soon as enter() gets back from its transiti=
on.
(What can I say ... I like to see things be clear!)  Yes, systems may d=
o more
than that when it gets this call; but the minimum involves just that cl=
eanup.

- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
