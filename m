From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: MacPro (Please send dmidecode to linux-acpi@vger.kernel.org)
Date: Wed, 29 Aug 2007 13:49:46 +0200
Message-ID: <200708291349.46987.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx02.qsc.de ([213.148.130.14]:33298 "EHLO mx02.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933024AbXH2MUU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Aug 2007 08:20:20 -0400
Received: from exactcode.de (port-212-202-170-151.dynamic.qsc.de [212.202.170.151])
	by mx02.qsc.de (Postfix) with ESMTP id 6048B16C033F
	for <linux-acpi@vger.kernel.org>; Wed, 29 Aug 2007 13:49:51 +0200 (CEST)
Received: from port-83-236-211-226.static.qsc.de ([83.236.211.226] helo=[192.168.2.172])
	by exactcode.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1IQM4n-0004C3-5J
	for linux-acpi@vger.kernel.org; Wed, 29 Aug 2007 11:51:14 +0000
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

I just post because my dmesg says so:

ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=3D!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org

Handle 0x003A, DMI type 0, 24 bytes
BIOS Information
        Vendor: Apple Computer, Inc.
        Version:     MP21.88Z.007F.B02.0703191612
        Release Date: 03/19/07

Handle 0x003B, DMI type 1, 27 bytes
System Information
        Manufacturer: Apple Computer, Inc.
        Product Name: MacPro2,1
        Version: 1.0

=2E..

If you need more let me know. I mostly looked thru the dmesg
because the box shuts down sometimes, randomly. Maybe too hot?
But I still investigate.

However, the box (2 Quad-Core CPUs) even awakes from echo mem >
/sys/power/state (without graphic though, maybe s2ram posting would fix
that - but I do not really care about the graphic as it is indended to =
be used
as server anyway).

Yours,

--=20
  Ren=E9 Rebe - ExactCODE GmbH - Europe, Germany, Berlin
  http://exactcode.de | http://t2-project.org | http://rene.rebe.name
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
