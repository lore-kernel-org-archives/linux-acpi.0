From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: 2.6.12-rc3-mm2: ACPI problems
Date: Thu, 26 May 2005 00:08:00 -0700
Message-ID: <20050526000800.66c42b6b.akpm@osdl.org>
References: <20050430164303.6538f47c.akpm@osdl.org>
	<200505011456.38744.rjw@sisk.pl>
	<4274DC95.6080208@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4274DC95.6080208-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Brice Goglin <Brice.Goglin-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Brice Goglin <Brice.Goglin-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org> wrote:
>
> Rafael J. Wysocki a =E9crit :
> > Hi,
> >=20
> > On Sunday, 1 of May 2005 01:43, Andrew Morton wrote:
> >=20
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc=
3/2.6.12-rc3-mm2/
> >=20
> >=20
> > I have two ACPI-related problems with this kernel (they have also been =
present
> > in the previous -mm, so please treat this report as a "the issue is sti=
ll there" kind
> > of thing):
>=20
> I'm also seeing a (small) problem with ACPI for a few -mm kernels
> (at least since -rc2-mm2, IIRC).
> I don't have a /proc/acpi/button/ anymore.
> My computer is a Compaq Evo N600c laptop.
> ACPI is generally working great here.
>=20
> In 2.6.12-rc3, I have:
> /proc/acpi/button/lid/C1A4/info
> /proc/acpi/button/lid/C1A4/state
> /proc/acpi/button/power/PWRF/info
> /proc/acpi/button/sleep/C1A3/info
> Nothing in rc3-mm1 (even no /proc/acpi/button/ directory).
>=20
> I didn't find any interesting difference between dmesg from rc3 and
> rc3-mm1. Both show these lines:
> ACPI: Power Button (FF) [PWRF]
> ACPI: Sleep Button (CM) [C1A3]
> ACPI: Lid Switch [C1A4]
>=20

Is this one still occurring in 2.6.12-rc5 and/or 2.6.12-rc5-mm1?


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
