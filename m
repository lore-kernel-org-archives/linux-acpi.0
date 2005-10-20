From: <foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: acer travelmate 2313 battery problem.
Date: Thu, 20 Oct 2005 10:30:40 -0700 (PDT)
Message-ID: <20051020173040.51826.qmail@web81602.mail.yahoo.com>
References: <435764CD.1090700@inbox.eu.org>
Reply-To: foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <435764CD.1090700-MEOeS5c08o1g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: marek czardybon <max-MEOeS5c08o1g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

That's a little bit weird but similar to the problem I had with my
Acer. You will need to build the IASL DSDT compiler and fix your DSDT,
because there is not a fixed one in the ACPI4Linux database yet. But
first, before you try that, try upgrading your BIOS and seeing if that
solves the problem.

Please look here http://forums.gentoo.org/viewtopic.php?t=3D122145 for
ideas. They apply to more than just Gentoo machines.

HTH!

--- marek czardybon <max-MEOeS5c08o1g9hUCZPvPmw@public.gmane.org> wrote:

> Hello.
>=20
> I'm using acer travlemate 2313. I've installed Debian 3.1 on it.
> I've kernel 2.6.13 with acpi-20050902-2.6.13 patch.
> All works fine but without battery.
>=20
> When I load module "battery" battery is detected
>=20
> form dmesg:
> "ACPI: Battery Slot [BAT1] (battery present)"
>=20
> under /proc/acpi I can see battery directory and BAT1 in it.
>=20
> list from it:
>=20
> maxik:/proc/acpi/battery/BAT1# cat state
> present:                 yes
> ERROR: Unable to read battery status
> maxik:/proc/acpi/battery/BAT1# cat alarm
> alarm:                   unsupported
> maxik:/proc/acpi/battery/BAT1# cat info
> present:                 yes
> design capacity:         2000 mAh
> last full capacity:      1873 mAh
> battery technology:      rechargeable
> design voltage:          14800 mV
> design capacity warning: 300 mAh
> design capacity low:     74 mAh
> capacity granularity 1:  32 mAh
> capacity granularity 2:  32 mAh
> model number:            11ZL
> serial number:           3149
> battery type:            LION
> OEM info:                SIMPLO
>=20
> but in dmesg i've:
>=20
> "ACPI: Battery Slot [BAT1] (battery present)
>    psargs-0339: *** Error: Looking up [Z004] in namespace,
> AE_NOT_FOUND
> search_node cddc5628 start_node cddc5628 return_node 00000000
>   dswexec-0460 [2350] ds_exec_end_op        : [Index]: Could not
> resolve=20
> operands, AE_NOT_FOUND
>   psparse-0508: *** Error: Method execution failed [\_SB_.BAT1._BST]
> (Node=20
> cddc5428), AE_NOT_FOUND
> acpi_battery-0205 [2341] battery_get_status    : Error evaluating
> _BST
>    psargs-0339: *** Error: Looking up [Z004] in namespace,
> AE_NOT_FOUND
> search_node cddc5628 start_node cddc5628 return_node 00000000
>   dswexec-0460 [2364] ds_exec_end_op        : [Index]: Could not
> resolve=20
> operands, AE_NOT_FOUND
>   psparse-0508: *** Error: Method execution failed [\_SB_.BAT1._BST]
> (Node=20
> cddc5428), AE_NOT_FOUND
> acpi_battery-0205 [2355] battery_get_status    : Error evaluating
> _BST"
>=20
> And any application can't read status of battery...
>=20
> Any sugestion with this ?
> I've searched google with this problem but I can't find nothing ?
>=20
>=20
> --=20
> marek czardybon / maxilee   +48 0697 724 404     =20
> http://inbox.eu.org
> GG:3299479 JAB:maxilee-veJsmC5npURmR6Xm/wNWPw@public.gmane.org                =20
> http://outbox.eu.org
> ARP: 00:90:CC:43:D8:0D         GCC d? s:- a- C+++ UL++ P++ L++ E---
> W+
> N+ o K w--- O M- V- PS+ PE+ Y PGP t 5 X+R+ !tv b+ DI- D++ G e h r++
> y?
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads,
> discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
