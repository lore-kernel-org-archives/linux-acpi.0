From: "Brown, Len" <len.brown@intel.com>
Subject: FW: ACPIPnP, part 2
Date: Wed, 19 Jul 2006 10:40:51 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601053709@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59053 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964851AbWGSOqb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jul 2006 10:46:31 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

 

-----Original Message-----
From: Vojtech Pavlik [mailto:vojtech@suse.cz] 
Sent: Tuesday, July 18, 2006 4:20 PM
To: Brown, Len
Subject: ACPIPnP, part 2

Hi Len,

The previous patch fixed some (most) machines in ECP mode. However,
there are still some machines where 'rmmod parport; modprobe parport'
doesn't work because of PnPACPI, resulting in this:

parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP]
parport0: Printer, EPSON Stylus COLOR 640
lp0: using parport0 (interrupt-driven).
parport 0x378 (WARNING): CTR: wrote 0x0c, read 0xff
parport 0x378 (WARNING): DATA: wrote 0xaa, read 0xff
parport 0x378: You gave this address, but there is probably no parallel
port there!

This means that the i/o port doesn't get enabled correctly, the same way
that DMA didn't work before. 

I'll have to recheck that the problem still persists with the latest git
snapshot, because now that I looked at the relevant functions, I see
significant changes there.

-- 
Vojtech Pavlik
Director SuSE Labs
