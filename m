From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: Re: the incremental patch 20030521-20030528
Date: 29 Mar 2003 23:52:43 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1048981964.1501.5.camel@darkstar.portugal>
References: <F760B14C9561B941B89469F59BA3A847E96D8E@orsmsx401.jf.intel.com>
	<20030329151604.GA19676@hell.org.pl>
	<1048970727.1944.76.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1048970727.1944.76.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

diff -Nur linux-2.4.21-pre50321/drivers/net/Config.in
linux-2.4.21-pre50328/drivers/net/Config.in
--- linux-2.4.21-pre50321/drivers/net/Config.in Sun Mar 23 17:09:43 2003
+++ linux-2.4.21-pre50328/drivers/net/Config.in Sun Mar 23 04:11:11 2003
@@ -185,7 +185,7 @@
       dep_tristate '    Davicom DM910x/DM980x support' CONFIG_DM9102
$CONFIG_PCI
       dep_tristate '    EtherExpressPro/100 support (eepro100, original
Becker driver)' CONFIG_EEPRO100 $CONFIG_PCI
       if [ "$CONFIG_VISWS" =3D "y" ]; then
-         define_bool CONFIG_EEPRO100_PIO y
+         define_mbool CONFIG_EEPRO100_PIO y
       else
          dep_mbool '      Use PIO instead of MMIO' CONFIG_EEPRO100_PIO
$CONFIG_EEPRO100
       fi

You should clean this part from the patch,
this bug cames with kernel.2.4.20 !!, define_mbool doens't exits so, if
you an error runnig make xconfig . you must edit drivers/net/Config.in
and delete m in line 188.

and btw no more problems with the error message "Failed to acquire
semaphore" would appear during operations on the embedded controller
(EC).=20
The acpi20030528 works normally.

On Sat, 2003-03-29 at 20:45, S=E9rgio Monteiro Basto wrote:
> Make the incremental patch is easy: apply the old patch to kernel and
> the new patch to a copy of same kernel version, clean orig (and rej)
> files and make the diff -Nur.=20
>=20
> so here is the result, and don't test is yet.
>=20
>=20
> On Sat, 2003-03-29 at 15:16, Karol Kozimor wrote:
> > Thus wrote Grover, Andrew:
> > > Fixed a problem where the error message "Failed to acquire semaphore"
> > > would appear during operations on the embedded controller (EC).=20
> >=20
> > Thanks for that!
> > I have one question though. Did you consider doing incremental ACPI
> > patches? I'm using a heavily patched kernel with XFS filesystem support=
,
> > and getting all these patches to work and applying all the rejects manu=
ally
> > is a real pain. Incremental patches would really make life (mine, at le=
ast)=20
> > easier. What do you think about it?
> >=20
> > (the above refers to the 2.4 kernel, with 2.5 changing so fast it isn't
> > really a problem)
> >=20
> > Best regards,
> >=20
> > --=20
> > Karol 'sziwan' Kozimor
> > sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.net email is sponsored by:
> > The Definitive IT and Networking Event. Be There!
> > NetWorld+Interop Las Vegas 2003 -- Register today!
> > http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> --=20
> S=E9rgioMB
> email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
>=20
> Who gives me one shell, give me everything.
--=20
S=E9rgio Basto
Technology Project Manager
onevision design studios
Rua Prof. Mota Pinto
42F-S2.30
4100-353 PORTO
tel. + 351 22 532 0300
fax. + 351 22 616 0182
email: sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org
web: http://www.onevision-design.com
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
