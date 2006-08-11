From: Len Brown <len.brown@intel.com>
Subject: Re: IRQ Mis-matches in 2.6.17.7
Date: Fri, 11 Aug 2006 11:44:36 -0400
Message-ID: <200608111144.36751.len.brown@intel.com>
References: <Pine.LNX.4.63.0608110945510.15208@illythia.matthew.ath.cx>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39573 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932081AbWHKPnR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Aug 2006 11:43:17 -0400
In-Reply-To: <Pine.LNX.4.63.0608110945510.15208@illythia.matthew.ath.cx>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Johnson <matt@matthew.ath.cx>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Friday 11 August 2006 04:53, Matthew Johnson wrote:

ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKC] -> GSI 4 (level, low) -> IRQ 4
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0f.0: 3Com PCI 3c905B Cyclone 100baseTx at e0802000.

setup_irq: irq handler mismatch
 <c0135b3e> setup_irq+0x10d/0x11a  <e2024b74> irq_handler+0x0/0x4e0 [lirc_serial]
 <c0135bba> request_irq+0x6f/0x8b  <e202410a> set_use_inc+0xab/0x1b9 [lirc_serial]
 <e201f467> irctl_open+0x155/0x1e8 [lirc_dev]  <c015678b> chrdev_open+0x15e/0x17a
 <c015662d> chrdev_open+0x0/0x17a  <c014e9d7> __dentry_open+0xe0/0x1cf
 <c014eb2a> nameidata_to_filp+0x19/0x28  <c014eb64> do_filp_open+0x2b/0x31
 <c014ec4a> do_sys_open+0x3c/0xae  <c014ece9> sys_open+0x16/0x18
 <c0102a5f> syscall_call+0x7/0xb 
lirc_serial: IRQ 4 busy

----------
Matthew,
I think this is an ACPI IRQ routing bug where PCI and legacy clash.

While I don't expect it to make a difference, please reproduce without the NVIDIA binary module.

I expect you will be able to work around this issue by booting with
"acpi_irq_isa=4"

Then try with "acpi=off" or "acpi=noirq"

If it works, then by definition this is an ACPI bug.
Collect the dmesg -s64000 and /proc/interrupts for the the success and failure case,
the .config, the output from adpidump (available in pmtools here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
and attach them to a bugzilla here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and mention if this worked before, or if this configuration has always failed.

thanks,
-Len

