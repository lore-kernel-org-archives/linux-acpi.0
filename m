From: "Jiang, Brendan" <brendan.jiang@intel.com>
Subject: S3 of SATA harddisk under AHCI mode
Date: Thu, 23 Feb 2006 14:49:38 +0800
Message-ID: <D3B54144DF35174EB303DB66C35BAA7F01D511F6@bjsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from petasus.png.intel.com ([192.198.147.99]:33185 "EHLO
	petasus.png.intel.com") by vger.kernel.org with ESMTP
	id S1751504AbWBWGuD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Feb 2006 01:50:03 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org, intel-linux-acpi@linux.intel.com

Hi Len/Shaohua,

I'm working on enable S3 for SATA hard disk under AHCI mode on Napa CRB.

Would you please give me a quick update about current supporting statue
for this issue?

Here's my testing configurations:
HW platform: Napa CRB
BIOS:        0.60
SATA config: AHCI enabled, RAID disabled
             (under IDE mode, S3 works well with vbetool post)
OS: Redflag 5.0
Kernel: 2.6.14, 2.6.16-rc3
Observations:
1) suspend OK
2) on resume
	keyboard capital and numlock works.
	No video.
	No message on serial console.
	No LAN.
	Type in "find /", hard disk LED has no response.
	Type in "reboot", no response.
3) it seems SATA hard disk lost after resume.

Also I found a patch developed by Randy Dunlap
<randy_d_dunlap@linux.intel.com>
On http://lkml.org/lkml/2006/1/14/15
(strange, why don't we discuss this first? :-)

I patched it onto 2.6.16-rc3 but didn't help.

Any comments from anybody will be highly appreciated. Thank you very
much!

Best regards,
Brendan

