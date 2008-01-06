From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/7] Suspend: Introduce open() and close() callbacks
Date: Sun, 6 Jan 2008 14:15:46 +0100
Message-ID: <200801061415.47557.rjw@sisk.pl>
References: <200801052332.44500.rjw@sisk.pl> <200801052338.52923.rjw@sisk.pl> <200801051631.19629.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60236 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480AbYAFNNp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jan 2008 08:13:45 -0500
In-Reply-To: <200801051631.19629.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>

On Sunday, 6 of January 2008, David Brownell wrote:
> On Saturday 05 January 2008, Rafael J. Wysocki wrote:
> > + * @open: Initialise a transition to given system sleep state.
> > + *=A0=A0=A0=A0=A0@open() is executed right prior to suspending dev=
ices. =A0The information
> > + *=A0=A0=A0=A0=A0conveyed to the platform code by @open() should b=
e disregarded by it as
> > + *=A0=A0=A0=A0=A0soon as @close() is executed. =A0If @open() fails=
 (ie. returns nonzero),
> > =A0 *=A0=A0=A0=A0=A0@prepare(), @enter() and @finish() will not be =
called by the PM core.
> > =A0 *=A0=A0=A0=A0=A0This callback is optional. =A0However, if it is=
 implemented, the argument
> > =A0 *=A0=A0=A0=A0=A0passed to @enter() is meaningless and should be=
 ignored.
>                                 ^^^^^^^^^^^
> Surely this should say "redundant", not "meaningless"?  =20
>=20
>=20
> > + * @close: Called by the PM core right after resuming devices, to =
indicate to
> > + *=A0=A0=A0=A0=A0the platform that the system has returned to the =
working state.
>=20
> Or the state transition has aborted ...
>=20
> > + *=A0=A0=A0=A0=A0This callback is optional, but should be implemen=
ted by the platforms
> > + *=A0=A0=A0=A0=A0that implement @open().
>=20
> "..., but platforms which implement @open() should also provide a @cl=
ose()
> which cleans up transitions which aborted before @enter()."
>=20
> Otherwise it seems rather unclear why this exists, since all platform=
s know
> that things are "normal" as soon as enter() gets back from its transi=
tion.
> (What can I say ... I like to see things be clear!)  Yes, systems may=
 do more
> than that when it gets this call; but the minimum involves just that =
cleanup.

Thanks for the comments.  They will be taken into account in the final =
version
of the patch.

Greetings,
Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
