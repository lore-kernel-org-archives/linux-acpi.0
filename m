From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 2/5] acpi/numa: check if parsing acpi numa info
 disabled earlier
Date: Tue, 05 Feb 2013 09:12:18 +0800
Message-ID: <1360026738.4449.8.camel@liguang.fnst.cn.fujitsu.com>
References: <1359967426-32629-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <1359967426-32629-3-git-send-email-lig.fnst@cn.fujitsu.com>
	 <alpine.DEB.2.02.1302041133520.10378@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1302041133520.10378@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

=E5=9C=A8 2013-02-04=E4=B8=80=E7=9A=84 11:41 -0800=EF=BC=8CDavid Rientj=
es=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, 4 Feb 2013, liguang wrote:
>=20
> > Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
>=20
> Because there's no changelog, I have to read the patch to figure out =
what=20
> it's doing since the title isn't that helpful either.  Please provide=
 a=20
> description of what problem you're trying to fix or what improvement=20
> you're trying to make so it's clear.
>=20
> > ---
> >  arch/x86/mm/srat.c  |    6 ------
> >  drivers/acpi/numa.c |    2 ++
> >  2 files changed, 2 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
> > index a837c95..78c67bd 100644
> > --- a/arch/x86/mm/srat.c
> > +++ b/arch/x86/mm/srat.c
> > @@ -60,8 +60,6 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x=
2apic_cpu_affinity *pa)
> >  	int pxm, node;
> >  	int apic_id;
> > =20
> > -	if (srat_disabled())
> > -		return;
> >  	if (pa->header.length < sizeof(struct acpi_srat_x2apic_cpu_affini=
ty)) {
> >  		bad_srat();
> >  		return;
> > @@ -100,8 +98,6 @@ acpi_numa_processor_affinity_init(struct acpi_sr=
at_cpu_affinity *pa)
> >  	int pxm, node;
> >  	int apic_id;
> > =20
> > -	if (srat_disabled())
> > -		return;
> >  	if (pa->header.length !=3D sizeof(struct acpi_srat_cpu_affinity))=
 {
> >  		bad_srat();
> >  		return;
> > @@ -148,8 +144,6 @@ acpi_numa_memory_affinity_init(struct acpi_srat=
_mem_affinity *ma)
> >  	u64 start, end;
> >  	int node, pxm;
> > =20
> > -	if (srat_disabled())
> > -		return -1;
> >  	if (ma->header.length !=3D sizeof(struct acpi_srat_mem_affinity))=
 {
> >  		bad_srat();
> >  		return -1;
> > diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> > index cb31298..1f51222 100644
> > --- a/drivers/acpi/numa.c
> > +++ b/drivers/acpi/numa.c
> > @@ -262,6 +262,8 @@ static int __init acpi_parse_srat(struct acpi_t=
able_header *table)
> >  	struct acpi_table_srat *srat;
> >  	if (!table)
> >  		return -EINVAL;
> > +	if (srat_disabled())
> > +		return -EACCES;
> > =20
> >  	srat =3D (struct acpi_table_srat *)table;
> >  	acpi_srat_revision =3D srat->header.revision;
>=20
> Nack, this isn't helpful since SRAT is only for x86 and other=20
> architectures use this code.  It would break the build on ia64 since =
it's=20
> obviously not going to have a function called srat_disabled().
>=20
> And -EACCES would not be the appropriate return value, this has nothi=
ng to=20
> do with permissions.

Yes, you're right, will drop this change.
