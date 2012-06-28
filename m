From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [RFC PATCH 2/12] memory-hogplug : check memory offline in offline_pages
Date: Thu, 28 Jun 2012 01:26:21 -0400
Message-ID: <CAHGf_=qtt6_EWucC4B8R_jr71UTc9=QTJcDXz8Oo13C_nyu-mQ@mail.gmail.com>
References: <4FEA9C88.1070800@jp.fujitsu.com> <4FEA9DB1.7010303@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48499 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab2F1F0l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jun 2012 01:26:41 -0400
In-Reply-To: <4FEA9DB1.7010303@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, len.brown@intel.com, benh@kernel.crashing.org, paulus@samba.org, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org, wency@cn.fujitsu.com

On Wed, Jun 27, 2012 at 1:44 AM, Yasuaki Ishimatsu
<isimatu.yasuaki@jp.fujitsu.com> wrote:
> When offline_pages() is called to offlined memory, the function fails=
 since
> all memory has been offlined. In this case, the function should succe=
ed.
> The patch adds the check function into offline_pages().

I don't understand your point. I think following misoperation should
fail. Otherwise
administrator have no way to know their fault.

$ echo offline > memoryN/state
$ echo offline > memoryN/state

In general, we don't like to ignore an error except the standard requir=
e it.

>
> CC: Len Brown <len.brown@intel.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Christoph Lameter <cl@linux.com>
> Cc: Minchan Kim <minchan.kim@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> CC: Wen Congyang <wency@cn.fujitsu.com>
> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>
> ---
> =A0drivers/base/memory.c =A0| =A0 20 ++++++++++++++++++++
> =A0include/linux/memory.h | =A0 =A01 +
> =A0mm/memory_hotplug.c =A0 =A0| =A0 =A05 +++++
> =A03 files changed, 26 insertions(+)
>
> Index: linux-3.5-rc4/drivers/base/memory.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-3.5-rc4.orig/drivers/base/memory.c =A0 =A02012-06-26 13:28:=
16.726211752 +0900
> +++ linux-3.5-rc4/drivers/base/memory.c 2012-06-26 13:34:22.423639904=
 +0900
> @@ -70,6 +70,26 @@ void unregister_memory_isolate_notifier(
> =A0}
> =A0EXPORT_SYMBOL(unregister_memory_isolate_notifier);
>
> +bool memory_is_offline(unsigned long start_pfn, unsigned long end_pf=
n)

I dislike this function name. 'memory' is too vague to me.


> +{
> + =A0 =A0 =A0 struct memory_block *mem;
> + =A0 =A0 =A0 struct mem_section *section;
> + =A0 =A0 =A0 unsigned long pfn, section_nr;
> +
> + =A0 =A0 =A0 for (pfn =3D start_pfn; pfn < end_pfn; pfn +=3D PAGES_P=
ER_SECTION) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 section_nr =3D pfn_to_section_nr(pfn);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 section =3D __nr_to_section(section_nr)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mem =3D find_memory_block(section);

This seems to have strong sparse dependency.
Hm, I wonder why memory-hotplug.c can enable when X86_64_ACPI_NUMA.

# eventually, we can have this option just 'select SPARSEMEM'
config MEMORY_HOTPLUG
	bool "Allow for memory hot-add"
	depends on SPARSEMEM || X86_64_ACPI_NUMA


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mem)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mem->state =3D=3D MEM_OFFLINE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return true;
> +}
> +
> =A0/*
> =A0* register_memory - Setup a sysfs device for a memory block
> =A0*/
> Index: linux-3.5-rc4/include/linux/memory.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-3.5-rc4.orig/include/linux/memory.h =A0 2012-06-25 04:53:04=
=2E000000000 +0900
> +++ linux-3.5-rc4/include/linux/memory.h =A0 =A0 =A0 =A02012-06-26 13=
:34:22.424639891 +0900
> @@ -120,6 +120,7 @@ extern int memory_isolate_notify(unsigne
> =A0extern struct memory_block *find_memory_block_hinted(struct mem_se=
ction *,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct memory_block *);
> =A0extern struct memory_block *find_memory_block(struct mem_section *=
);
> +extern bool memory_is_offline(unsigned long start_pfn, unsigned long=
 end_pfn);
> =A0#define CONFIG_MEM_BLOCK_SIZE =A0(PAGES_PER_SECTION<<PAGE_SHIFT)
> =A0enum mem_add_context { BOOT, HOTPLUG };
> =A0#endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
> Index: linux-3.5-rc4/mm/memory_hotplug.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-3.5-rc4.orig/mm/memory_hotplug.c =A0 =A0 =A02012-06-26 13:2=
8:16.743211538 +0900
> +++ linux-3.5-rc4/mm/memory_hotplug.c =A0 2012-06-26 13:48:38.2649404=
68 +0900
> @@ -887,6 +887,11 @@ static int __ref offline_pages(unsigned
>
> =A0 =A0 =A0 =A0lock_memory_hotplug();
>
> + =A0 =A0 =A0 if (memory_is_offline(start_pfn, end_pfn)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0zone =3D page_zone(pfn_to_page(start_pfn));
> =A0 =A0 =A0 =A0node =3D zone_to_nid(zone);
> =A0 =A0 =A0 =A0nr_pages =3D end_pfn - start_pfn;
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org. =A0For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
