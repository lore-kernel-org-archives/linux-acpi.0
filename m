From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: RE: ASL help with latest acpi and compaq presario 2800t
Date: Wed, 14 May 2003 09:36:18 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030514153621.D79D2F7868@voldemort.scrye.com>
References: <3ACA40606221794F80A5670F0AF15F84272309@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84272309-4yWAQGcml64gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Luming" == Luming Yu <Yu> writes:

Luming> Could you please inform me whether battery status works on
Luming> your 2800t.  Thanks, Luming

Yes. It works fine. 

cat /proc/acpi/battery/BAT1/info                                                                         9:31:05
present:                 yes
design capacity:         2592 mAh
last full capacity:      2592 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 259 mAh
design capacity low:     0 mAh
capacity granularity 1:  100 mAh
capacity granularity 2:  100 mAh
model number:            Primary
serial number:           482F
battery type:            4E4F494C
OEM info:                 COMPAQ

cat /proc/acpi/battery/BAT1/state                                                                        9:35:37
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mA
remaining capacity:      2592 mAh
present voltage:         16514 mV

kevin
- --
Luming> -----Original Message----- From: Kevin Fenzi
Luming> [mailto:kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org] Sent: 2003?5?14? 5:11 To: Yu,
Luming> Luming Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org Subject: RE:
Luming> [ACPI] ASL help with latest acpi and compaq presario 2800t


Luming> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1

>>>>> "Luming" == Luming Yu <Yu> writes:

Luming> Maybe you were missing something.  Try attached file please.
Luming> Thanks, Lumng

Luming> Yeah, I must have munged the patch or something. Putting the
Luming> External ones in the right place made it compile just fine. ;)

Luming> It seems to load just as well as the previous one...

Luming> thanks for the help.

Luming> kevin -----BEGIN PGP SIGNATURE----- Version: GnuPG v1.2.1
Luming> (GNU/Linux) Comment: Processed by Mailcrypt 3.5.8
Luming> <http://mailcrypt.sourceforge.net/>

Luming> iD8DBQE+wV9U3imCezTjY0ERAvQ0AJ41yvpzBvZP597bzzu8NUlRk2CtJgCggS3O
Luming> WLP0gc7H1XCKCkyk3aOAF0A= =PCoB -----END PGP SIGNATURE-----


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+wmJ13imCezTjY0ERAnC8AKCOAOyeHipOfqLd1/d2jyQJXlSljgCaAhgs
GifT6OGG1LqXfow5CSNMcHU=
=YPRr
-----END PGP SIGNATURE-----


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
