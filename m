From: Gunter Ohrner <G.Ohrner-6V9naDJErT6662+jY7v6MhvVK+yQ3ZXh@public.gmane.org>
Subject: misc. ACPI problems
Date: Sat, 3 May 2003 22:02:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305032202.44382@mail.CustomCDROM.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Description: clearsigned data
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

I use ACPI on my laptop (Acer Travelmate 612TX, PII-Mobile 900MHz, i815
chipset) for quite some time now and it has worked well but never perfectly,
which I thought was partly caused by a malformed DSDT. Today I updated to
Linux 2.4.21-rc1 to try the latest swsusp patch and fetched the latest ACPI
patch (20030424) and fixed my DSDT in one go. Now the DSDT compiles without
errors, there are only three warnings like

dsdt.dsl  1778:                         EXCG ()
Warning  2079 -   Statement is unreachable ^

left, caused by the EXCG statements being placed directly AFTER an
unconditional return in their functions. (I cp-ed the dsdt from
/proc/acpi/dsdt, dis- and re-assembled it using the latest iasl and fixed it
using information I found at http://www.cpqlinux.com/acpi-howto.html. The
errors I had were "Warning 2026 - Reserved method must return a value" and
"Error 1051 - Access width of Field Unit extends beyond region limit" in so=
me
kind of "union"-array.)

Nevertheless I still get a single ACPI error in my boot messages (All others
are gone now.):

ACPI: Lid Switch [LID]
acpi_processor-2117 [26] acpi_processor_get_inf: Invalid PBLK length [5]
ACPI: Processor [CPU0] (supports C1)

Most (all?) stuff works as before and pretty well - except:
acpi/fan and acpi/power_ressource are completely empty, the CPU does not
support ACPI throtteling (I can control speedstep using cpufreq), the batte=
ry
does always report "0" as the charging/discharging rate (leading to lots of
interesting effects in the graphical acpi monitors I tried and rendering
KDE's emergency shutdown feature unusuable - it works "remaining time" and
not "remaining capacity" based.) and ACPI spams my kernel message buffer and
some log files with the following messages:

May  3 00:25:42 Zweiblum kernel: [ACPI Debug] String: SYST of _TMP =3D
May  3 00:25:42 Zweiblum kernel: [ACPI Debug] Integer: 0000000000000026
May  3 00:25:44 Zweiblum kernel: [ACPI Debug] String: SYST of _TMP =3D
May  3 00:25:44 Zweiblum kernel: [ACPI Debug] Integer: 0000000000000026

every 2 seconds.

Zweiblum:/proc/acpi# cat battery/BATA/state
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            0 mW
remaining capacity:      2848 mWh
present voltage:         12492 mV
Zweiblum:/proc/acpi# cat battery/BATA/state
present:                 yes
capacity state:          ok
charging state:          charging
present rate:            0 mW
remaining capacity:      2084 mWh
present voltage:         12492 mV
Zweiblum:/proc/acpi#

Is there any way for me to fix some of these remaining problems (especially
I'd like to do something about the "(dis)charge rate" value reported) or wi=
ll
I have to live with it?

Thanks a lot in advance,

  Gunter

=2D --=20
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+                   PGP-verschl=FCsselte Mails bevorzugt!                 +
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
He had a unique stride: it looked as though his body was being dragged=20
forward and his legs had to flail around underneath it, landing wherever=20
they could find room. It wasn't so much a walk as a collapse,=20
indefinitely postponed.        -- (Terry Pratchett, Maskerade)
+-+-+-+-+-+-+-+-+-+-+-+-+ http://www.lspace.org +-+-+-+-+-+-+-+-+-+-+-+-+
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tCBh0ORHvREo8l8RAn4zAJwKIcIiQYW9S1aFWuxBqngVNJoPsACbBwmj
Qn44Q0OLkfCfvJhBAbzvdHo=3D
=3DMOiB
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
