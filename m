From: "Andreas Leppert" <wudmx-S0/GAf8tV78@public.gmane.org>
Subject: ACPI_OS_NAME: no battery or no ac_adapter
Date: Fri, 17 Sep 2004 15:04:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1569441742@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

hi,

i've a strange problem on my fujitsu laptop.  If i compile my kernel using=
 acpi, everything works fine, but acpi -V doesn't change the value of ac=5Fa=
dapter info. it's always set to "on-line". it doesnt matter if the ac=5Fadap=
ter is plugged in or not. always "on-line".=20

then i found this: http://sourceforge.net/mailarchive/message.php=3Fmsg=5Fid=3D8=
560832

so i changed the value of ACPI=5FOS=5FNAME in my /usr/src/linux/include/acpi/p=
latform/aclinux.h from "Linux" to "Microsoft Windows NT". Now, ac=5Fadapter =
changes its value from "on-line" to "off-line" if i unplug the ac=5Fadapter.=
=20

But now, acpi -V doesnt show me any battery information. the line is just =
omitted! so what to do=3F

under http://andileppert.de/dsdtl.dsl you can find my dsdt. you will see t=
hat there are a few =5FOS commands...  what can i do=3F this is a strange thin=
g...=20

thanks in advance
Andi Leppert
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Mit WEB.DE FreePhone=AE mit h=F6chster Qualit=E4t ab 0 Ct./Min.
weltweit telefonieren! http://freephone.web.de/=3Fmc=3D021201



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
