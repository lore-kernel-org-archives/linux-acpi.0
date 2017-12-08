From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 2/3] x86/acpi: take rsdp address for boot params if
 available
Date: Fri, 8 Dec 2017 12:14:45 +0100
Message-ID: <48be541f-bc28-b7e1-3b5b-6ac1cbe62150@suse.com>
References: <20171207122821.30158-1-jgross@suse.com>
 <20171207122821.30158-3-jgross@suse.com>
 <20171208070505.25j6dtun555v6ofo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753501AbdLHLOs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Dec 2017 06:14:48 -0500
In-Reply-To: <20171208070505.25j6dtun555v6ofo@gmail.com>
Content-Language: de-DE
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org

On 08/12/17 08:05, Ingo Molnar wrote:
> 
> * Juergen Gross <jgross@suse.com> wrote:

...

> acpi_physical_address acpi_arch_get_root_pointer(void)
> {
> 	return boot_params.hdr.acpi_rsdp_addr;
> }
> 
> 4)
> 
> Add this to arch/x86/include/asm/acpi.h:
> 
> extern acpi_physical_address acpi_arch_get_root_pointer(void);

Uuh, this leads to problems for files including <asm/acpi.h> directly:
acpi_physical_address won't be defined, and including <acpi/actypes.h>
from arch/x86/include/asm/acpi.h will lead to:

#error unknown ACPI_MACHINE_WIDTH

This can only be avoided by including <linux/acpi.h> from <asm/acpi.h>
which seems to be the wrong layering.

So I could:

a) modify the sources including <asm/acpi.h> to use <linux/acpi.h>
   instead
b) don't use acpi_physical_address but either u64 or unsigned long.
c) ?

What would be your preference?


Juergen
