From: Sergio Monteiro Basto <sergio-qOf5bGQp09kptuEoxK/DLR2eb7JE58TQ@public.gmane.org>
Subject: Re: CONFIG_PM, CONFIG_ACPI, CONFIG_ACPI_SLEEP
Date: Thu, 10 Mar 2005 08:38:06 +0000
Message-ID: <1110443886.5721.18.camel@bastov>
References: <1110394955.9337.48.camel@d845pe>
	 <1110406503.8870.36.camel@desktop.cunningham.myip.net.au>
Reply-To: sergio-qOf5bGQp09kptuEoxK/DLR2eb7JE58TQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-BRBA428OMdHbD5xvaZXa"
In-Reply-To: <1110406503.8870.36.camel-r49W/1Cwd2ff0s6lnCXPX/uOuaPYTxhvJwvTLr3MMZM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-BRBA428OMdHbD5xvaZXa
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi, I had write about it on Apr/May 2004,

Because "Accidentally, I compile ACPI without CONFIG_PM on one Dell
something dual Pentium III and power off didn't work."=20

For me this was a bug that has been introduced when ACPI enter in 2.4
because, before that, if I recall correctly =20
"we couldn't compile ACPI without define CONFIG_PM"

Conclusion, to simplify, on kernel configuration, I propose to force
that (for compile ACPI we need define CONFIG_PM) (again?) with this
little patch on attach.=20

thanks,

On Thu, 2005-03-10 at 09:15 +1100, Nigel Cunningham wrote:
> Hi.
>=20
> On Thu, 2005-03-10 at 06:02, Len Brown wrote:
> > Today it is possible to build with
> > CONFIG_PM=3Dn
> > CONFIG_ACPI=3Dy
> > (however, CONFIG_ACPI_SLEEP does depend on CONFIG_PM)
> >=20
> > Seems that the solution to the kexec poweroff issue
> > is simpler if ACPI can depend on CONFIG_PM being present:
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D4041
> >=20
> > Why shouldn't CONFIG_ACPI depend on CONFIG_PM
> > Why shouldn't CONFIG_ACPI_SLEEP simply be CONFIG_ACPI
> >=20
> > I can't think of any good reasons not to simplify here, can you?
>=20
> That sounds confusing to me. I thought that ACPI was much more than jus=
t
> power management. Doesn't it include IRQ routing, device enumeration an=
d
> so on too?

yes, but we can say "ACPI without PM doesn't exist"

>=20
> Regards,
>=20
> Nigel
--=20
S=E9rgio M.B.

--=-BRBA428OMdHbD5xvaZXa
Content-Disposition: attachment; filename=configopti-24.diff
Content-Type: text/x-patch; name=configopti-24.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.4.26s/arch/i386/config.in.orig	2004-04-29 23:38:38.000000000 +0100
+++ linux-2.4.26s/arch/i386/config.in	2004-04-29 23:40:58.000000000 +0100
@@ -360,7 +360,7 @@
 bool 'Power Management support' CONFIG_PM
 
 dep_tristate '  Advanced Power Management BIOS support' CONFIG_APM $CONFIG_PM
-if [ "$CONFIG_APM" != "n" ]; then
+if [ "$CONFIG_APM" != "n" -a "$CONFIG_PM" = "y" ]; then
    bool '    Ignore USER SUSPEND' CONFIG_APM_IGNORE_USER_SUSPEND
    bool '    Enable PM at boot time' CONFIG_APM_DO_ENABLE
    bool '    Make CPU Idle calls when idle' CONFIG_APM_CPU_IDLE
@@ -370,7 +370,9 @@
    bool '    Use real mode APM BIOS call to power off' CONFIG_APM_REAL_MODE_POWER_OFF
 fi
 
-source drivers/acpi/Config.in
+if [ "$CONFIG_PM" = "y" ]; then
+	source drivers/acpi/Config.in
+fi
 
 endmenu
 

--=-BRBA428OMdHbD5xvaZXa--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
