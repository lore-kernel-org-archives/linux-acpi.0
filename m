From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: acpidump replaces acpidmp
Date: Fri, 22 Jul 2005 20:35:38 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30041F3DFE@hdsmsx401.amr.corp.intel.com>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: kmannth-gknP4MEHMBDQT0dZR+AlfA@public.gmane.org, "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Alexey has provided an improved acpidump.
Now available in the pmtools archive dated today or later:
(give it an hour to hit the mirrors)

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Note that we've returned to the original spelling "acpidump",
and "acpidmp" has been deleted.  I'm now trying to teach my
fingers how to spell correctly again:-)

acpidump with no parameters gives you the same output
that the previous program gave you.  However, it can
also take parameters to dump tables from an arbitrary
address, and it works on 64-bit systems.

Give it a go and do speak up if you have any troubles with it.
The old version is still in the 2003 pmtools archive if
you need it.

thanks Alexey!

-Len

ps. I shall delete /proc/fadt and /proc/dsdt when I return
from Ottawa unless somebody can convince me they should live.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
