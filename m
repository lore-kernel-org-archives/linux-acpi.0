From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch 04/13] Exit ACPI processor module gracefully if acpi is
	disabled
Date: Thu, 08 Mar 2007 14:20:32 +0100
Message-ID: <1173360032.5863.57.camel@queen.suse.de>
References: <200702060010.l160ADKR003729@shell0.pdx.osdl.net>
	 <200702090047.25044.lenb@kernel.org>
	 <1171010060.25027.616.camel@d36.suse.de>
	 <200703070300.55821.lenb@kernel.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:52095 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809AbXCHNUi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Mar 2007 08:20:38 -0500
In-Reply-To: <200703070300.55821.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: cpufreq@lists.linux.org.uk, akpm@linux-foundation.org, linux-acpi@vger.kernel.org

On Wed, 2007-03-07 at 03:00 -0500, Len Brown wrote:
> On Friday 09 February 2007 03:34, Thomas Renninger wrote:
> > On Fri, 2007-02-09 at 00:47 -0500, Len Brown wrote:
> > > Why not simply check acpi_disabled, like other drivers do?
> > >=20
> > See comment from Dominik when I sent something similar some time ag=
o:
> > http://marc.theaimsgroup.com/?l=3Dlinux-acpi&m=3D114563882012355&w=3D=
2
>=20
> Dominik is right right driver registration should fail w/o
> a check for acpi_disabled.  However, we use acpi_disabled all
> over the place already when that is not sufficient, so if we
> need it here, we can use it..
>=20
> >> [Dominik wrote]
> >> No. For example powernow-k8 and speedstep-centrino do have a depen=
dency on a
> >> function which is exported by processor_perflib.c. THis means you =
cannot
> >> load these modules (which can run without ACPI support) if loading=
 the
> >> processor module fails. Therefore its init function must not fail.
>=20
> Blech, so the drivers that can be either native or ACPI can't link
> in native mode unless their ACPI processor driver symbols resolve?
>=20
> Hmmm.  Perhaps we should delete the ACPI part of speedstep_centrino
> now that it is deprecated by acpi-cpufreq?  That way it can be
> just a native driver for folks who want to run
> with hard-coded tables and no ACPI.
> Or perhaps at this point we should delete speedstep_centrino entirely=
?
>=20
> Looks like powernow-k7.c and powernow-k8.c have the same issue --
> acpi_processor_register_performance() ain't gonna resolve if the acpi=
 processor
> driver isn't present.  Perhaps they can be split into native and ACPI=
 drivers?
But all this sounds like a lot work?
Can you just add the patch for now, to solve the "oops or whatever bad
happened when booted without acpi and processor module gets unloaded"?

Thanks,

   Thomas

> -Len
>=20
>=20
> > > On Monday 05 February 2007 19:09, akpm@linux-foundation.org wrote=
:
> > > > From: Thomas Renninger <trenn@suse.de>
> > > >=20
> > > > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > > > Cc: Len Brown <lenb@kernel.org>
> > > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > > ---
> > > >=20
> > > >  drivers/acpi/processor_core.c |   13 +++++++++----
> > > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff -puN drivers/acpi/processor_core.c~exit-acpi-processor-mod=
ule-gracefully-if-acpi-is-disabled drivers/acpi/processor_core.c
> > > > --- a/drivers/acpi/processor_core.c~exit-acpi-processor-module-=
gracefully-if-acpi-is-disabled
> > > > +++ a/drivers/acpi/processor_core.c
> > > > @@ -994,6 +994,8 @@ void acpi_processor_uninstall_hotplug_no
> > > >   * ACPI, but needs symbols from this driver
> > > >   */
> > > > =20
> > > > +static int processor_driver_registered;
> > > > +
> > > >  static int __init acpi_processor_init(void)
> > > >  {
> > > >  	int result =3D 0;
> > > > @@ -1019,6 +1021,8 @@ static int __init acpi_processor_init(vo
> > > >  		return result;
> > > >  	}
> > > > =20
> > > > +	processor_driver_registered =3D 1;
> > > > +
> > > >  	acpi_processor_install_hotplug_notify();
> > > > =20
> > > >  	acpi_thermal_cpufreq_init();
> > > > @@ -1035,12 +1039,13 @@ static void __exit acpi_processor_exit(=
v
> > > > =20
> > > >  	acpi_thermal_cpufreq_exit();
> > > > =20
> > > > -	acpi_processor_uninstall_hotplug_notify();
> > > > -
> > > > -	acpi_bus_unregister_driver(&acpi_processor_driver);
> > > > +	if (processor_driver_registered) {
> > > > +		acpi_processor_uninstall_hotplug_notify();
> > > > =20
> > > > -	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
> > > > +		acpi_bus_unregister_driver(&acpi_processor_driver);
> > > > =20
> > > > +		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
> > > > +	}
> > > >  	return;
> > > >  }
> > > > =20
> > > > _
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux=
-acpi" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
> > > >=20
> >=20
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
Thomas Renninger

Research and Developement Departement
SUSE LINUX Products GmbH,
Maxfeldstr. 5, D - 90409 N=C3=BCrnberg
Phone: +49 (0)911 - 740 53 675
e-mail: trenn@suse.de

SUSE LINUX Products GmbH, GF: Markus Rex, HRB 16746 (AG N=C3=BCrnberg)

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
