From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 6056] New: SATA problem on sata_nv
 (NFPIK8AA-8EKRS)
Date: Sat, 11 Feb 2006 13:08:58 -0800
Message-ID: <20060211130858.5a54aa55.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:50829 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932354AbWBKVJk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Feb 2006 16:09:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1BL9cDZ018908
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sat, 11 Feb 2006 13:09:38 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k1BL9cL3013071
	for <linux-acpi@vger.kernel.org>; Sat, 11 Feb 2006 13:09:38 -0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


This might be an ACPI problem?

Begin forwarded message:

Date: Sat, 11 Feb 2006 08:00:00 -0800
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 6056] New: SATA problem on sata_nv (NFPIK8AA-8EKRS)


http://bugzilla.kernel.org/show_bug.cgi?id=6056

           Summary: SATA problem on sata_nv (NFPIK8AA-8EKRS)
    Kernel Version: 2.6.15.4
            Status: NEW
          Severity: high
             Owner: jgarzik@pobox.com
         Submitter: tawa777@ybb.ne.jp


Most recent kernel where this bug did not occur:

Distribution: 
FedoraCore4(x86-64)

Hardware Environment:
CPU: Opteron 140EE
Motherboard: NFPIK8AA-8EKRS
Memory: 512MB x 2 (ECC-Reg. DDR400)
HDD:HDS728080PLA380.

Software Environment:
Problem Description:

I have begun to use a PC with a Motherboard named NFPIK8AA-8EKRS.
http://www.foxconnchannel.com/products_motherboard_2.cfm?pName=NFPIK8AA-8EKRS

The Board has two on-board SATA controllers,
one is called Nforce4 Professional 2200(CK8-04)
other is called Nforce4 professional 2050(I/O-4).
And each controller has four SATA ports.
Thus this board has total 8 SATA ports.

I find when a SATA Disk which FC4 is installed
is connected to a SATA ports controlled by I/O-4,
the disk is not boot without the option of "acpi=noirq".
When the Disk is connected to CK8-04,
Boot process works fine.

I have took pictures of monitor
showing error message in booting without "acpi=noirq".
http://type-r.dnsalias.net/9usjs/a.jpg
http://type-r.dnsalias.net/9usjs/b.jpg
http://type-r.dnsalias.net/9usjs/c.jpg
http://type-r.dnsalias.net/9usjs/d.jpg
http://type-r.dnsalias.net/9usjs/e.jpg

I also put dmesg's
http://type-r.dnsalias.net/9usjs/dmesg.txt
http://type-r.dnsalias.net/9usjs/dmesg_noirq.txt.

Former shows the log when I connect the HDD to the port controlled by CK8-04,
latter shows one when I connect the HDD to the port controlled by I/O-4.

If further information is needed,
I will post it as much as possible.



Steps to reproduce:
1. Power off the PC
2. Connect the SATA disk to ports controlled by I/O-4. 
3. Power on the PC

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
