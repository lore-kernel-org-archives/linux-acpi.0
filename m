From: Vicente Aguilar <bisente-1mvy7kH9/DBBDgjK7y7TUQ@public.gmane.org>
Subject: Ocasional hangs
Date: 20 Dec 2002 22:58:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1040421498.8318.396.camel@wintermute.bisente.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: linuxpresario900 <linuxpresario900-+vy+FFr6rAI3CPJRO4ggG/Z8FUJU4vz8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi lists

I've been experiencing ocasional system hangs for some time now, with
kernels 2.4.19 and 20 and the latests ACPI patches of the moment. After
using the computer for a few hours (2-3 maybe) it just hangs, the system
doesn't even responds to pings over the network, and you can hear de
fans go full speed as if the CPU has gone to 100% capacity (this is on a
laptop, a Compaq Presario 905EA).

I think it is related to ACPI, here's why: with acpi-20021205 these
hangs were really easy to reproduce by just doing a simple cat of
/proc/acpi/battery/stat. You read the proc file, then the system hanged,
as simple as that. With all the others acpi patches the hangs have been
and are (now with 2.4.20 and acpi-20021212) *very* ocasional, but I've
done the following experiment: I usually use Gnome and have the
battstat-applet loaded. I find weird that such a simple program (it just
reads the battery stats every now and then) uses 3% of the CPU (a Mobile
Athlon XP 1500+). I've tried unloading the applet, and right now I've
got an uptime of almost 9 hours, while before the system should have
already crashed.

I know that the battstat applet eating 3% of the CPU is maybe only
battstat's fault, but I think that the system hangs may be related and
being caused by ACPI when someone reads the battery status. Anyway if
this theory was true, it only hangs *sometimes* when you read the batt
stats, as the applet is running and checking them often and the system
only crashes after a couple of hours, so it's hard to reproduce the
situation.

I would also like to note that maybe this isn't really ACPI's fault, as
the hardware in this laptop isn't still fully supported by Linux. Maybe
the bug is somewhere else but it is ACPI who triggers it.

Anyway, I know all this info is very vague for a bug report, but if
maybe someone else could reproduce the situation with the same laptop or
even another system...


-- 
 Vicente Aguilar <bisente-1mvy7kH9/DBBDgjK7y7TUQ@public.gmane.org> | http://www.bisente.com



-------------------------------------------------------
This SF.NET email is sponsored by:  The Best Geek Holiday Gifts!
Time is running out!  Thinkgeek.com has the coolest gifts for
your favorite geek.   Let your fingers do the typing.   Visit Now.
T H I N K G E E K . C O M        http://www.thinkgeek.com/sf/
