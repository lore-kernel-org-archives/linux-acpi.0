From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 6038] New: ACPI not working since 2.6.14
Date: Thu, 9 Feb 2006 09:57:02 -0800
Message-ID: <20060209095702.57c4b0a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:33459 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422933AbWBIR5a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2006 12:57:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k19HvTDZ008399
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 9 Feb 2006 09:57:29 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k19HvT9Y003306
	for <linux-acpi@vger.kernel.org>; Thu, 9 Feb 2006 09:57:29 -0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


This one's a nasty regression.

The suse guys are apparently hitting a lot of box-simply-wont-boot
problems in sles10 testing.  It'd be nice to fix a few of them up..



Begin forwarded message:

Date: Thu, 9 Feb 2006 07:43:04 -0800
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 6038] New: ACPI not working since 2.6.14


http://bugzilla.kernel.org/show_bug.cgi?id=6038

           Summary: ACPI not working since 2.6.14
    Kernel Version: 2.6.14 up to 2.6.16-rc2-mm1
            Status: NEW
          Severity: normal
             Owner: acpi_config-interrupts@kernel-bugs.osdl.org
         Submitter: ps_mail@freenet.de


Most recent kernel where this bug did not occur: 2.6.13.5
Distribution: Debian Sid
Hardware Environment: X86_64
Software Environment: Debian Sid, kernel compiled with gcc-Version 4.0.3
20060128 (prerelease) (Debian 4.0.2-8)
Problem Description: 
ACPI is not working anymore since kernel 2.6.14 (kernel <=2.6.13.5 works
fine, 2.6.14 up to kernel 2.6.16-rc2-mm1 it hangs on boot)

The Kernel hangs on boot when it's detecting the partitions of my ide/sata
and prints out dma timer expiry.(Booting with acpi=off works. with acpi=noirq
and noapic doesn't)

when i remove my hda on my nvidia pata controller it boots without hanging but
doesn't find any other harddrives on the promise controller or sata (cdroms on
pata are found)

i have uploaded screenshots from booting 2.6.16-rc2-mm1 with hda, without hda
and /proc/interrupts, acpidump, dmesg, lspci -vv from 2.6.13.5 to
http://home.arcor.de/ps_mail/

hope you can find the bug, if you need more informations or testing anything,
then let me know.

Steps to reproduce:
press the powerbutton to boot the system ;-)

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
