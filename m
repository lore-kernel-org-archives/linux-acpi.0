From: Jacques GANGLOFF <jacques-gXTsMEhN/Y091FlJP1ih0VAUjnlXr6A1@public.gmane.org>
Subject: Wrong battery info
Date: Mon, 05 Aug 2002 01:45:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D4DBC7D.3060608@eavr.u-strasbg.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

I tried the latest acpi patch with a 2.4.18 kernel on a VAIO
FX 702. I runs quite smoothly but I have a little problem that
prevents akpi (battery monitor) to work properly.


The result of cat /proc/acpi/battery/BAT1/info is :

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

I suppose that the design capacity and the last full capacity
are wrong, like the model number, serial number, battery type and OEM
info.

I would like to dig into this problem, but I need some hints since
I am completely newbie with acpi.

Thanks for your help.
Jacques

--=20
 _________________________________
(
)   Jacques GANGLOFF
(   Associate Professor
)   LSIIT / EAVR		=09
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
