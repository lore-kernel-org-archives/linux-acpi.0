From: Szabolcs Barsony <bvelvet-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
Subject: PCI Root Bridge
Date: Sun, 9 Feb 2003 18:04:52 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200302091804.52802.bvelvet@freemail.hu>
Reply-To: bvelvet-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have a Compaq Presario 1500 notebook. Almost all the features work with=
 my=20
modified DSDT, but battery monitoring. During boot I get an error message=
=20
saying that it could not install pci_config handler for PCI root bridge. =
The=20
embedded controller and the battery are registered under this object, so =
I=20
think that this error is the cause of the battery problem.
What is wrong here? DSDT, ACPI code or Linux kernel? How can I fix it?
I use 2.4.20 + acpi-20030109-pre3. Unfortunately I could not test the lat=
est=20
patch with pre4, because during boot after module dependency check the HD=
=20
starts to spin endlessly.

Regards,
Szabolcs


Executing all Device _STA and_INI methods:...evrgnini-0242: *** Error: Co=
uld=20
not install pci_config handler
 for C03B, AE_ALREADY_EXISTS
=2E...evrgnini-0242: *** Error: Could not install pci_config handler for =
C03B,=20
AE_ALREADY_EXISTS
=2E...................evregion-0235 [22] ev_address_space_dispa: no handl=
er for=20
region(cff27128) [embedded_co
ntrol]
 exfldio-0216 [21] ex_access_region      : Region embedded_control(3) has=
 no=20
handler
evregion-0235 [22] ev_address_space_dispa: no handler for region(cff27128=
)=20
[embedded_control]
 exfldio-0216 [21] ex_access_region      : Region embedded_control(3) has=
 no=20
handler
 psparse-1102: *** Error: Method execution failed [\_SB_.C03B.C04E.C0CF.C=
0D3]=20
(Node cff264a8), AE_NOT_EXIST
 psparse-1102: *** Error: Method execution failed [\_SB_.C03B.C04E.C0CF._=
INI]=20
(Node cff23428), AE_NOT_EXIST
  nsinit-0378 [06] ns_init_one_device    : \_SB_.C03B.C04E.C0CF._INI fail=
ed:=20
AE_NOT_EXIST
=2E........................................evrgnini-0242: *** Error: Coul=
d not=20
install pci_config handler for
 C03B, AE_ALREADY_EXISTS
=2E......................
91 Devices found containing: 91 _STA, 4 _INI methods
Completing Region/Field/Buffer/Package=20
initialization:.....................................................
=2E...........................................
Initialized 14/24 Regions 0/0 Fields 25/26 Buffers 58/67 Packages (835 no=
des)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [C03B] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge


--=20
      .-.
     /v\    L   I   N   U   X
    // \\  >Phear the Penguin<
   /(   )\
   ^^-^^
___________________________________
Linux is like a wigwam. No gates, no windows just an apache inside.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
