From: =?iso-8859-2?Q?Zden=ECk?= OGAR =?iso-8859-2?Q?Skal=E1k?=
	<skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>
Subject: Copaq's DSDTs
Date: Tue, 22 Apr 2003 11:35:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EA50CCB.AF7E438B@monetplus.cz>
References: <20030418123144.GB2623@nostromo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
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

	just as repairing Jiri Musil's DSDT: Compaq Evo N110 & Armada 110 are ne=
arly
the same, the same bugs in DSDT, ....

	But what I'm writing for: consider this fragment of DSDT :-)

   Device(PCI0)
        {
            Name(MYOS,0x02)
            Method(_INI,0,NotSerialized)
            {
                Store(0x02,MYOS /* \_SB.PCI0.MYOS */)
                If(LEqual(SizeOf(\_OS),0x14))
                {
                    Store(0x01,MYOS /* \_SB.PCI0.MYOS */)
                }
                If(LEqual(SizeOf(\_OS),0x11))
                {
                    Store(0x00,MYOS /* \_SB.PCI0.MYOS */)
                }
                If(LEqual(SizeOf(\_OS),0x27))
                {
                    Store(0x03,MYOS /* \_SB.PCI0.MYOS */)
                }
            }

	Pretty smart way to find out operating system, isn't it ?

	Bye
		Zdenek OGAR Skalak
-- =

Ing. Zden=ECk OGAR Skal=E1k
Monet+ a.s.
Z=E1meck=E1 365
763 14 Zl=EDn - =A9t=EDpa, CZ
Tel: +420 / 577 110 411,  Fax: +420 / 577 914 557


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
