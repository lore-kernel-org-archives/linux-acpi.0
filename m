From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 26-stable is now based on linux-2.6.9
Date: Thu, 11 Nov 2004 14:10:48 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3001F9927E@hdsmsx401.amr.corp.intel.com>
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
To: Sebastian Henschel <shensche-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>From: Sebastian Henschel [mailto:shensche-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]=20

>> This note announces that the 26-stable trees are now based=20
>> on 2.6.9, and that I'll not be producing any new patches against
2.6.8.1.
>
>hm, i cannot see the plain patches 26-(stable|latest)-test in the
>directory mentioned above. perhaps these are only available as bk
>patches?

yes, you're right.

I used to regularly publish individual plain patches under
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test
but I stopped doing that when bkbits added the feature
to export plain patches directly -- and nobody has complained.

One thing that I don't do that maybe I should is export
plain consolidated patches for -test like I do for -release.
However, in practice Linus pulls from -release so quickly that
I can usually start staging the next batch there within a day or two
of my pull request; so except for a couple of corner cases and
the delay between my pull request and Linus's pull, the -test
and -release plain patches would be identical.

-Len


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
