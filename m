From: Andrew Barr <andrew.james.barr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Battery status lost: AE_OWNER_ID_LIMIT errors in syslog
Date: Tue, 02 Aug 2005 13:32:41 -0400
Message-ID: <pan.2005.08.02.17.32.40.912783@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

Hi.

I am having the same problems as this fellow:

http://article.gmane.org/gmane.linux.acpi.devel/14110

Basically, after my laptop (ThinkPad R51, Intel graphics and chipset) has
been up for some time messages like these begin to flood the kernel logs:

ACPI-0105: *** Error: Could not allocate new owner_id (32 max),
AE_OWNER_ID_ LIMIT=20

ACPI-0509: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BI F] (Node cf44b820), AE_OWNER_ID_LIMIT

This is certainly a new problem--this never happened before kernel 2.6.12=
,
although it was a problem before ACPI 20050729.

And as a result programs can no longer query battery status, the GNOME
battery panel applet turns to an exclaimation point and (particularly
annoying) the sleepd[1] daemon attempts to put the laptop to sleep, even
though the battery is not low. The kernel is 2.6.12.3 with latest ACPI
patch (20050729) and suspend2 2.1.9.9.

This happens after a session has been active for some time--either if the
computer has been on for some time or a while after I've resumed from
suspend-to-disk or suspend-to-RAM.

Any help with this problem would be appreciated.

--
Andrew Barr
andrew.james.barr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

[1] sleepd puts a laptop to sleep after a certain amount of idle time
(measured by keyboard & mouse interrupts) or if the battery falls below a
certain threshold. It supports APM *and* ACPI. Homepage here:
http://kitenet.net/programs/sleepd/



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
