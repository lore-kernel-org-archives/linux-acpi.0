From: Sebastian Henschel <s.henschel-TGKKaGbebvyzQB+pC5nmwQ@public.gmane.org>
Subject: acpi-patch + kernel 2.4.19
Date: Wed, 7 Aug 2002 23:55:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020807215528.GA646@enigma.daemon.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

hi folx...

did anyone of you try to install the current acpi-patch to the current
linux kernel 2.4.19?

i am very confused, since the structure of the files in linux/drivers/acpi
seems to have changed enormously. on the other hand, acpi from the original
kernel still seems to be quite old (output from dmesg):

ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled

well, and as you can see, acpi claims to be enabled. but there is no
/proc/acpi to be found. even with the stock 2.4.18 a couple of months ago,=
=20
i had at least something in there.

any insights?

cheers,
 sebastian

p.s.: please cc: me or group-reply, i am not on the list, so far.
--=20
::: sebastian henschel
::: code scrambler
::: - OpenPGP compliant key available


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
