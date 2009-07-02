From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete acpi_os_validate_address interface"
Date: Thu, 2 Jul 2009 10:30:58 +0200
Message-ID: <200907021030.58401.jdelvare@suse.de>
References: <1246415391.24831.30.camel@minggr.sh.intel.com> <4911F71203A09E4D9981D27F9D8308582EA03B4A@orsmsx503.amr.corp.intel.com> <200907012319.53021.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51024 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbZGBIa4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2009 04:30:56 -0400
In-Reply-To: <200907012319.53021.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Le mercredi 01 juillet 2009, Thomas Renninger a =E9crit=A0:
> On Wednesday 01 July 2009 05:29:57 pm Moore, Robert wrote:
> > >-----Original Message-----
> > >From: Thomas Renninger [mailto:trenn@suse.de]
> > >Ouch, I thought OperationRegions must be declared in global namesp=
ace.
> > >I agree, we have a memleak and this looks rather sever.
>=20
> An idea for a quick fix which may be suitable for stable kernels (wit=
hout
> checking acpica code..):
> Is it easily possible to check whether the Opregion is declared in gl=
obal
> namespace or inside a method at the place where acpi_os_validate_addr=
ess is called
> from acpica?
> In the latter case it should not be called and we avoid the memleak a=
nd
> could still detect most i2c/smbus/hwmon devices conflicts.

Can't you just walk the list before you add an entry, and if the
entry is already present, do not add it again?

> > >Grmpfl, that makes the resource conflict checking even more ugly.
> > >Thanks for spotting this,
> > >
> > >     Thomas
> >
> > OperationRegions/Fields can be dynamically created/deleted in two w=
ays:
> > 1) Control method execution
> > 2) Dynamic ACPI table load/unload (for example, hotplug)
> >
> > So, in order to track this, the resource list must also be dynamic,=
 with
> > the ability to add and delete entries.
> >
> > It begins to sound like the resource list is becoming a "mini-names=
pace"
> > that consists of only ACPI field objects. Might it not be more effi=
cient to
> > simply query the existing ACPI namespace when you need to? A walk_n=
amespace
> > for field objects would give you the same information as the resour=
ce list,
> > and it is automatically guaranteed to be current.
> >
> > However, the may be some more fundamental issues. I have not looked=
 at
> > exactly how the resource list is used, but since the list is dynami=
c, if
> > the worry concerns address collisions between a driver and the AML
> > interpreter, it may not be enough to simply check for this at the t=
ime the
> > driver is loaded. You would really need to check before *every* I/O=
 or
> > memory access. Which does not sound feasible.

This is indeed not feasible, the cost would be much too high. Not to
mention it would still be racy by design.

Please remember that Thomas' code was meant to solve real-world
problems which had been there for long and nobody else was able to
solve so far. It wasn't meant to be bullet-proof, it was not perfect,
but it did help in practice.

> > I guess that I would like to understand the exact issue(s) that are=
 behind
> > the creation of the resource list in the first place. AFAIK, any AM=
L code
> > that reads/writes to operation regions usually assumes exclusive ac=
cess to
> > these regions. The ACPI Global Lock is used when exclusive access c=
annot be
> > assumed.

I could change the affected native drivers to take the ACPI Global
Lock if needed. But what guarantees that the ACPI code which accesses
the device in question is taking the ACPI Global Lock too? It can
only work if everybody plays the game. My understanding was that most
ACPI implementation did not take the ACPI Global Lock when accessing
the devices and thus this approach wouldn't work in practice. Was I
wrong?

--=20
Jean Delvare
Suse L3
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
