From: Bob Lees <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>
Subject: disasm/compile doesn't work
Date: Mon, 14 Oct 2002 21:47:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210142147.04742.bob@diamond.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi mail list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi

This may have been asked/aired before, in which case I apologise.  Howeve=
r=20
here goes.

I have sort of successfully disassembled/decompiled the dsdt from my evo =
800c,=20
using both pacpidump and iasl.  They both produce the same outcome.   By=20
"sort of" I mean that I cannot disassemble and immdeiately recompile with=
out=20
errors.  Some of them are basic to the compaq dsdt in that it references=20
*PNP???? rather than PNP????.  That is easy to fix.  The other problem is=
=20
that objects are disassembed which have no definition.  This is much hard=
er=20
as it is not clear how these undefined objects should be defined.  Is thi=
s a=20
common problem and does a reasonable fix exist? and if so help!

For the present I have commented out the offending references, but this m=
eans=20
that I have no fan control!! which may not be good in the long term:)

Regards

Bob
--=20
Bob Lees
Diamond Consulting Services Ltd
Aylesbury, Bucks, HP17 8UG
Phone: +44 (0) 1296 747667
Fax: +44 (0) 1296 747557
email: bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
