From: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Subject: _PTS call hangs system
Date: Tue, 14 Sep 2004 20:40:09 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409142040.09569.andre@eisenbach.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart31304081.OiNXc0JFAJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--nextPart31304081.OiNXc0JFAJ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hey guys!

I've done some more debugging to figure out why my notebook won't shut down=
=20
anymore. To recap, it works up to 2.8.6.1-mm3, but no kernel thereafter.

The following call in /drivers/acpi/hardware/hwsleep.c hangs:
 status =3D acpi_evaluate_object (NULL, METHOD_NAME__PTS, &arg_list, NULL);

This is in acpi_enter_sleep_state_prep().=20
When I comment out that line, it continues on just fine and shuts off.

I'm very surprised by this, since a diff -ru between mm3 and mm4 brings up =
no=20
changes in drivers/acpi at all. So I don't know why it works in mm3 and not=
=20
mm4 (and above).

Also, I've put Debug statements in my DSDT in the _PTS function, but someho=
w=20
they are not printed to the console (or dmesg), even so I have=20
CONFIG_ACPI_DEBUG=3Dy
CONFIG_PM_DEBUG=3Dy
in my kernel config.
Somehow I had managed to get the DSDT debug strings onto the console once=20
before, but I forgot how to do it. Any tips would be appreciated.

Belo is my DSDT code, method _PTS for reference.

I've downloaded the ACPI specs and will try to read up on what PTS is suppo=
sed=20
to do. Maybe I'll come up with something.

Meanwhile, if you guys have any ideas, please let me know!

Thanks so much for your help!

Regards,
   Andre

=2D-- SNIPP ---

    Method (_PTS, 1, NotSerialized)
    {
        If (LEqual (Arg0, 0x01)) {}
        If (LEqual (Arg0, 0x03))
        {
            Store (0x01, \_SB.PCI0.ISA.EC0.WORE)
            Store (0x00, \_SB.PCI0.PMU.LLOW)
            Store (0x01, \_SB.PCI0.PMU.LHGH)
        }

        If (LEqual (Arg0, 0x04))
        {
            Store (0x01, \_SB.PCI0.ISA.EC0.S4FG)
            Store (0x00, \_SB.PCI0.ISA.EC0.WORE)
            \_SB.PCI0.ISA.HPSS (0x18, 0x00)
        }

        If (LEqual (Arg0, 0x05))
        {
            Store (0x00, \_SB.PCI0.ISA.EC0.WORE)
            If (\_SB.PCI0.ISA.WOLE)
            {
                Store (0x01, \_SB.PCI0.ISA.EC0.WOLE)
            }
            Else
            {
                Store (0x00, \_SB.PCI0.ISA.EC0.WOLE)
            }

            \_SB.PCI0.ISA.HPSS (0x02, 0x00)
            Sleep (0x07D0)
        }
    }

--nextPart31304081.OiNXc0JFAJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBR7mZtofNKe8dDvARAlJjAKCVyTAWWOrbHLuv8NfKlk1RIXPvRwCcDPNk
CQySwfCJXhYbhiGo0YzXbKQ=
=vTuZ
-----END PGP SIGNATURE-----

--nextPart31304081.OiNXc0JFAJ--


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
