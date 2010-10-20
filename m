From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: lost parts of "pci, acpi: reroute PCI interrupt to legacy boot interrupt equivalent" during merge
Date: Wed, 20 Oct 2010 12:14:02 -0600
Message-ID: <201010201214.03363.bjorn.helgaas@hp.com>
References: <4CBEDA90020000780001E290@vpn.id2.novell.com> <20101020152453.GD22271@elte.hu> <4CBF1896.70901@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:25466 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283Ab0JTSPW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Oct 2010 14:15:22 -0400
In-Reply-To: <4CBF1896.70901@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Assmann <sassmann@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Jan Beulich <JBeulich@novell.com>, Takashi Iwai <tiwai@suse.de>, Junio C Hamano <gitster@pobox.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>

On Wednesday, October 20, 2010 10:28:06 am Stefan Assmann wrote:
> Let me take a look at the current situation and see if I can come up
> with a solution. Sorry if things got messy.

When you redo this, can you update the printks to use dev_info()
and "[%04x:%04x]" for vendor/device, like the rest of PCI?

Actually, the bridge_has_boot_interrupt_variant() printk looks
superfluous to me.

Do you know how Windows handles these machines?  I'm just wondering
if there's some ACPI or other information from the BIOS that we're
not handling quite correctly, and if we fixed that maybe we wouldn't
need a quirk.

ISTR a paper or some kind of writeup you did, but the commit
(e1d3a90846) doesn't mention it.  Am I mis-remembering that?

It'd be kind of nice for archaeologists like me if there were a
kernel bugzilla with before/after dmesg logs and stuff.

Bjorn
