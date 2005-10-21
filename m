From: marek czardybon <max-MEOeS5c08o1g9hUCZPvPmw@public.gmane.org>
Subject: Re: acer travelmate 2313 battery problem.
Date: Fri, 21 Oct 2005 09:26:00 +0200
Message-ID: <43589808.1080000@inbox.eu.org>
References: <3ACA40606221794F80A5670F0AF15F84041AC211@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC211@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dnia 2005-10-20 17:12, Yu, Luming napisa=B3:
> Please test patch at http://bugzilla.kernel.org/show_bug.cgi?id=3D5322
>=20
> Thanks
> Luming=20
>=20
>=20
[cut]

ehlo.

after applaying this path battery works fine :)

maxik:~# cat /proc/acpi/battery/BAT1/state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mA
remaining capacity:      1873 mAh
present voltage:         0 mV

but as foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org write I've got buggy BIOS.
after decompile my DSDT table ther are errors - today I'll try to fix DSD=
T table ...

I'll send a report after tests ...

THx for help.

with regards.
--=20
marek czardybon / maxilee   +48 0697 724 404       http://inbox.eu.org
GG:3299479 JAB:maxilee-veJsmC5npURmR6Xm/wNWPw@public.gmane.org                  http://outbox.eu.org
ARP: 00:90:CC:43:D8:0D         GCC d? s:- a- C+++ UL++ P++ L++ E--- W+
N+ o K w--- O M- V- PS+ PE+ Y PGP t 5 X+R+ !tv b+ DI- D++ G e h r++ y?



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
