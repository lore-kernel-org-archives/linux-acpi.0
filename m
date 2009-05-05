From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC] [PATCH] PCI mmconfig without ACPI
Date: Tue, 5 May 2009 10:57:44 -0700
Message-ID: <20090505105744.4268e341@hobbes>
References: <1233766786.16414.26.camel@localhost.localdomain>
	<20090204181738.GA16174@elte.hu>
	<1234812741.28801.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-135.bluehost.com ([67.222.39.25]:36700 "HELO
	outbound-mail-135.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751810AbZEER5t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2009 13:57:49 -0400
In-Reply-To: <1234812741.28801.4.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ed Swierk <eswierk@aristanetworks.com>
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org

On Mon, 16 Feb 2009 11:32:21 -0800
Ed Swierk <eswierk@aristanetworks.com> wrote:

> Here's another attempt at decoupling the setup of memory-mapped PCI
> configuration space from ACPI.  I implemented your suggestions for
> moving the ACPI-specific code to a separate file.  I left the
> definition of struct acpi_mcfg_allocation alone, and created a new
> struct pci_mcfg_allocation.  The former is now used only for parsing
> the actual ACPI MCFG table, while the latter is used to store
> information about mmcfg regions regardless of where they came from.
> 
> (This is still an RFC; the code is pretty much untested.)
> 

I'm still a bit dubious about this; does it solve a real issue?  Or
just remove the ACPI dependency for its own sake?

-- 
Jesse Barnes, Intel Open Source Technology Center
