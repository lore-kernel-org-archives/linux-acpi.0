From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI/Processor: Remove acpi_processor_get_limit_info()
Date: Tue, 13 Aug 2013 13:37:20 +0200
Message-ID: <1485940.LThrVsuy8V@vostro.rjw.lan>
References: <1376359678-5826-1-git-send-email-tianyu.lan@intel.com> <1376383859.2335.25.camel@rzhang-lenovo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40906 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757504Ab3HML04 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Aug 2013 07:26:56 -0400
In-Reply-To: <1376383859.2335.25.camel@rzhang-lenovo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: tianyu.lan@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org

On Tuesday, August 13, 2013 04:50:59 PM Zhang Rui wrote:
> On =E4=BA=8C, 2013-08-13 at 10:07 +0800, tianyu.lan@intel.com wrote:
> > From: Lan Tianyu <tianyu.lan@intel.com>
> >=20
> > acpi_processor_get_limit_info() is only called in the __acpi_proces=
sor_start()
> > and what it does actually is just to check pr->flags.throttling and=
 set limit.
> > The pr pointer has been checked in the __acpi_processor_start() bef=
ore
> > acpi_processor_get_limit_info() being called. It doesn't make sense=
 still to
> > keep it as a function. So move code to __acpi_processor_start() and=
 remove
> > acpi_processor_get_limit_info().
> >=20
> > Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>=20
> Acked-by: Zhang Rui <rui.zhang@intel.com>

Queued up for 3.12.

Thanks,
Rafael


> > ---
> >  drivers/acpi/processor_driver.c  |  4 +++-
> >  drivers/acpi/processor_thermal.c | 12 ------------
> >  2 files changed, 3 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/process=
or_driver.c
> > index bd11ef9..e534ba6 100644
> > --- a/drivers/acpi/processor_driver.c
> > +++ b/drivers/acpi/processor_driver.c
> > @@ -175,7 +175,9 @@ static int __acpi_processor_start(struct acpi_d=
evice *device)
> >  	acpi_processor_load_module(pr);
> >  #endif
> >  	acpi_processor_get_throttling_info(pr);
> > -	acpi_processor_get_limit_info(pr);
> > +
> > +	if (pr->flags.throttling)
> > +		pr->flags.limit =3D 1;
> > =20
> >  	if (!cpuidle_get_driver() || cpuidle_get_driver() =3D=3D &acpi_id=
le_driver)
> >  		acpi_processor_power_init(pr);
> > diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/proces=
sor_thermal.c
> > index e8e6527..d1d2e7f 100644
> > --- a/drivers/acpi/processor_thermal.c
> > +++ b/drivers/acpi/processor_thermal.c
> > @@ -186,18 +186,6 @@ static int cpufreq_set_cur_state(unsigned int =
cpu, int state)
> > =20
> >  #endif
> > =20
> > -int acpi_processor_get_limit_info(struct acpi_processor *pr)
> > -{
> > -
> > -	if (!pr)
> > -		return -EINVAL;
> > -
> > -	if (pr->flags.throttling)
> > -		pr->flags.limit =3D 1;
> > -
> > -	return 0;
> > -}
> > -
> >  /* thermal coolign device callbacks */
> >  static int acpi_processor_max_state(struct acpi_processor *pr)
> >  {
>=20
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
