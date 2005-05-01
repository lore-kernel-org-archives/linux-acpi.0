From: Brice Goglin <Brice.Goglin-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>
Subject: Re: 2.6.12-rc3-mm2: ACPI problems
Date: Sun, 01 May 2005 15:41:41 +0200
Message-ID: <4274DC95.6080208@ens-lyon.org>
References: <20050430164303.6538f47c.akpm@osdl.org> <200505011456.38744.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200505011456.38744.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Rafael J. Wysocki a =E9crit :
> Hi,
>=20
> On Sunday, 1 of May 2005 01:43, Andrew Morton wrote:
>=20
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc=
3/2.6.12-rc3-mm2/
>=20
>=20
> I have two ACPI-related problems with this kernel (they have also been =
present
> in the previous -mm, so please treat this report as a "the issue is sti=
ll there" kind
> of thing):

I'm also seeing a (small) problem with ACPI for a few -mm kernels
(at least since -rc2-mm2, IIRC).
I don't have a /proc/acpi/button/ anymore.
My computer is a Compaq Evo N600c laptop.
ACPI is generally working great here.

In 2.6.12-rc3, I have:
/proc/acpi/button/lid/C1A4/info
/proc/acpi/button/lid/C1A4/state
/proc/acpi/button/power/PWRF/info
/proc/acpi/button/sleep/C1A3/info
Nothing in rc3-mm1 (even no /proc/acpi/button/ directory).

I didn't find any interesting difference between dmesg from rc3 and
rc3-mm1. Both show these lines:
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C1A3]
ACPI: Lid Switch [C1A4]

Any idea ?

Thanks
Brice


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, =
4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=3D20
