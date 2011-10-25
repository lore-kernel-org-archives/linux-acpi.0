From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Convert width in bits to bytes in __acpi_ioremap_fast()
Date: Tue, 25 Oct 2011 07:57:54 -0600
Message-ID: <CAErSpo5cW14d5BM7_XJiL1o2ryamWUO3_uz5LBiyooApdbizQg@mail.gmail.com>
References: <4ea1e75f5296b6c6b@agluck-desktop.sc.intel.com> <4EA62396.2070002@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:29770 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933477Ab1JYN6Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Oct 2011 09:58:16 -0400
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com [172.24.198.77])
	by smtp-out.google.com with ESMTP id p9PDwFAv003062
	for <linux-acpi@vger.kernel.org>; Tue, 25 Oct 2011 06:58:15 -0700
Received: from vws15 (vws15.prod.google.com [10.241.21.143])
	by wpaz13.hot.corp.google.com with ESMTP id p9PDnBrM015101
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 25 Oct 2011 06:58:14 -0700
Received: by vws15 with SMTP id 15so684306vws.10
        for <linux-acpi@vger.kernel.org>; Tue, 25 Oct 2011 06:58:14 -0700 (PDT)
In-Reply-To: <4EA62396.2070002@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Oct 24, 2011 at 8:48 PM, Huang Ying <ying.huang@intel.com> wrot=
e:
> Sorry for late.
>
> On 10/22/2011 05:42 AM, Luck, Tony wrote:
>> Callers to __acpi_ioremap_fast() pass the bit_width that they found =
in the
>> acpi_generic_address structure. Convert from bits to bytes when pass=
ing to
>> __acpi_find_iomap() - as it wants to see bytes, not bits.
>>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> ---
>> =A0drivers/acpi/atomicio.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/acpi/atomicio.c b/drivers/acpi/atomicio.c
>> index 252888f..70ffb71 100644
>> --- a/drivers/acpi/atomicio.c
>> +++ b/drivers/acpi/atomicio.c
>> @@ -78,7 +78,7 @@ static void __iomem *__acpi_ioremap_fast(phys_addr=
_t paddr,
>> =A0{
>> =A0 =A0 =A0 struct acpi_iomap *map;
>>
>> - =A0 =A0 map =3D __acpi_find_iomap(paddr, size);
>> + =A0 =A0 map =3D __acpi_find_iomap(paddr, size/8);
>> =A0 =A0 =A0 if (map)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return map->vaddr + (paddr - map->paddr)=
;
>> =A0 =A0 =A0 else
>
> Good catch! Thanks.
>
> Or change the caller acpi_atomic_read_mem/write_mem?

Myron posted a nice patch recently to remove atomicio.c altogether:
http://marc.info/?l=3Dlinux-acpi&m=3D131733358818849&w=3D2

I haven't seen any response to it, but I think it's a nice approach
and it gets rid of all this special-case pre-map, post-unmap, atomic
read/write stuff.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
