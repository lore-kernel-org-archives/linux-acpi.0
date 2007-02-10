From: Holger Macht <hmacht@suse.de>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.21
Date: Sat, 10 Feb 2007 13:07:13 +0100
Message-ID: <20070210120713.GA31473@homac2>
References: <200702071418.51058.lenb@kernel.org> <200702101027.25372.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:51505 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933366AbXBJMHD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Feb 2007 07:07:03 -0500
Content-Disposition: inline
In-Reply-To: <200702101027.25372.ismail@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>
Cc: Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, tony.luck@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Accardi, Kristen" <kristen.c.accardi@intel.com>

On Sat 10. Feb - 10:27:14, Ismail D=F6nmez wrote:
> On Wednesday 07 February 2007 21:18:50 Len Brown wrote:
> > Hi Linus,
> >
> > please pull from:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.g=
it
> > release
> >
> > ACPICA Core version 2070126 simplifies the ACPI table manager
> > code by consolidating multiple table definitions into one.
> > It also saves memory by mapping the tables where the BIOS provides =
them
> > rather than copying them into the kernel.
>=20
> This breaks kpowersave, now it always says laptop is plugged in and d=
oes not=20
> show any battery status. Any /proc changes in this release?

kpowersave just reflects what HAL thinks, and HAL reflects what the ker=
nel
thinks. So please post the content of /proc/acpi/ac_adapter/AC/state wh=
en
AC is not plugged in to figure out if it's just a userland bug or a ker=
nel
issue.

Regards,
	Holger
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
