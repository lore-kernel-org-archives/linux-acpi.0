From: FrAnKenstEin <fake-3RXyrymLNR0b1SvskN2V4Q@public.gmane.org>
Subject: After dsdt-fix cpq armada110 battery status still confusing
Date: Mon, 11 Nov 2002 17:14:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021111161425.GA13256@apollo.bingo-ev.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi acpi-devel!

I have problems with my Compaq Armada 110 (since 1 year.. urgh).
I already fixed the common dsdt-subjects (as on http://www.cpqlinux.com/acpi-howto.html)...

but still:
my battery status is confusing me. The AC-Adaptor state is read
correctly, and the BAT1 is informed. After that "inform" my battery's
"remaining capacity" is showed correctly (something a bit lower than
"last full capacity"). but one "cat /proc/acpi/battery/BAT1/status" later
the value gets either zero (ac plugged in and finished loading) or - on
battery power - jumps to 65535 and starts decreasing from there. as it
reaches zero, it restarts from 65535... douh.

plug-in ac, cat.. -> correct value again for one time. 

is the request somehow buffered?

besides this, i am impressed by how much work has been done in the last year
to the acpi-code. keep up the godd work!

greetz,
FAKE
(Thomas Jakobi)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
