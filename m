From: John S <johns9872003@yahoo.co.uk>
Subject: acpi_apic_instance=2 and a question
Date: Wed, 22 Jun 2011 16:34:57 +0100 (BST)
Message-ID: <1308756897.42310.YahooMailClassic@web26701.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nm20-vm1.bullet.mail.ukl.yahoo.com ([217.146.183.88]:30775 "HELO
	nm20-vm1.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757947Ab1FVPe7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jun 2011 11:34:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

kernel 2.6.33.7

laptop from ECS aka ELITEGROUP aka Uniwill
model L75II0
Intel Core2 Duo T5750 2GHz
Phoenix BIOS

It's different, maybe better, with acpi_apic_instance=2

If you'd like more details / output from anything (dmesg? acpidump? dmidecode? whatever) please ask.

I'd like to get Linux running better on it - only starts 1 CPU whereas sadly Vista starts both cores.  Any suggestions welcome!

I've tried newer test kernels for ArchLinux (sorry, not yet kernel devel / Linus ones) and both 32-bit and 64-bit only start 1 core.

I'm currently looking at files such as smpboot.c and drivers/acpi/tables.c but don't really know what I should be doing to try to understand the sequence of events so I can try to work around what is no doubt a buggy BIOS.  No BIOS updates available from maker's websites.

Thanks,

John
