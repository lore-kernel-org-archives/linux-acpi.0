From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: acpidump replaces acpidmp
Date: Wed, 27 Jul 2005 11:00:45 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300428C3AB@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: Voluspa <voluspa-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

feel free to send me a patch to fix it.

thanks,
-Len=20

>-----Original Message-----
>From: Voluspa [mailto:voluspa-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org]=20
>Sent: Wednesday, July 27, 2005 9:45 AM
>To: Thomas Renninger
>Cc: Brown, Len; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] Re: acpidump replaces acpidmp
>
>
>24 -r--------  1 root root   24136 Jul 27 14:47 dsdt
>28 -rw-r--r--  1 root root   24743 Jul 27 14:52 dsdt.acpidump
>
>OK, I now know that acpidump gives me both fadt and dsdt and something
>more, hence the difference. But this is usability madness; 1) The
>documentation of program switches, Both README and source,=20
>swing between
>mildly accurate and inaccurate; 2) Having to dump/decode in several
>steps here (not really knowing if you've made an error) and then later
>in iasl as well.
>
>Compared to just copying dsdt from /proc and following all the=20
>tutorials
>online on how to modify it, this hackery is not sane.
>
>Mvh
>Mats Johannesson
>--
>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
