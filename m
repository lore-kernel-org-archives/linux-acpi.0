From: =?iso-8859-2?q?Micha=B3_Pytasz?= <pytasz-cr0FGv58ZLmlPcVs/6D9LQ@public.gmane.org>
Subject: Aspire 1362
Date: Sun, 6 Nov 2005 20:27:02 +0100
Message-ID: <200511062027.03026.pytasz@lodz.home.pl>
Reply-To: pytasz-cr0FGv58ZLmlPcVs/6D9LQ@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HklbDonns/qrNrH"
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

--Boundary-00=_HklbDonns/qrNrH
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Recently (I suppose after kernel upgrade, but I might be wrong) I have=20
noticed, that KDE could not see ACPI - sleep related information. The reaso=
n=20
is missing /proc/acpi/state . After some googling I found that ACPI problem=
s=20
may be buggy DSDT related (unfortunately I got to know that it actually=20
exists this way, so I have no experience in this field).
=46ound some information on how to decompile and fix it, but some errors=20
remained unfixed (and I did not want to mess it up too much):

dsdt.dsl   246:     Method (\_WAK, 1, NotSerialized)
Warning  2026 -                 ^ Reserved method must return a value (_WAK)

dsdt.dsl   486:                     0x0100, 0x00,,)
Error    1094 -                                   ^ Missing ResourceSource=
=20
string (required)

dsdt.dsl   494:                     , TypeStatic)
Error    1094 -                                 ^ Missing ResourceSource=20
string (required)

dsdt.dsl   501:                     , TypeStatic)
Error    1094 -                                 ^ Missing ResourceSource=20
string (required)

dsdt.dsl   508:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   515:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   522:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   529:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   536:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   543:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   550:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   557:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   564:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   571:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   578:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   585:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl  2206:                     Field (ERAM, AnyAcc, Lock, Preserve)
Error    1048 -                               ^ Host Operation Region requi=
res=20
ByteAcc access

dsdt.dsl  4773:                         If (UPBI ())
Error    1029 - Called method returns no value ^

dsdt.dsl  4778:                         If (UPBS ())
Error    1029 - Called method returns no value ^


Having googled I (think I) found how to correct errors in line 2206, changi=
ng=20
AnyAcc to ByteAcc, line 486 deleting 0x00 and a warning (adding return=20
value). Unfortunately I could not find a solution to other problems...
I am attaching the unchanged dsdt.
The laptop is Via K8N800 based.

All help is welcome,
Thanks in advance,

Micha=B3


--Boundary-00=_HklbDonns/qrNrH
Content-Type: application/x-bzip2;
  name="dsdt.dsl.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dsdt.dsl.bz2"

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

--Boundary-00=_HklbDonns/qrNrH--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
