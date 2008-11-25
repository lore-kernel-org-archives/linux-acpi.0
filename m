From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Regression: ACPI AC driver doesn't work on Toshiba Portege
	R500 (bisected)
Date: Tue, 25 Nov 2008 09:20:51 +0800
Message-ID: <1227576051.15014.305.camel@rzhang-dt>
References: <200811230053.14211.rjw@sisk.pl>
	 <200811240221.54716.rjw@sisk.pl> <1227490280.15014.291.camel@rzhang-dt>
	 <200811241430.02434.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8205 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736AbYKYBWJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Nov 2008 20:22:09 -0500
In-Reply-To: <200811241430.02434.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, walken <walken@zoy.org>

On Mon, 2008-11-24 at 21:30 +0800, Rafael J. Wysocki wrote:
> On Monday, 24 of November 2008, Zhang Rui wrote:
> > On Mon, 2008-11-24 at 09:21 +0800, Rafael J. Wysocki wrote:
> > > On Monday, 24 of November 2008, Zhao Yakui wrote:
> > > > On Mon, 2008-11-24 at 07:37 +0800, Rafael J. Wysocki wrote:
> > > > > On Sunday, 23 of November 2008, Rafael J. Wysocki wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > With current mainline (2.6.28-rc6-git1 as of today) on Tosh=
iba Portege R500 the
> > > > > > status of the AC adapter is not updated when the adapter is=
 unplugged and
> > > > > > plugged in.  Evidently, /sys/class/power_supply/ADP1/online=
 always contains the
> > > > > > same value.  Interestingly enough, though, if the box is su=
spended to RAM and
> > > > > > resumed, the status of the AC adapter is correctly updated,=
 but the value read
> > > > > > at that time remains in /sys/class/power_supply/ADP1/online=
 until the next
> > > > > > suspend/resume cycle regardless of what's going on with the=
 AC adapter.
> > > > > >=20
> > > > > > 2.6.27.7 works correctly on this box so the recent EC patch=
es don't seem to
> > > > > > cause this regression to happen.
> > > > > >=20
> > > > > > Any other ideas?
> > > > Hi, Rafael
> > > >     Will you please open a new bug at
> > > > http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI and att=
ach the
> > > > output of acpidump, dmesg, lspci -vxxx?
> > > >     If no ACPI event is reported when AC adapter is unplugged a=
nd
> > > > plugged, the /sys/class interface can't display the correct AC =
status.
> > > > Now Rui is working on this issue and the patch is already finis=
hed. But
> > > > it is not sent to Lenb.
> > >=20
> > > Can you give me a link to the patch, please?
>=20
> Thanks.
>=20
> Still, it doesn't seem to be related to the problem at hand.
>=20
right, it's another problem.

> > From: Zhang Rui <rui.zhang@intel.com>
> > Subject: power_supply: update ac status before acquiring it.
> >=20
> > Update AC status in sysfs I/F.
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D12035
> >=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/ac.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > Index: linux-2.6/drivers/acpi/ac.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/acpi/ac.c
> > +++ linux-2.6/drivers/acpi/ac.c
> > @@ -87,6 +87,7 @@ struct acpi_ac {
> >  	unsigned long long state;
> >  };
> > =20
> > +static int acpi_ac_get_state(struct acpi_ac *ac);
> >  #define to_acpi_ac(x) container_of(x, struct acpi_ac, charger);
> > =20
> >  #ifdef CONFIG_ACPI_PROCFS_POWER
> > @@ -103,15 +104,18 @@ static int get_ac_property(struct power_
> >  			   enum power_supply_property psp,
> >  			   union power_supply_propval *val)
> >  {
> > +	int result;
> >  	struct acpi_ac *ac =3D to_acpi_ac(psy);
> > +
> >  	switch (psp) {
> >  	case POWER_SUPPLY_PROP_ONLINE:
> > +		result =3D acpi_ac_get_state(ac);
> >  		val->intval =3D ac->state;
> >  		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > -	return 0;
> > +	return result;
> >  }
> > =20
> >  static enum power_supply_property ac_props[] =3D {
> >=20
> > > =20
> > > >     From the problem description it seems that the problem is r=
elated
> > > > with the AC driver. But from the git-bisect it seems that the p=
roblem is
> > > > related with the button driver(Fix power button device).=20
> > > >=20
> > > >     Any-way, please attach the output of dmesg, acpidump, lspci=
 -vxxx.
> > >=20
> > > Created http://bugzilla.kernel.org/show_bug.cgi?id=3D12091 with t=
he information
> > > attached as requested.
> > >=20
> > I'll take this bug. :)
>=20
> Thanks again.
>=20
> Do I understand correctly that you intend to revert commit
> faee816b1502385dc9bc5abf2960d1cc645844d1 and provide an alternative p=
atch
> for walken?
>=20
=46irst, I think it's safe to revert
commit =EF=BB=BFfaee816b1502385dc9bc5abf2960d1cc645844d1
because bug #10503 can not be reproduced in the upstream kernel as a
result of another commit  49db139955d3392c6c4facf987905d0a9afed581

Second, if we can make sure all the pci devices won't issue any PMEs
when the /sys/devices/.../power/wakeup files are "disabled", then I'd
glad to generate another patch which always enables the PCI root bridge
(PNP0A03) GPE, both at runtime and sleep state, just like what we do fo=
r
the buttons.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
