From: Ismail =?iso-8859-1?q?D=F6nmez?= <ismail@pardus.org.tr>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.21
Date: Sat, 10 Feb 2007 18:59:17 +0200
Message-ID: <200702101859.18879.ismail@pardus.org.tr>
References: <200702071418.51058.lenb@kernel.org> <20070210120713.GA31473@homac2> <200702101752.14797.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:55832 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751246AbXBJQ7Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Feb 2007 11:59:24 -0500
In-Reply-To: <200702101752.14797.ismail@pardus.org.tr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Holger Macht <hmacht@suse.de>
Cc: Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, tony.luck@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Accardi, Kristen" <kristen.c.accardi@intel.com>

On Saturday 10 February 2007 17:52:13 Ismail D=F6nmez wrote:
> On Saturday 10 February 2007 14:07:13 Holger Macht wrote:
> > On Sat 10. Feb - 10:27:14, Ismail D=F6nmez wrote:
> > > On Wednesday 07 February 2007 21:18:50 Len Brown wrote:
> > > > Hi Linus,
> > > >
> > > > please pull from:
> > > >
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2=
=2E6.git
> > > > release
> > > >
> > > > ACPICA Core version 2070126 simplifies the ACPI table manager
> > > > code by consolidating multiple table definitions into one.
> > > > It also saves memory by mapping the tables where the BIOS provi=
des
> > > > them rather than copying them into the kernel.
> > >
> > > This breaks kpowersave, now it always says laptop is plugged in a=
nd
> > > does not show any battery status. Any /proc changes in this relea=
se?
> >
> > kpowersave just reflects what HAL thinks, and HAL reflects what the
> > kernel thinks. So please post the content of
> > /proc/acpi/ac_adapter/AC/state when AC is not plugged in to figure =
out if
> > it's just a userland bug or a kernel issue.
>
> [~]> cat /proc/acpi/ac_adapter/ADP1/state
> state:                   off-line
>
>
> Hmmf looks like a userspace bug, but it certainly did work before ACP=
I
> update.

Hmm whats this ADP1 and there is no /proc/acpi/ac_adapter/AC around...

Regards,
ismail



-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
