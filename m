From: "Yu, Harland ERDC-TEC-VA" <Harland.Yu@usace.army.mil>
Subject: RE: Resend: Cannot boot 3.2.12 or 3.3 (kernel panic - not syncing:
 Attempted to kill init)
Date: Tue, 20 Mar 2012 19:02:31 +0000
Message-ID: <D5E069508CED5646A1F8CA22FA9AA5EC18065440@EIS-MB09WPC.eis.ds.usace.army.mil>
References: <D5E069508CED5646A1F8CA22FA9AA5EC180652F1@EIS-MB09WPC.eis.ds.usace.army.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw3.usace.army.mil ([140.194.153.3]:64859 "EHLO
	gw3.usace.army.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892Ab2CTTCw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Mar 2012 15:02:52 -0400
In-Reply-To: <D5E069508CED5646A1F8CA22FA9AA5EC180652F1@EIS-MB09WPC.eis.ds.usace.army.mil>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

I just saw this email (https://lkml.org/lkml/2012/3/19/227) by Romain Francoise on LKML.org.  I removed the lines from aspm.c per the email, recompiled the kernel, and the system booted successfully.



Harland

________________________________________
From: Yu, Harland ERDC-TEC-VA
Sent: Tuesday, March 20, 2012 9:46 AM
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org
Subject: Resend: Cannot boot 3.2.12 or 3.3 (kernel panic - not syncing: Attempted to kill init)

Sorry, hit the send button prematurely.

Hi,

First time submitting a bug report, so apologies in advance if I leave anything important out.

1.  I cannot get Linux 3.2.12 or 3.3 to boot unless I disable the entire ACPI section from the kernel config.

2.  Unfortunately I don't seem to have a way of recovering the boot messages before the kernel panic.  The only output I see is a stack trace followed by (when attempting to boot 3.3):

[0.389577] Code: c1 83 e0 f8 83 e1 07 83 c9 03 09 c8 41 88 44 24 48 0f b6 4c 89 e7 e8 bd 54 ea ff e9 28 fa ff ff 0f 1f 84 00 00 00
[0.394147] RIP [<ffffffff81238269>] pcie_aspm_init_link_state+0x889/08x8a0
[0.394398] RSP <ffff88041d07db50>
[0.394572] --- [end trace 4eaa2a86a8e2da22] ---
[0.394751] kernel panic - not syncing: Attempted to kill init!

3.  pcie_aspm_init_link_state, kernel panic

4.1  3.2.12, 3.3

4.2  See attached

5.  3.2.11 boots successfully

8.  See attached.

Motherboard is a Gigabyte Z68X-UD7-B3 rev 1.0 with F10 BIOS, if that helps.

Let me know if there's anything else I need to provide or should do.


Regards,

Harland
