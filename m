From: "¹Ú¿µ»ó" <groovy-GILFV2MaSN5eoWH0uzbU5w@public.gmane.org>
Subject: [ACPI]Anybody succeed 'Wake On Lan' in S3?
Date: Mon, 23 Jun 2003 21:02:13 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306231202.h5NC2DG10278@54s.new21.net>
Reply-To: groovy-GILFV2MaSN5eoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="euc-kr"
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
To: "acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

AwardBIOS, 2.5.69 kernel, VIA VT6103 PHY in my system.

Enter s3 state successfully and then never wake up=20
by lan event such as "ping xxx.xxx.xxx.xxx from another system.

after that, following message comes out=20
"eth0: Transmit timed out, status ffff, PHY status ffff, resetting..."

here is my part of via-rhine.c code
-------------------------------------
enum register_offsets {
	StationAddr=3D0x00, RxConfig=3D0x06, TxConfig=3D0x07, ChipCmd=3D0x08,
	IntrStatus=3D0x0C, IntrEnable=3D0x0E,
	MulticastFilter0=3D0x10, MulticastFilter1=3D0x14,
	RxRingPtr=3D0x18, TxRingPtr=3D0x1C, GFIFOTest=3D0x54,
	MIIPhyAddr=3D0x6C, MIIStatus=3D0x6D, PCIBusConfig=3D0x6E,
	MIICmd=3D0x70, MIIRegAddr=3D0x71, MIIData=3D0x72, MACRegEEcsr=3D0x74,
	ConfigA=3D0x78, ConfigB=3D0x79, ConfigC=3D0x7A, ConfigD=3D0x7B,
	RxMissed=3D0x7C, RxCRCErrs=3D0x7E, MiscCmd=3D0x81,
	StickyHW=3D0x83, IntrStatus2=3D0x84, WOLcrClr=3D0xA4, WOLcgClr=3D0xA7,
	PwrcsrClr=3D0xAC,
};
        .
        .
        .
	/* D-Link provided reset code (with comment additions) */
	if (via_rhine_chip_info[chip_id].drv_flags & HasWOL) {
		unsigned char byOrgValue;

		/* clear sticky bit before reset & read ethernet address */
		byOrgValue =3D readb(ioaddr + StickyHW);
		byOrgValue =3D byOrgValue & 0xFC;
		writeb(byOrgValue, ioaddr + StickyHW);

		/* (bits written are cleared?) */
		/* disable force PME-enable */
		writeb(0x80, ioaddr + WOLcgClr);
		/* disable power-event config bit */
		writeb(0xFF, ioaddr + WOLcrClr);
		/* clear power status (undocumented in vt6102 docs?) */
		writeb(0xFF, ioaddr + PwrcsrClr);
	}

thanks.

=C1=C1=C0=BA =C7=CF=B7=E7=B5=C7=BC=BC=BF=E4:)




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
