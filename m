From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 1/5] numa: avoid export acpi_numa variable
Date: Tue, 05 Feb 2013 08:56:33 +0800
Message-ID: <1360025793.4449.6.camel@liguang.fnst.cn.fujitsu.com>
References: <1359967426-32629-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <1359967426-32629-2-git-send-email-lig.fnst@cn.fujitsu.com>
	 <alpine.DEB.2.02.1302041127540.10378@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:20615 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755566Ab3BEA4u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Feb 2013 19:56:50 -0500
In-Reply-To: <alpine.DEB.2.02.1302041127540.10378@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org

=E5=9C=A8 2013-02-04=E4=B8=80=E7=9A=84 11:31 -0800=EF=BC=8CDavid Rientj=
es=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, 4 Feb 2013, liguang wrote:
>=20
> > diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acp=
i.h
> > index 0c44630..c4e0875 100644
> > --- a/arch/x86/include/asm/acpi.h
> > +++ b/arch/x86/include/asm/acpi.h
> > @@ -181,7 +181,8 @@ static inline void disable_acpi(void) { }
> >  #define ARCH_HAS_POWER_INIT	1
> > =20
> >  #ifdef CONFIG_ACPI_NUMA
> > -extern int acpi_numa;
> > +extern void bad_srat(void);
> > +extern bool srat_disabled(void);
>=20
> So anything that wants to disable acpi_numa, such as xen, must call a=
=20
> function named bad_srat()?  That seems a little misnamed itself.

I would assume every caller have the sense of what SRAT is.
(may be a little bold assumption)

>=20
> >  extern int x86_acpi_numa_init(void);
> >  #endif /* CONFIG_ACPI_NUMA */
> > =20
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 2d125be..92986d8 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -47,7 +47,7 @@ static __init int numa_setup(char *opt)
> >  #endif
> >  #ifdef CONFIG_ACPI_NUMA
> >  	if (!strncmp(opt, "noacpi", 6))
> > -		acpi_numa =3D -1;
> > +		bad_srat();
>=20
> This will print an error line saying "SRAT: SRAT not used." which was=
n't=20
> emitted before.  I don't think that's the desire.

yes, you're right.

>=20
> >  #endif
> >  	return 0;
> >  }
> > diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
> > index 4ddf497..a837c95 100644
> > --- a/arch/x86/mm/srat.c
> > +++ b/arch/x86/mm/srat.c
> > @@ -24,22 +24,22 @@
> >  #include <asm/apic.h>
> >  #include <asm/uv/uv.h>
> > =20
> > -int acpi_numa __initdata;
> > +static bool acpi_numa __initdata;
> > =20
>=20
> You've changed this to be type bool but didn't update the existing co=
de=20
> that still does "acpi_numa =3D 1".

good catch!

>=20
> >  static __init int setup_node(int pxm)
> >  {
> >  	return acpi_map_pxm_to_node(pxm);
> >  }
> > =20
> > -static __init void bad_srat(void)
> > +void __init bad_srat(void)
> >  {
> >  	printk(KERN_ERR "SRAT: SRAT not used.\n");
> > -	acpi_numa =3D -1;
> > +	acpi_numa =3D false;
> >  }
> > =20
> > -static __init inline int srat_disabled(void)
> > +bool __init srat_disabled(void)
> >  {
> > -	return acpi_numa < 0;
> > +	return acpi_numa;
> >  }
> > =20
> >  /* Callback for SLIT parsing */
> > diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> > index 138e566..94c8c70 100644
> > --- a/arch/x86/xen/enlighten.c
> > +++ b/arch/x86/xen/enlighten.c
> > @@ -1415,7 +1415,7 @@ asmlinkage void __init xen_start_kernel(void)
> >  	 * any NUMA information the kernel tries to get from ACPI will
> >  	 * be meaningless.  Prevent it from trying.
> >  	 */
> > -	acpi_numa =3D -1;
> > +	bad_srat();
>=20
> Same as before.  It seems like you want to introduce a new function=20
> specifically to disable it:
>=20
> 	void acpi_numa_disable(void)
> 	{
> 		acpi_numa =3D false;
> 	}
>=20
> and then bad_srat() should call into it?

good idea, Thanks!




--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
