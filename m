From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: AE_AML_BUFFER_LIMIT errors with latest Linus tree
Date: Tue, 4 Jan 2005 15:29:48 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8406B6551B@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Not sure if  kernel option "acpi_os_name=3DMicrosoft Windows" help this?

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Dmitry =
Torokhov
Sent: 2005=C4=EA1=D4=C24=C8=D5 14:32
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] AE_AML_BUFFER_LIMIT errors with latest Linus tree

Hi,

The latest pull from Linus tree prduces the following errors:

Jan  3 23:48:10 anvil kernel: ACPI: Subsystem revision 20041210
Jan  3 23:48:10 anvil kernel:     ACPI-1138: *** Error: Method execution =
failed [\STRC] (Node f7f867e0), AE_AML_BUFFER_LIMIT
Jan  3 23:48:10 anvil kernel:     ACPI-1138: *** Error: Method execution =
failed [\_SB_.PCI0._INI] (Node f7f86b00), AE_AML_BUFFER_LIMIT

The relevant fragments of DSDT are:

    Method (STRC, 2, NotSerialized)
    {
        If (LNot (LEqual (SizeOf (Arg0), SizeOf (Arg1))))
        {
            Return (0x00)
        }

        Add (SizeOf (Arg0), 0x01, Local0)
        Name (BUF0, Buffer (Local0) {})
        Name (BUF1, Buffer (Local0) {})
        Store (Arg0, BUF0)
        Store (Arg1, BUF1)
        While (Local0)
        {
            Decrement (Local0)
            If (LNot (LEqual (DerefOf (Index (BUF0, Local0)), DerefOf =
(Index (BUF1, Local0)))))
            {
                Return (Zero)
            }
        }

        Return (One)
    }

                Method (\_SB.PCI0._INI, 0, NotSerialized)
                {
                    If (STRC (\_OS, "Microsoft Windows"))
                    {
                        Store (0x56, SMIP)
                    }
                    Else
                    {
                        If (STRC (\_OS, "Microsoft Windows NT"))
                        {
                            If (CondRefOf (_OSI, Local0))
                            {
                                If (\_OSI ("Windows 2001"))
                                {
                                    Store (0x59, SMIP)
                                    Store (0x00, OSFL)
                                    Store (0x03, OSFX)
                                }
                            }
                            Else
                            {
                                Store (0x58, SMIP)
                                Store (0x00, OSFX)
                                Store (0x00, OSFL)
                            }
                        }
                        Else
                        {
                            Store (0x57, SMIP)
                            Store (0x02, OSFX)
                            Store (0x02, OSFL)
                        }
                    }
                }

This did not happen with 2.6.10 and earlier bk pulls. The code looks =
sane
to my unexperienced eye... Any suggestions?

--=20
Dmitry


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
