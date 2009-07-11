From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH v2 for 2.6.32] SFI - Simple Firmware Interface support
Date: Sat, 11 Jul 2009 10:26:49 +0200
Message-ID: <20090711082649.GB11522@elte.hu>
References: <1247026438-20891-1-git-send-email-lenb@kernel.org> <20090710051848.GB22218@elte.hu> <alpine.LFD.2.00.0907102059320.4088@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:46433 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbZGKI1H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Jul 2009 04:27:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0907102059320.4088@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, sfi-devel@simplefirmware.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

> 
> > 
> > > Feng Tang (10):
> > >       SFI, x86: add CONFIG_SFI
> > >       SFI: document boot param "sfi=off"
> > >       SFI: create include/linux/sfi.h
> > >       SFI: add core support
> > >       ACPI, x86: remove ACPI dependency on some IO-APIC routines
> > >       SFI: add x86 support
> > >       SFI, x86: hook e820() for memory map initialization
> > >       SFI: Enable SFI to parse ACPI tables
> > >       SFI, PCI: Hook MMCONFIG
> > >       SFI: add boot-time initialization hooks
> > 
> > Now that commit quality is all the rage, let me point out a 
> > (trivial) detail that could be improved: patch title capitalization. 
> > 
> > In particular for commits touching arch/x86/ we try to standardize 
> > on capitalizing the word after the 'x86: ' tag. But in the above 
> > titles the capitalization is mixed-case:
> > 
> >  [aligned vertically for easier readability ]
> > 
> > >       SFI, x86:  add CONFIG_SFI
> > >       SFI:       document boot param "sfi=off"
> > >       SFI:       create include/linux/sfi.h
> > >       SFI:       add core support
> > >       ACPI, x86: remove ACPI dependency on some IO-APIC routines
> > >       SFI:       add x86 support
> > >       SFI, x86:  hook e820() for memory map initialization
> > >       SFI:       Enable SFI to parse ACPI tables
> > >       SFI, PCI:  Hook MMCONFIG
> > >       SFI:       add boot-time initialization hooks
> > 
> > So it would be more consistent to have:
> > 
> > >       SFI, x86:  Add CONFIG_SFI
> > >       SFI:       Document boot param "sfi=off"
> > >       SFI:       Create include/linux/sfi.h
> > >       SFI:       Add core support
> > >       ACPI, x86: Remove ACPI dependency on some IO-APIC routines
> > >       SFI:       Add x86 support
> > >       SFI, x86:  Hook e820() for memory map initialization
> > >       SFI:       Enable SFI to parse ACPI tables
> > >       SFI, PCI:  Hook MMCONFIG
> > >       SFI:       Add boot-time initialization hooks
> > 
> > ( Capitalizing like that has the added (minor) benefit of making it 
> >   slightly easier to read these titles - the 'real' natural language 
> >   sentence portion of the title begins with a capital letter. )
> 
> Ingo,
> While I really do appreciate your attention to detail,
> a little time off might be good for you:-)

No objections on my part ;-)

	Ingo
