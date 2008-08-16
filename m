From: Andi Kleen <ak@linux.intel.com>
Subject: Re: linux-next: Tree for August 14 (sysfs/acpi errors)
Date: Sat, 16 Aug 2008 05:48:26 +0200
Message-ID: <48A64E0A.8090408@linux.intel.com>
References: <20080814172945.250a27f2.sfr@canb.auug.org.au>	 <20080814083828.d10e126d.randy.dunlap@oracle.com>	 <3ae72650808150427q364842ccicf0a0978b30ca98c@mail.gmail.com>	 <20080815085836.67e420f1.randy.dunlap@oracle.com>	 <1218854219.3629.30.camel@lgn.site>  <48A64235.2030108@linux.intel.com> <1218856798.3629.45.camel@lgn.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1218856798.3629.45.camel@lgn.site>
Sender: linux-next-owner@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, gregkh <greg@kroah.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, rusty@rustcorp.com.au
List-Id: linux-acpi@vger.kernel.org


>=20
> They have been module options, not prefixed kernel parameters so far,
> and the prefix was just the module name.
> So it just strikes back, that acpi uses generic names for the modules=
,
> there would have been no problem if "power" would be called "acpi_pow=
er"
> and the options would just be =EF=BB=BF"acpi.acpica_version" and
> "acpi_power.nocheck".
>=20
> But well, there are driver modules just called "option", so acpi is n=
ot
> that bad. :)
>=20
>> I think the generic params code should be fixed to handle this.
>=20
> We could try to look up existing directories to use instead of expect=
ing
> that we need to create and own them. I guess,

sysfs does this anyways, doesn't it. We would just need to teach it
to not BUG() in this case, perhaps with a special entry point.
Also a BUG() in general seems a little harsh for this, surely a WARN_ON
should be enough.

-Andi
