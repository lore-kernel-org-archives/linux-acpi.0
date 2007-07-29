From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] Introduce CONFIG_SUSPEND
Date: Sun, 29 Jul 2007 23:36:54 +0200
Message-ID: <200707292336.55588.rjw@sisk.pl>
References: <200707251238.50218.lenb@kernel.org> <200707292317.21419.rjw@sisk.pl> <20070729211824.GL16817@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49444 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935598AbXG2V2A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jul 2007 17:28:00 -0400
In-Reply-To: <20070729211824.GL16817@stusta.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <lenb@kernel.org>, david@lang.hm, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Nigel Cunningham <nigel@nigel.suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>

On Sunday, 29 July 2007 23:18, Adrian Bunk wrote:
> On Sun, Jul 29, 2007 at 11:17:20PM +0200, Rafael J. Wysocki wrote:
> > On Sunday, 29 July 2007 22:40, Adrian Bunk wrote:
> > > On Sun, Jul 29, 2007 at 02:38:05PM +0200, Rafael J. Wysocki wrote=
:
> > > >...
> > > > +config SUSPEND
> > > > +	bool "Suspend"
> > > =C2=A0            "Suspend to RAM"
> >=20
> > Not only.  This also includes "standby".
>=20
> Whatever it includes - please tell it to the user in the prompt.
>=20
> Technical issues are important, but it's often forgotten how many=20
> problems people run into because the description of a kconfig option=20
> could have been better.

Sure.  Please see the updated patch I've just sent. :-)

Greetings,
Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
