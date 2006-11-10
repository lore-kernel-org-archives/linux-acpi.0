From: "Lu, Yinghai" <yinghai.lu@amd.com>
Subject: RE: 2.6.19-rc5 x86_64 irq 22: nobody cared
Date: Fri, 10 Nov 2006 12:22:15 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49071DE@ssvlexmb2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-red.frontbridge.com ([216.148.222.49]:48628 "EHLO
	outbound1-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1424402AbWKJUXl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Nov 2006 15:23:41 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ebiederm@xmission.com
Cc: Andi Kleen <ak@suse.de>, Olivier Nicolas <olivn@trollprod.org>, Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>, Stephen Hemminger <shemminger@osdl.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>

-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 

>YH.  This is a completely different problem.  The irq is properly setup
>and received but none of the drivers wanted it.

The irq  with ioapic are shared with sata2 and audio, and later the
audio driver get the irq, and then try to get MSI.

The MAC first shared irq (ioapic) with SATA and it later transfer to use
MSI without problem.

YH


