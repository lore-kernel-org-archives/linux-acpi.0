From: Alexander Gran <alex-4mRm4CWMOdkHuPwBo6/EyUB+6BGkLq7r@public.gmane.org>
Subject: Status of ACPI on IBM T40p
Date: Wed, 4 Feb 2004 15:07:32 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402041507.33902@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Description: clearsigned data
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Andrew Morton <akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I just gave ACPI an other try this night. This are my results:
I used linux-2.6.2-rc3-mm1 on a T40p 2373-G1G.
Config: http://zodiac.dnsalias.org/misc/262-rc3-mm1.acpi.config
Errors: http://zodiac.dnsalias.org/misc/syslog.acpi
lspci -v (on APM kernel): http://zodiac.dnsalias.org/misc/lspci

Booting is ok. All ACPI modules load without warning, only the relaxed AML=
=20
seems to be needed.
What's working:
Battery monitoring, thermal monitoring, ac-adapter, lid-button are all ok.
The sound-system survives a suspend. Great.
laptop_mode is in this kernel, finally. Cool, Andrew!
=46an isn't recognized. Power-button is recognized, but gives no events.
C-states are not working right:
The CPU has C0-C3. C0 is full speed, the rest is slower. According to the A=
CPI=20
documentation the CPU should switch automagically to the slower modes after=
=20
some time of inactivaty. However it cannot controll busmaster PCI transfers=
=20
in C3. Now some driver doesn't gets busmaster right, and due to this, the c=
pu=20
never go's to C3 [Hope I got this right, I am no acpi master..](my went to =
C3=20
after some fiddeling with suspend (see later) and the PCI-Bus crashed, henc=
e=20
I know. If my CPU uses C3, laptop_mode and backlight  mostly dimmed, I=20
reached 5h+ :)
Other things that don't work:
When suspending, the USB-drivers don't get it right, and do not work after=
=20
resuming. Unloading them before suspending and loading them afterwards=20
doesn't help either. Additionally there seems to be issues with the PCI bus=
=2E=20
I got random errors (everything between kernel-oops, error-loops and=20
warnings) when reinserting the uhci_hcd module.
After resuming my power LED is not switched on (not so problematic), and th=
e =20
notebook doesn't ask for a password (Really problematic).
The e1000 module still needs the unload/load procedure.

Hope I'm right on this list. Tell me If I'd cc to an other one, please.
Include my in your cc's please, as I'm not reading this list.

regards
Alex

=2D --=20
Some operating systems are called `user friendly',
	Linux however is `expert friendly'.
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAIPyk/aHb+2190pERAjhgAKCkYnYnJcTJMFQc7YY4sGNWRVh4dwCgkdQX
hAR99v74cSPS4JsYv+vuz54=3D
=3DI96u
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
