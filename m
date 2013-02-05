From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v3 2/4] numa: avoid export acpi_numa variable
Date: Tue, 05 Feb 2013 16:10:55 +0800
Message-ID: <1360051855.4449.30.camel@liguang.fnst.cn.fujitsu.com>
References: <1360049762-6349-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <1360049762-6349-3-git-send-email-lig.fnst@cn.fujitsu.com>
	 <5110BB0C.3020004@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:46604 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753969Ab3BEILO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Feb 2013 03:11:14 -0500
In-Reply-To: <5110BB0C.3020004@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, rientjes@google.com

=E5=9C=A8 2013-02-05=E4=BA=8C=E7=9A=84 16:55 +0900=EF=BC=8CYasuaki Ishi=
matsu=E5=86=99=E9=81=93=EF=BC=9A
> 2013/02/05 16:36, liguang wrote:
> > acpi_numa is used to prevent srat table
> > being parsed, seems a little miss-named,
> > if 'noacpi' was specified by cmdline and
> > CONFIG_ACPI_NUMA was enabled, acpi_numa
> > will be operated directly from everywhere
> > it needed to disable/enable numa in acpi
> > mode which was a bad thing, so, try to
> > export a fuction to get srat table
> > enable/disable info.
> >=20
> > Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
> > ---
>=20
> Hmm. Did you test the patch?
> By the patch, srat_disable() returns false(0) or 1. As a result,
> acpi_numa_x2apic_affinity_init(), acpi_numa_processor_affinity_init()
> and acpi_numa_memory_affinity_init() go wrong at following if sentenc=
e.
>=20
> ---
> 	if (srat_disable())
> 		return -1;
> ---
>=20
> When you change a return value of function, you should check othe
> functions which use it carefully.
>=20
> And if you use acpi_numa as bool, you should use "acpi_numa =3D true"
> instead of "acpi_numa =3D 1"

Good observation!
maybe I'm a little hurry to go for dining, :)
Thanks! will fix.

>=20
> Thanks,
> Yasuaki Ishimatsu
>=20
> >   arch/x86/include/asm/acpi.h |    2 +-
> >   arch/x86/kernel/acpi/srat.c |   17 +++++++++++------
> >   arch/x86/mm/numa.c          |    2 +-
> >   arch/x86/xen/enlighten.c    |    2 +-
> >   4 files changed, 14 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acp=
i.h
> > index b31bf97..449e12a 100644
> > --- a/arch/x86/include/asm/acpi.h
> > +++ b/arch/x86/include/asm/acpi.h
> > @@ -177,7 +177,7 @@ static inline void disable_acpi(void) { }
> >   #define ARCH_HAS_POWER_INIT	1
> >  =20
> >   #ifdef CONFIG_ACPI_NUMA
> > -extern int acpi_numa;
> > +extern void disable_acpi_numa(void);
> >   extern int x86_acpi_numa_init(void);
> >   #endif /* CONFIG_ACPI_NUMA */
> >  =20
> > diff --git a/arch/x86/kernel/acpi/srat.c b/arch/x86/kernel/acpi/sra=
t.c
> > index cdd0da9..8d7f3f8 100644
> > --- a/arch/x86/kernel/acpi/srat.c
> > +++ b/arch/x86/kernel/acpi/srat.c
> > @@ -24,22 +24,27 @@
> >   #include <asm/apic.h>
> >   #include <asm/uv/uv.h>
> >  =20
> > -int acpi_numa __initdata;
> > +static bool acpi_numa __initdata;
> >  =20
> >   static __init int setup_node(int pxm)
> >   {
> >   	return acpi_map_pxm_to_node(pxm);
> >   }
> >  =20
> > -static __init void bad_srat(void)
> > +void __init disable_acpi_numa(void)
> >   {
> > -	printk(KERN_ERR "SRAT: SRAT not used.\n");
> > -	acpi_numa =3D -1;
> > +	acpi_numa =3D false;
> >   }
> >  =20
> > -static __init inline int srat_disabled(void)
> > +static void __init bad_srat(void)
> >   {
> > -	return acpi_numa < 0;
> > +	disable_acpi_numa();
> > +	printk(KERN_ERR "SRAT: SRAT will not be used.\n");
> > +}
> > +
> > +static bool __init srat_disabled(void)
> > +{
> > +	return acpi_numa;
> >   }
> >  =20
> >   /* Callback for SLIT parsing */
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 245a4ba..1ebc907 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -47,7 +47,7 @@ static __init int numa_setup(char *opt)
> >   #endif
> >   #ifdef CONFIG_ACPI_NUMA
> >   	if (!strncmp(opt, "noacpi", 6))
> > -		acpi_numa =3D -1;
> > +		disable_acpi_numa();
> >   #endif
> >   	return 0;
> >   }
> > diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> > index 657eca9..3636bc6 100644
> > --- a/arch/x86/xen/enlighten.c
> > +++ b/arch/x86/xen/enlighten.c
> > @@ -1447,7 +1447,7 @@ asmlinkage void __init xen_start_kernel(void)
> >   	 * any NUMA information the kernel tries to get from ACPI will
> >   	 * be meaningless.  Prevent it from trying.
> >   	 */
> > -	acpi_numa =3D -1;
> > +	disable_acpi_numa();
> >   #endif
> >  =20
> >   	/* Don't do the full vcpu_info placement stuff until we have a
> >=20
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
