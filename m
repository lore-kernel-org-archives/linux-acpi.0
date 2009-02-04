From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] ACPI: add missing KERN_* constants to printks
Date: Wed, 4 Feb 2009 17:48:24 +0100 (CET)
Message-ID: <alpine.LRH.2.00.0902041747451.7690@vixen.sonytel.be>
References: <4989A784.3030604@suse.de> <200902041628.03675.elendil@planet.nl> <alpine.LRH.2.00.0902041642450.7690@vixen.sonytel.be> <200902041713.00301.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vervifontaine.sonytel.be ([80.88.33.193]:59630 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751513AbZBDQs0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2009 11:48:26 -0500
In-Reply-To: <200902041713.00301.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Frank Seidel <fseidel@suse.de>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, len.brown@intel.com, shaohuhua.li@intel.com, kristen.c.accardi@intel.com, frank@f-seidel.de

On Wed, 4 Feb 2009, Frans Pop wrote:
> On Wednesday 04 February 2009, Geert Uytterhoeven wrote:
> > > This patch looks broken to me, at least for some of your changes.
> > > For example, in the bit quoted above all printks together make up
> > > *one single* message, which means that only the _first_ of the
> > > printks should have the KERN_* prefix. printks that are continuat=
ions
> > > should not have the prefix.
> >
> > Actually they should, but the right prefix :-)
>=20
> Hmm. I was going by memory and from what I've seen in existing code, =
but
> also found this (somewhat old) post:
> https://lists.linux-foundation.org/pipermail/kernel-janitors/2005-Oct=
ober/014375.html

That one predates KERN_CONT.

> > Quoting include/linux/kernel.h:
> > | /*
> > |  * Annotation for a "continued" line of log printout (only done a=
fter a
> > |  * line that had no enclosing \n). Only to be used by core/arch c=
ode
> > |  * during early bootup (a continued line is not SMP-safe otherwis=
e).
> > |  */
> > | #define KERN_CONT       ""
> >
> > Please also consider the note about SMP-safeness.
>=20
> From that it looks like KERN_CONT should only be used in a very limit=
ed
> context, but I guess this example qualifies.

Yep, the general advise is to avoid using continuations.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Bel=
gium

Phone:    +32 (0)2 700 8453
=46ax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
=46ortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
