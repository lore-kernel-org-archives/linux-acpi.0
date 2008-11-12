From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Wed, 12 Nov 2008 00:27:38 +0000
Message-ID: <20081112002738.GA949@srcf.ucam.org>
References: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain> <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu> <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com> <20081110083938.GD22392@elte.hu> <20081110115732.GA30181@srcf.ucam.org> <20081110125630.GC28643@elte.hu> <20081110130029.GC30894@srcf.ucam.org> <alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47766 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809AbYKLA2F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2008 19:28:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Avi Kivity <avi@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

On Tue, Nov 11, 2008 at 06:14:31PM -0500, Len Brown wrote:
> On Mon, 10 Nov 2008, Matthew Garrett wrote:
> > All we need now is confirmation as to which versions of Windows use this 
> > behaviour.
> 
> We knows XP and Vista do it.

How would you feel about having a global variable bitfield containing 
the operating systems the firmware queries, and then keying decisions 
like this off that?

> But upstream doesn't currently check the FADT.flags.reset-reg-supported bit
> due to a recent bad guess on my part on how to be bug compatible with 
> windows.

Mm. Getting that right is probably important, as is trying to figure out 
why we break on certain machines in that case. Is it possible that going 
via the keyboad controller tends to cause an implicit reset in it that's 
not mimiced by the i8042 shutdown code?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
