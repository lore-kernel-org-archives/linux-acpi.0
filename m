From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: linux-next: Tree for August 14 (sysfs/acpi errors)
Date: Sat, 16 Aug 2008 05:19:58 +0200
Message-ID: <1218856798.3629.45.camel@lgn.site>
References: <20080814172945.250a27f2.sfr@canb.auug.org.au>
	 <20080814083828.d10e126d.randy.dunlap@oracle.com>
	 <3ae72650808150427q364842ccicf0a0978b30ca98c@mail.gmail.com>
	 <20080815085836.67e420f1.randy.dunlap@oracle.com>
	 <1218854219.3629.30.camel@lgn.site>  <48A64235.2030108@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <48A64235.2030108@linux.intel.com>
Sender: linux-next-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, gregkh <greg@kroah.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, rusty@rustcorp.com.au
List-Id: linux-acpi@vger.kernel.org

On Sat, 2008-08-16 at 04:57 +0200, Andi Kleen wrote:
> >> Extract is:
> >>
> >> XXX adding modparam:'acpi.power_nocheck' 34 (ffffffff806a4cf0)
> > ...
> >> XXX adding modparam:'acpi.acpica_version' 45 (ffffffff806a4ea8)
> >=20
> > Two different "modules" use the same prefix, which does not work wi=
th
> > the current logic, they need to live next to each other in the sequ=
ence
> > of options.
>=20
> Sequence of options being defined by link order?

Yeah, they are stored in a global array __start___param, and the curren=
t
code expects the prefixes to be sorted, so the sysfs directories can be
created for every first new prefix.

> > This adds a new option:
> >   http://git.kernel.org/?p=3Dlinux/kernel/git/sfr/linux-next.git;a=3D=
commitdiff;h=3D1382827e93799ec07790849e361267993cfe549e
> > =EF=BB=BFwhich specifies =EF=BB=BFMODULE_PARAM_PREFIX=3D"acpi." in:
> >   drivers/acpi/power.c
> > In the same way as:
> >   drivers/acpi/system.c
> >=20
> > Seems, two different modules should not declare parameters in diffe=
rent
> > locations, and use the same MODULE_PARAM_PREFIX.
>=20
> That seems bogus to me. Assuming we have some code in a module and th=
en split
> it out into two different modules. Or move an option from one file to=
 another.
> Would we need to change the option name then?

They have been module options, not prefixed kernel parameters so far,
and the prefix was just the module name.
So it just strikes back, that acpi uses generic names for the modules,
there would have been no problem if "power" would be called "acpi_power=
"
and the options would just be =EF=BB=BF"acpi.acpica_version" and
"acpi_power.nocheck".

But well, there are driver modules just called "option", so acpi is not
that bad. :)

> I think the generic params code should be fixed to handle this.

We could try to look up existing directories to use instead of expectin=
g
that we need to create and own them. I guess, we have the same issue if
we compile the code as a module and load it later, while some other
built-in code or module has already used the same prefix.

Kay
