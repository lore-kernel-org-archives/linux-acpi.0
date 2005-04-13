From: "Protasevich, Natalie" <Natalie.Protasevich-8PZ5lytb3wbQT0dZR+AlfA@public.gmane.org>
Subject: RE: [Hotplug_sig] RE: [PATCH 1/6]sep initializing rework
Date: Tue, 12 Apr 2005 19:04:20 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04AB8@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Zwane Mwaikambo <zwane-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

=20
> I forgot to mention that while working on the patch,
> I found a problem with ACPI driver while counting number of records=20
> in acpi_table_parse_madt_family() (drivers/acpi/tables.c).=20
> It always returns 0 for the number of records, so this should be=20
> fixed for my patch to work properly, since I rely on number of=20
> lapic entries found by ACPI. I am going to post a bugzilla on this,=20
> for now it worked for me as follows:
>    while (((unsigned long) entry) + sizeof(acpi_table_entry_header) <
madt_end) {
>                if (entry->type =3D=3D entry_id &&
>	 -            (!max_entries || count++ < max_entries)=20
>       +            ((count++ < max_entries) || !max_entries))
> (it wasn't incrementing count if max_entries are >0 ).

Please disregard this: I couldn't reproduce it anymore, looks like it
only happened on one system (I cannot remember on which one) and seems
to work OK without the fix on any machine I'm trying it now...

Thanks,
--Natalie=20


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
