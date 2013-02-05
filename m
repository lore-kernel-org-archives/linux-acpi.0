From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2 1/4] acpi: move x86/mm/srat.c to
 x86/kernel/acpi/srat.c
Date: Tue, 05 Feb 2013 12:49:10 +0800
Message-ID: <1360039750.4449.10.camel@liguang.fnst.cn.fujitsu.com>
References: <1360031838-26898-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <1360031838-26898-2-git-send-email-lig.fnst@cn.fujitsu.com>
	 <51108E25.6070300@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:54175 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751151Ab3BEEt2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Feb 2013 23:49:28 -0500
In-Reply-To: <51108E25.6070300@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, rientjes@google.com

=E5=9C=A8 2013-02-05=E4=BA=8C=E7=9A=84 13:44 +0900=EF=BC=8CYasuaki Ishi=
matsu=E5=86=99=E9=81=93=EF=BC=9A
> Hi Liguang,
>=20
> 2013/02/05 11:37, liguang wrote:
> > srat table should present only on acpi domain,
> > seems mm/ is not the right place for it.
> >=20
> > Reviewed-by: David Rientjes <rientjes@google.com>
> > Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
> > ---
> >
> >   arch/x86/kernel/acpi/srat.c |  197 ++++++++++++++++++++++++++++++=
+++++++++++++
> >   arch/x86/mm/srat.c          |  197 ------------------------------=
-------------
> >   2 files changed, 197 insertions(+), 197 deletions(-)
> >   create mode 100644 arch/x86/kernel/acpi/srat.c
> >   delete mode 100644 arch/x86/mm/srat.c
>=20
> Changes of Makefile disappeared.
>=20
> Thanks,
> Yasuaki Ishimatsu

Oh, fogot it,=20
Thank you so much for reminding me!

>=20
> >=20
> > diff --git a/arch/x86/kernel/acpi/srat.c b/arch/x86/kernel/acpi/sra=
t.c
> > new file mode 100644
> > index 0000000..4ddf497
> > --- /dev/null
> > +++ b/arch/x86/kernel/acpi/srat.c
> > @@ -0,0 +1,197 @@
> > +/*
> > + * ACPI 3.0 based NUMA setup
> > + * Copyright 2004 Andi Kleen, SuSE Labs.
> > + *
> > + * Reads the ACPI SRAT table to figure out what memory belongs to =
which CPUs.
> > + *
> > + * Called from acpi_numa_init while reading the SRAT and SLIT tabl=
es.
> > + * Assumes all memory regions belonging to a single proximity doma=
in
> > + * are in one chunk. Holes between them will be included in the no=
de.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/acpi.h>
> > +#include <linux/mmzone.h>
> > +#include <linux/bitmap.h>
> > +#include <linux/module.h>
> > +#include <linux/topology.h>
> > +#include <linux/bootmem.h>
> > +#include <linux/memblock.h>
> > +#include <linux/mm.h>
> > +#include <asm/proto.h>
> > +#include <asm/numa.h>
> > +#include <asm/e820.h>
> > +#include <asm/apic.h>
> > +#include <asm/uv/uv.h>
> > +
> > +int acpi_numa __initdata;
> > +
> > +static __init int setup_node(int pxm)
> > +{
> > +	return acpi_map_pxm_to_node(pxm);
> > +}
> > +
> > +static __init void bad_srat(void)
> > +{
> > +	printk(KERN_ERR "SRAT: SRAT not used.\n");
> > +	acpi_numa =3D -1;
> > +}
> > +
> > +static __init inline int srat_disabled(void)
> > +{
> > +	return acpi_numa < 0;
> > +}
> > +
> > +/* Callback for SLIT parsing */
> > +void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
> > +{
> > +	int i, j;
> > +
> > +	for (i =3D 0; i < slit->locality_count; i++)
> > +		for (j =3D 0; j < slit->locality_count; j++)
> > +			numa_set_distance(pxm_to_node(i), pxm_to_node(j),
> > +				slit->entry[slit->locality_count * i + j]);
> > +}
> > +
> > +/* Callback for Proximity Domain -> x2APIC mapping */
> > +void __init
> > +acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinit=
y *pa)
> > +{
> > +	int pxm, node;
> > +	int apic_id;
> > +
> > +	if (srat_disabled())
> > +		return;
> > +	if (pa->header.length < sizeof(struct acpi_srat_x2apic_cpu_affini=
ty)) {
> > +		bad_srat();
> > +		return;
> > +	}
> > +	if ((pa->flags & ACPI_SRAT_CPU_ENABLED) =3D=3D 0)
> > +		return;
> > +	pxm =3D pa->proximity_domain;
> > +	apic_id =3D pa->apic_id;
> > +	if (!apic->apic_id_valid(apic_id)) {
> > +		printk(KERN_INFO "SRAT: PXM %u -> X2APIC 0x%04x ignored\n",
> > +			 pxm, apic_id);
> > +		return;
> > +	}
> > +	node =3D setup_node(pxm);
> > +	if (node < 0) {
> > +		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
> > +		bad_srat();
> > +		return;
> > +	}
> > +
> > +	if (apic_id >=3D MAX_LOCAL_APIC) {
> > +		printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u skipped=
 apicid that is too big\n", pxm, apic_id, node);
> > +		return;
> > +	}
> > +	set_apicid_to_node(apic_id, node);
> > +	node_set(node, numa_nodes_parsed);
> > +	acpi_numa =3D 1;
> > +	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u\n",
> > +	       pxm, apic_id, node);
> > +}
> > +
> > +/* Callback for Proximity Domain -> LAPIC mapping */
> > +void __init
> > +acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *p=
a)
> > +{
> > +	int pxm, node;
> > +	int apic_id;
> > +
> > +	if (srat_disabled())
> > +		return;
> > +	if (pa->header.length !=3D sizeof(struct acpi_srat_cpu_affinity))=
 {
> > +		bad_srat();
> > +		return;
> > +	}
> > +	if ((pa->flags & ACPI_SRAT_CPU_ENABLED) =3D=3D 0)
> > +		return;
> > +	pxm =3D pa->proximity_domain_lo;
> > +	if (acpi_srat_revision >=3D 2)
> > +		pxm |=3D *((unsigned int*)pa->proximity_domain_hi) << 8;
> > +	node =3D setup_node(pxm);
> > +	if (node < 0) {
> > +		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
> > +		bad_srat();
> > +		return;
> > +	}
> > +
> > +	if (get_uv_system_type() >=3D UV_X2APIC)
> > +		apic_id =3D (pa->apic_id << 8) | pa->local_sapic_eid;
> > +	else
> > +		apic_id =3D pa->apic_id;
> > +
> > +	if (apic_id >=3D MAX_LOCAL_APIC) {
> > +		printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u skipped=
 apicid that is too big\n", pxm, apic_id, node);
> > +		return;
> > +	}
> > +
> > +	set_apicid_to_node(apic_id, node);
> > +	node_set(node, numa_nodes_parsed);
> > +	acpi_numa =3D 1;
> > +	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u\n",
> > +	       pxm, apic_id, node);
> > +}
> > +
> > +#ifdef CONFIG_MEMORY_HOTPLUG
> > +static inline int save_add_info(void) {return 1;}
> > +#else
> > +static inline int save_add_info(void) {return 0;}
> > +#endif
> > +
> > +/* Callback for parsing of the Proximity Domain <-> Memory Area ma=
ppings */
> > +int __init
> > +acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
> > +{
> > +	u64 start, end;
> > +	int node, pxm;
> > +
> > +	if (srat_disabled())
> > +		return -1;
> > +	if (ma->header.length !=3D sizeof(struct acpi_srat_mem_affinity))=
 {
> > +		bad_srat();
> > +		return -1;
> > +	}
> > +	if ((ma->flags & ACPI_SRAT_MEM_ENABLED) =3D=3D 0)
> > +		return -1;
> > +
> > +	if ((ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && !save_add_info()=
)
> > +		return -1;
> > +	start =3D ma->base_address;
> > +	end =3D start + ma->length;
> > +	pxm =3D ma->proximity_domain;
> > +	if (acpi_srat_revision <=3D 1)
> > +		pxm &=3D 0xff;
> > +	node =3D setup_node(pxm);
> > +	if (node < 0) {
> > +		printk(KERN_ERR "SRAT: Too many proximity domains.\n");
> > +		bad_srat();
> > +		return -1;
> > +	}
> > +
> > +	if (numa_add_memblk(node, start, end) < 0) {
> > +		bad_srat();
> > +		return -1;
> > +	}
> > +
> > +	node_set(node, numa_nodes_parsed);
> > +
> > +	printk(KERN_INFO "SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
> > +	       node, pxm,
> > +	       (unsigned long long) start, (unsigned long long) end - 1);
> > +	return 0;
> > +}
> > +
> > +void __init acpi_numa_arch_fixup(void) {}
> > +
> > +int __init x86_acpi_numa_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret =3D acpi_numa_init();
> > +	if (ret < 0)
> > +		return ret;
> > +	return srat_disabled() ? -EINVAL : 0;
> > +}
> > diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
> > deleted file mode 100644
> > index 4ddf497..0000000
> > --- a/arch/x86/mm/srat.c
> > +++ /dev/null
> > @@ -1,197 +0,0 @@
> > -/*
> > - * ACPI 3.0 based NUMA setup
> > - * Copyright 2004 Andi Kleen, SuSE Labs.
> > - *
> > - * Reads the ACPI SRAT table to figure out what memory belongs to =
which CPUs.
> > - *
> > - * Called from acpi_numa_init while reading the SRAT and SLIT tabl=
es.
> > - * Assumes all memory regions belonging to a single proximity doma=
in
> > - * are in one chunk. Holes between them will be included in the no=
de.
> > - */
> > -
> > -#include <linux/kernel.h>
> > -#include <linux/acpi.h>
> > -#include <linux/mmzone.h>
> > -#include <linux/bitmap.h>
> > -#include <linux/module.h>
> > -#include <linux/topology.h>
> > -#include <linux/bootmem.h>
> > -#include <linux/memblock.h>
> > -#include <linux/mm.h>
> > -#include <asm/proto.h>
> > -#include <asm/numa.h>
> > -#include <asm/e820.h>
> > -#include <asm/apic.h>
> > -#include <asm/uv/uv.h>
> > -
> > -int acpi_numa __initdata;
> > -
> > -static __init int setup_node(int pxm)
> > -{
> > -	return acpi_map_pxm_to_node(pxm);
> > -}
> > -
> > -static __init void bad_srat(void)
> > -{
> > -	printk(KERN_ERR "SRAT: SRAT not used.\n");
> > -	acpi_numa =3D -1;
> > -}
> > -
> > -static __init inline int srat_disabled(void)
> > -{
> > -	return acpi_numa < 0;
> > -}
> > -
> > -/* Callback for SLIT parsing */
> > -void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
> > -{
> > -	int i, j;
> > -
> > -	for (i =3D 0; i < slit->locality_count; i++)
> > -		for (j =3D 0; j < slit->locality_count; j++)
> > -			numa_set_distance(pxm_to_node(i), pxm_to_node(j),
> > -				slit->entry[slit->locality_count * i + j]);
> > -}
> > -
> > -/* Callback for Proximity Domain -> x2APIC mapping */
> > -void __init
> > -acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinit=
y *pa)
> > -{
> > -	int pxm, node;
> > -	int apic_id;
> > -
> > -	if (srat_disabled())
> > -		return;
> > -	if (pa->header.length < sizeof(struct acpi_srat_x2apic_cpu_affini=
ty)) {
> > -		bad_srat();
> > -		return;
> > -	}
> > -	if ((pa->flags & ACPI_SRAT_CPU_ENABLED) =3D=3D 0)
> > -		return;
> > -	pxm =3D pa->proximity_domain;
> > -	apic_id =3D pa->apic_id;
> > -	if (!apic->apic_id_valid(apic_id)) {
> > -		printk(KERN_INFO "SRAT: PXM %u -> X2APIC 0x%04x ignored\n",
> > -			 pxm, apic_id);
> > -		return;
> > -	}
> > -	node =3D setup_node(pxm);
> > -	if (node < 0) {
> > -		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
> > -		bad_srat();
> > -		return;
> > -	}
> > -
> > -	if (apic_id >=3D MAX_LOCAL_APIC) {
> > -		printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u skipped=
 apicid that is too big\n", pxm, apic_id, node);
> > -		return;
> > -	}
> > -	set_apicid_to_node(apic_id, node);
> > -	node_set(node, numa_nodes_parsed);
> > -	acpi_numa =3D 1;
> > -	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u\n",
> > -	       pxm, apic_id, node);
> > -}
> > -
> > -/* Callback for Proximity Domain -> LAPIC mapping */
> > -void __init
> > -acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *p=
a)
> > -{
> > -	int pxm, node;
> > -	int apic_id;
> > -
> > -	if (srat_disabled())
> > -		return;
> > -	if (pa->header.length !=3D sizeof(struct acpi_srat_cpu_affinity))=
 {
> > -		bad_srat();
> > -		return;
> > -	}
> > -	if ((pa->flags & ACPI_SRAT_CPU_ENABLED) =3D=3D 0)
> > -		return;
> > -	pxm =3D pa->proximity_domain_lo;
> > -	if (acpi_srat_revision >=3D 2)
> > -		pxm |=3D *((unsigned int*)pa->proximity_domain_hi) << 8;
> > -	node =3D setup_node(pxm);
> > -	if (node < 0) {
> > -		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
> > -		bad_srat();
> > -		return;
> > -	}
> > -
> > -	if (get_uv_system_type() >=3D UV_X2APIC)
> > -		apic_id =3D (pa->apic_id << 8) | pa->local_sapic_eid;
> > -	else
> > -		apic_id =3D pa->apic_id;
> > -
> > -	if (apic_id >=3D MAX_LOCAL_APIC) {
> > -		printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u skipped=
 apicid that is too big\n", pxm, apic_id, node);
> > -		return;
> > -	}
> > -
> > -	set_apicid_to_node(apic_id, node);
> > -	node_set(node, numa_nodes_parsed);
> > -	acpi_numa =3D 1;
> > -	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u\n",
> > -	       pxm, apic_id, node);
> > -}
> > -
> > -#ifdef CONFIG_MEMORY_HOTPLUG
> > -static inline int save_add_info(void) {return 1;}
> > -#else
> > -static inline int save_add_info(void) {return 0;}
> > -#endif
> > -
> > -/* Callback for parsing of the Proximity Domain <-> Memory Area ma=
ppings */
> > -int __init
> > -acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
> > -{
> > -	u64 start, end;
> > -	int node, pxm;
> > -
> > -	if (srat_disabled())
> > -		return -1;
> > -	if (ma->header.length !=3D sizeof(struct acpi_srat_mem_affinity))=
 {
> > -		bad_srat();
> > -		return -1;
> > -	}
> > -	if ((ma->flags & ACPI_SRAT_MEM_ENABLED) =3D=3D 0)
> > -		return -1;
> > -
> > -	if ((ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && !save_add_info()=
)
> > -		return -1;
> > -	start =3D ma->base_address;
> > -	end =3D start + ma->length;
> > -	pxm =3D ma->proximity_domain;
> > -	if (acpi_srat_revision <=3D 1)
> > -		pxm &=3D 0xff;
> > -	node =3D setup_node(pxm);
> > -	if (node < 0) {
> > -		printk(KERN_ERR "SRAT: Too many proximity domains.\n");
> > -		bad_srat();
> > -		return -1;
> > -	}
> > -
> > -	if (numa_add_memblk(node, start, end) < 0) {
> > -		bad_srat();
> > -		return -1;
> > -	}
> > -
> > -	node_set(node, numa_nodes_parsed);
> > -
> > -	printk(KERN_INFO "SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
> > -	       node, pxm,
> > -	       (unsigned long long) start, (unsigned long long) end - 1);
> > -	return 0;
> > -}
> > -
> > -void __init acpi_numa_arch_fixup(void) {}
> > -
> > -int __init x86_acpi_numa_init(void)
> > -{
> > -	int ret;
> > -
> > -	ret =3D acpi_numa_init();
> > -	if (ret < 0)
> > -		return ret;
> > -	return srat_disabled() ? -EINVAL : 0;
> > -}
> >=20
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
