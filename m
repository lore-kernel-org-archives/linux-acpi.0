From: "¹Ú¿µ»ó" <groovy-GILFV2MaSN5eoWH0uzbU5w@public.gmane.org>
Subject: [ACPI-sppt] Doesn't Wake on Lan with VT6103!
Date: Thu, 26 Jun 2003 16:32:22 +0900
Sender: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306260732.h5Q7WMR02345@54s.new21.net>
Reply-To: groovy-GILFV2MaSN5eoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="euc-kr"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-support>
To: acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi.

I am using the EPIA M(VT5718B with VT6103) mainboard with Linux 2.5.69
(Redhat 7.3). 
When into S3 state or power-downed, it does not come alive when I send a WOL
magic packet or ping. However, it works perfectly with WindowsXP as OS .

I tried both the Linux via-rhine.c driver and VIA's rhinefet.c v3.28
downloaded from VIA site. I saw that rhinefet.c has partial support for acpi.


Both drivers clear registers related to WOL, but I guess for WOL to operate
some sensible values must be written to it. Unfortunately, the chip
documentation does not give me any clue what to do. 
And, AwardBIOS6.0 is in this board.

What should I do to make WOL available?
Can anybody give me a detailed description what has to be done with the LAN
chip and BIOS to enable WOL? 

Thanks so much.

Jun




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
