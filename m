From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/7] x86/acpi: calling mp_config_acpi_gsi in
 mp_register_gsi -v2
Date: Thu, 14 May 2009 12:20:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905141154390.19537@localhost.localdomain>
References: <4A01C35C.7060207@kernel.org> <4A01C387.7090103@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:44396 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760833AbZENQUZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2009 12:20:25 -0400
In-reply-to: <4A01C387.7090103@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

mp_config_acpi_gsi() has been dead code since the day it went into 2.6.27.
Rather than repairing that, I'd rather see it removed.

The justification for 2944e16b25e7fb8b5ee0dd9dc7197a0f9e523cfd
"x86: update mptable" was:

    1. kexec kernel with acpi=off
    2. work around BIOSes where acpi routing is working, but mptable is
       not right, so can use kernel/kexec to start other OSes that don't have
       good acpi support.
    
    command line: update_mptable

So this is a command line option to allow
MPS code to call into ACPI code to support kexec from an ACPI
mode into non-ACPI mode -- all without a single comment in the code.

I'm not convinced that the scenario that this code was
intended to address justifies adding unreadable code to
an area of the kernel which is notoriously over-complicated
and fragile.  Doing so is the opposite of optimizing for maintenance.

No, I don't want to see any MPS code ever call into ACPI code.

thanks,
Len Brown, Intel Open Source Technology Center
