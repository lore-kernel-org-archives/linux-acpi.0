From: Brice Goglin <Brice.Goglin-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>
Subject: Re: 2.6.12-rc3-mm2: ACPI problems
Date: Thu, 26 May 2005 09:22:08 +0200
Message-ID: <42957920.7010807@ens-lyon.org>
References: <20050430164303.6538f47c.akpm@osdl.org>	<200505011456.38744.rjw@sisk.pl>	<4274DC95.6080208@ens-lyon.org> <20050526000800.66c42b6b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050526000800.66c42b6b.akpm-3NddpPZAyC0@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 (Andrew Morton a =E9crit :
> Brice Goglin <Brice.Goglin-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org> wrote:
>=20
>>I'm also seeing a (small) problem with ACPI for a few -mm kernels
>>(at least since -rc2-mm2, IIRC).
>>I don't have a /proc/acpi/button/ anymore.
>>My computer is a Compaq Evo N600c laptop.
>>ACPI is generally working great here.
>>
>>In 2.6.12-rc3, I have:
>>/proc/acpi/button/lid/C1A4/info
>>/proc/acpi/button/lid/C1A4/state
>>/proc/acpi/button/power/PWRF/info
>>/proc/acpi/button/sleep/C1A3/info
>>Nothing in rc3-mm1 (even no /proc/acpi/button/ directory).
>>
>>I didn't find any interesting difference between dmesg from rc3 and
>>rc3-mm1. Both show these lines:
>>ACPI: Power Button (FF) [PWRF]
>>ACPI: Sleep Button (CM) [C1A3]
>>ACPI: Lid Switch [C1A4]
>>
>=20
>=20
> Is this one still occurring in 2.6.12-rc5 and/or 2.6.12-rc5-mm1?

This problem is only is -mm (still in rc5-mm1),
not in any -rc (especially not -rc5).

I didn't get any response about this report. But, looking at
the code, I finally thought that's a feature, not a bug.
The entire code for this /proc/acpi/buttons disappeared
from drivers/acpi/buttons.c
So I guess ACPI guys wanted to drop it ?

Button events are still reported well in /proc/acpi/events.
I don't need anything more.

Thanks,
Brice


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
