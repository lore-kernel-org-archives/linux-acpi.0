From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: [PATCH] Re: Linux 2.4.23-pre6 fix make xconfig
Date: 06 Oct 2003 05:58:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1065416298.1634.12.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-QtCayqDf4TmhutyAshrl"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-QtCayqDf4TmhutyAshrl
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi
Finally, I found what is fucking (at least with redhat 7.3 :) the make
xconfig in Linux 2.4.23-pre6.=20


I just don't know what patch do you prefer ?
Please apply one of then=20
I prefer the first.=20

thanks
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.

--=-QtCayqDf4TmhutyAshrl
Content-Disposition: attachment; filename=config2.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=config2.diff; charset=ISO-8859-1

--- linux-2.4.23-pre6/drivers/acpi/Config.in.orig	Mon Oct  6 05:35:24 2003
+++ linux-2.4.23-pre6/drivers/acpi/Config.in	Mon Oct  6 05:43:29 2003
@@ -32,7 +32,8 @@
     tristate     '  Toshiba Laptop Extras'	CONFIG_ACPI_TOSHIBA
     bool         '  Debug Statements'	CONFIG_ACPI_DEBUG
     bool         '  Relaxed AML Checking'	CONFIG_ACPI_RELAXED_AML
-  else if [ "$CONFIG_SMP" =3D "y" ]; then
+  else=20
+  	if [ "$CONFIG_SMP" =3D "y" ]; then
       define_bool CONFIG_ACPI_BOOT		y
     fi
   fi

--=-QtCayqDf4TmhutyAshrl
Content-Disposition: attachment; filename=config3.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=config3.diff; charset=ISO-8859-1

--- linux-2.4.23-pre6/drivers/acpi/Config.in.orig	Mon Oct  6 05:35:24 2003
+++ linux-2.4.23-pre6/drivers/acpi/Config.in	Mon Oct  6 05:44:40 2003
@@ -35,7 +35,6 @@
   else if [ "$CONFIG_SMP" =3D "y" ]; then
       define_bool CONFIG_ACPI_BOOT		y
     fi
-  fi
=20
   endmenu
=20

--=-QtCayqDf4TmhutyAshrl--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
