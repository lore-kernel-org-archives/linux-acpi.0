From: "Joshua Wright" <Joshua.Wright-n9mZ8N9waow@public.gmane.org>
Subject: Battery management on Compaq Evo N800V
Date: Fri, 6 Dec 2002 09:22:26 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <156AA90517398D479A3473C35CE99EDD0109F6@pvdexc99.jwu.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
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

I recently acquired a Compaq Evo N800v laptop and am struggling to get =
battery monitoring to work.

I've patched the 2.4.20 kernel with the drivers from =
sf.net/projects/acpi successfully (acpi-20021126) and see some activity =
in /proc/acpi for fan, processor, thermal control, etc.  In =
/proc/acpi/battery there are no files.  Accordingly, I don't have a way =
to do battery monitoring.  I do have CONFIG_ACPI_BATTERY set in my =
kernel configuration.

I tried using 2.5.50 with ACPI support as well but got the same results =
- some ACPI functionality but no battery monitoring.

Has anyone else experienced a similar situation and can offer some =
advice?  I'm very happy with the other ACPI support, but battery =
monitoring is an important feature to me that I'd like to get working.

Many thanks.

-Joshua Wright
Team Leader, Networks and Systems
Johnson & Wales University
Joshua.Wright-n9mZ8N9waow@public.gmane.org=20
http://home.jwu.edu/jwright/

pgpkey: http://home.jwu.edu/jwright/pgpkey.htm
fingerprint: FDA5 12FC F391 3740 E0AE BDB6 8FE2 FC0A D44B 4A73



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
