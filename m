From: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [Lhms-devel] [PATCH] ACPI based Memory Hotplug DriverPatch Update
Date: Wed, 13 Oct 2004 07:38:49 +0530
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <FEB6C4E97F6CAF41978FB2059D5454180F3914@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Here is the simple summary. Please let me know if you need more
descriptive.

Note:=20
The ACPI based memory hot plug driver patch supports physical hotplug
operations on memory. This driver fields notifications for memory add
and remove operations from firmware and notifies the VM of the affected
memory ranges. Accordingly, this driver also maintains and updates the
states of all the memory ranges. This driver is useful on hardware which
helps firmware generating ACPI events for every physical hotplug
operation of memory boards on the system during runtime.

Thanks & Regards
--Naveen =20


> -----Original Message-----
> From: Dave Hansen [mailto:haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org]
> Sent: Tuesday, October 12, 2004 6:17 PM
> To: S, Naveen B
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; lhms; Tolentino, Matthew E;
Brown,
> Len; tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org
> Subject: Re: [Lhms-devel] [ACPI] [PATCH] ACPI based Memory Hotplug
> DriverPatch Update
>=20
> One more thing, can you give me a short summary of what this patch
does,
> and maybe what kind of hardware it's useful on for the changelog?
>=20
> -- Dave



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
