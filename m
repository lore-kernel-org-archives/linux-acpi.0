From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 22:04:36 +0200
Message-ID: <200706212204.36999.rjw@sisk.pl>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com> <200706211442.41140.rjw@sisk.pl> <200706210748.48781.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53775 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755916AbXFUT5w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jun 2007 15:57:52 -0400
In-Reply-To: <200706210748.48781.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>

On Thursday, 21 June 2007 16:48, David Brownell wrote:
> On Thursday 21 June 2007, Rafael J. Wysocki wrote:
> > The issue at hand is that some device drivers may need to know what=
 the
> > target sleep state of the system will be when their .suspend() rout=
ines are
> > being executed. =A0Currently, there's no means of passing that info=
rmation to the
> > drivers and my question is how to do this.
>=20
> Actually what they need to know is some *attribute* of that state.

Generally, yes.

> They really don't care what the state is.  The $SUBJECT patch isn't
> driver code ... it's for platform hooks that expose attributes to
> the drivers.  Specifically, it's ACPI code, talking to drivers that
> must run on non-ACPI systems.  Any driver that thinks it needs to
> understand anything about ACPI states is sadly broken.

But finally it has to place the device into a specific state and that s=
tate
needs to be determined somehow.  And, if ACPI is involved, it needs to =
be
told at one point if the final system state is supposed to be S1 or S2 =
or S3
(I guess we can discard S2 safely) just to tell the driver which power =
states
of the device are suitable.

That's why I thought we might introduce an additional global pm_op that
could be used to provide ACPI with that information without engaging dr=
ivers in
passing it.

> Remember also that the Linux "states" (in /sys/power/state) are an
> inadequate representation of what most hardware can do.

Do we really want to introduce more system sleep states right at this p=
oint?

> Common hardware can support a lot more low power sleep modes than the=
 two
> states Linux currently defines ... a limitation inherited from first =
APM, and
> them more recently ACPI, which doesn't fit embedded systems well at a=
ll.

I agree with that, but right now we have an ACPI-related problem at han=
d.

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
