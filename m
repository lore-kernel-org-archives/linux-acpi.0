From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: /proc/battery empty on Gateway 400VTX
Date: Thu, 9 Oct 2003 16:02:28 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8E84D7A@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Casey Harkins <charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Because lack ECDT, your dmesg shows:
>evregion-0249 [22] ev_address_space_dispa: no handler for =
region(df5e4c68) [EmbeddedControl]
> exfldio-0269 [21] ex_access_region      : Region EmbeddedControl(3) =
has no handler
> psparse-1121: *** Error: Method execution failed [\_SB_.BAT0._STA] =
(Node df5e9108), AE_NOT_EXIST
so your /proc/acpi/battery is empty.

I can't find a tool to create an ECDT. But in your dsdt, I get:
>EC_CONTROL: 0x62
>EC_DATA: 0x66
>GPE: 29
>ID: \_SB_.PCI0.LPCB.H_EC
Your ECDT should include above info. Manually create one?

Thanks,
Shaohua


-----Original Message-----
From: Casey Harkins [mailto:charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org]=20
Sent: 2003=C4=EA10=D4=C29=C8=D5 3:16
To: Li, Shaohua
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: RE: [ACPI] /proc/battery empty on Gateway 400VTX



On Wed, 8 Oct 2003, Li, Shaohua wrote:
>
> Hi,
>    Your BIOS lacks ECDT. Maybe you should provide an ECDT according to =
EC device.
>
> Thanks,
> Shaohua


How would I go about doing this? I'll google around a bit and see what I
can figure out.

-casey




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
