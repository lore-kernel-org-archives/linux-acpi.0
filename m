From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Double/Tripple lan0 entries in /proc/interrupts
Date: Wed, 24 May 2006 00:57:24 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB68AD7DF@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13065 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932582AbWEXE52 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 May 2006 00:57:28 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Saur <saur@acmelabs.de>, linux-acpi@vger.kernel.org

>after getting kernel panics with the mm-patches, I've just patched the 
>kernel 2.6.17-rc4 only with the latest appropriate git-acpi patch.
>Question #1: Is this a valid option, to patch the kernel like 
>that? (If >YES -> Next Question)

Yes. the latest acpi patch is against Linus' tree.
eg.
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6
.17/acpi-test-20060310-2.6.17-rc4.diff.bz2

>Question #2: Is it bad to have two lan0 entries after a fresh boot in 
>/proc/interrupts, although there is just only one NIC in my system?

bad NIC, no packet for you.

>Question #3: After suspend (S3) and wake up the system via 
>PowerButton, 
>I have three lan0 in /proc/interrupts. Is this even worse?

bad bad NIC...

>Question #4: Could this be an indicator for having problems with 
>resuming from S3 via WOL (magic packet)?

I doubt it, since something is very broken immediately after the fresh
boot.

>With one older kernel (2.6.17-rc1) I've found a constellation 
>where I at 
>least could WOL the system from S3 up to three times, the 
>forth time it 
>died. The same kernel-config doesn't work here at all.

So this multiple lan0 thing goes away when you boot 2.6.17-rc4
without the acpi patch?

if you rmmod the driver, and the modprobe it again
does it add an additional entry to /proc/interrupts?

thanks,
-Len


>###### BEFORE S3###(have a look at lan0#)############

> 16:    49265   IO-APIC-level  ohci_hcd:usb1, lan0, lan0

>####### AFTER RESUME FROM S3 VIA POWERBUTTON ########
>           CPU0
> 16:    140356   IO-APIC-level  lan0, lan0, lan0, ohci_hcd:usb2
