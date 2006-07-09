From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.17-mm2 -- drivers/built-in.o: In function `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to `is_dock_device'
Date: Sun, 9 Jul 2006 19:06:01 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECF9E8@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27059 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932508AbWGIXGH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 19:06:07 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, Adrian Bunk <bunk@stusta.de>, Miles Lane <miles.lane@gmail.com>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, gregkh@suse.de, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>

fixed typo -- can't cook and type at the same time...

DOCK	HPA
n	n	builds
n	y	-> y,y
n	m	-> m,m
y	n	builds
y	y	builds
y	m	builds
m	n	builds
m	y	-> y,y (previous note had typo, m,y)
m	m	builds
