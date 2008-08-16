From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: linux-next: Tree for August 14 (sysfs/acpi errors)
Date: Sat, 16 Aug 2008 04:36:59 +0200
Message-ID: <1218854219.3629.30.camel@lgn.site>
References: <20080814172945.250a27f2.sfr@canb.auug.org.au>
	 <20080814083828.d10e126d.randy.dunlap@oracle.com>
	 <3ae72650808150427q364842ccicf0a0978b30ca98c@mail.gmail.com>
	 <20080815085836.67e420f1.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080815085836.67e420f1.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, gregkh <greg@kroah.com>, ak@linux.intel.com, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2008-08-15 at 08:58 -0700, Randy Dunlap wrote:
> On Fri, 15 Aug 2008 13:27:00 +0200 Kay Sievers wrote:
>=20
> > On Thu, Aug 14, 2008 at 17:38, Randy Dunlap <randy.dunlap@oracle.co=
m> wrote:
> > > calling  param_sysfs_init+0x0/0x1e7
> > > ------------[ cut here ]------------
> > > WARNING: at fs/sysfs/dir.c:463 sysfs_add_one+0x35/0x3d()
> > > sysfs: duplicate filename 'acpi' can not be created
> >=20
> > Hi Randy,
> > care to add a printk to the module sysfs setup, and post dmesg agai=
n?
> >=20
> > --- a/kernel/params.c
> > +++ b/kernel/params.c
> > @@ -603,6 +603,8 @@ static void __init param_sysfs_builtin(void)
> >  		}
> >  		name_len =3D dot - kp->name;
> >=20
> > +		printk("XXX adding modparam:'%s' %i (%p)\n", kp->name, i, kp);
> > +
> >   		/* new kbuild_modname? */
> >  		if (strlen(modname) !=3D name_len
> >  		    || strncmp(modname, kp->name, name_len) !=3D 0) {
> >=20
> > I might show the order of registering the /sys/modules/ directory, =
and
> > if there is possibly another "acpi" section, which tries to add
> > parameter names.

> Extract is:
>=20
> XXX adding modparam:'acpi.power_nocheck' 34 (ffffffff806a4cf0)
=2E..
> XXX adding modparam:'acpi.acpica_version' 45 (ffffffff806a4ea8)

Two different "modules" use the same prefix, which does not work with
the current logic, they need to live next to each other in the sequence
of options.

This adds a new option:
  http://git.kernel.org/?p=3Dlinux/kernel/git/sfr/linux-next.git;a=3Dco=
mmitdiff;h=3D1382827e93799ec07790849e361267993cfe549e
=EF=BB=BFwhich specifies =EF=BB=BFMODULE_PARAM_PREFIX=3D"acpi." in:
  drivers/acpi/power.c
In the same way as:
  drivers/acpi/system.c

Seems, two different modules should not declare parameters in different
locations, and use the same MODULE_PARAM_PREFIX.

Thanks,
Kay
