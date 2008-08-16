From: Andi Kleen <ak@linux.intel.com>
Subject: Re: linux-next: Tree for August 14 (sysfs/acpi errors)
Date: Sat, 16 Aug 2008 04:57:57 +0200
Message-ID: <48A64235.2030108@linux.intel.com>
References: <20080814172945.250a27f2.sfr@canb.auug.org.au>	 <20080814083828.d10e126d.randy.dunlap@oracle.com>	 <3ae72650808150427q364842ccicf0a0978b30ca98c@mail.gmail.com>	 <20080815085836.67e420f1.randy.dunlap@oracle.com> <1218854219.3629.30.camel@lgn.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1218854219.3629.30.camel@lgn.site>
Sender: linux-next-owner@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, gregkh <greg@kroah.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, rusty@rustcorp.com.au
List-Id: linux-acpi@vger.kernel.org


>> Extract is:
>>
>> XXX adding modparam:'acpi.power_nocheck' 34 (ffffffff806a4cf0)
> ...
>> XXX adding modparam:'acpi.acpica_version' 45 (ffffffff806a4ea8)
>=20
> Two different "modules" use the same prefix, which does not work with
> the current logic, they need to live next to each other in the sequen=
ce
> of options.

Sequence of options being defined by link order?

> This adds a new option:
>   http://git.kernel.org/?p=3Dlinux/kernel/git/sfr/linux-next.git;a=3D=
commitdiff;h=3D1382827e93799ec07790849e361267993cfe549e
> =EF=BB=BFwhich specifies =EF=BB=BFMODULE_PARAM_PREFIX=3D"acpi." in:
>   drivers/acpi/power.c
> In the same way as:
>   drivers/acpi/system.c
>=20
> Seems, two different modules should not declare parameters in differe=
nt
> locations, and use the same MODULE_PARAM_PREFIX.

That seems bogus to me. Assuming we have some code in a module and then=
 split
it out into two different modules. Or move an option from one file to a=
nother.
Would we need to change the option name then?

I think the generic params code should be fixed to handle this.

-Andi
