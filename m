From: Jacques GANGLOFF <jacques-gXTsMEhN/Y091FlJP1ih0VAUjnlXr6A1@public.gmane.org>
Subject: VAIO battery info : some more news
Date: Mon, 12 Aug 2002 00:11:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3174.80008020556$1029103958@news.gmane.org>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Here are the latest news about the battery info bug
on my VAIO FX702.

cat /proc/acpi/battery/BAT1/info :

present:                 yes
design capacity:         5 mWh
last full capacity:      5 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 400 mWh
design capacity low:     384 mWh
capacity granularity 1:  64 mWh
capacity granularity 2:  64 mWh
model number:            BAT1
serial number:
battery type:
OEM info:

The debug messages :

Aug  9 22:59:55 mac1gra kernel: [ACPI Debug] Integer: 0000000000000CAA
Aug  9 22:59:58 mac1gra kernel: dsmthdat-0433 [331] Ds_method_data_get_va=
l:
Uninitialized Local[5] at node cfee897c
Aug  9 22:59:58 mac1gra kernel:  dswexec-0404 [327] Ds_exec_end_op       =
 :=20
[AE_NOT_CONFIGURED]: Could not resolve operands, AE_AML_UNINITIALIZED_LOC=
AL
Aug  9 22:59:58 mac1gra kernel: [ACPI Debug] String:=20
------------------------_Q20 : test1
Aug  9 22:59:58 mac1gra last message repeated 3 times
Aug  9 22:59:58 mac1gra kernel: [ACPI Debug] String: Current Temperature =
is=20
----

The result of acpidump is at ftp://eavr.u-strasbg.fr/pub/acpi/dump.out

So it seems to be an AML interpreter problem or a bug in the AML code of =
the
VAIO. I cannot investigate further into this problem. I hope the infos ar=
e
precise enough for someone who knows more about ACPI than me and who
has time to debug this.

Jacques


--=20
 _________________________________
(
)   Jacques GANGLOFF
(   Associate Professor
)   LSIIT / EAVR=09=09=09
(   Bd S=E9bastien Brant=20
)   67400 Illkirch
(   Tel : +33 (0)3 90 24 44 68
)   Fax : +33 (0)3 90 24 44 80
(   http://eavr.u-strasbg.fr
)_________________________________



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
