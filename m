From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC 1/1] ACPI: pci_irq, add PRT_ quirk for IBM Bartolo
Date: Tue, 12 Apr 2011 08:56:22 -0700
Message-ID: <20110412085622.43488ed9@jbarnes-desktop>
References: <4C87A62E.30108@gmail.com>
	<1302598086-3622-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1302598086-3622-1-git-send-email-jslaby@suse.cz>
Sender: linux-pci-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: jirislaby@gmail.com, Robert Hancock <hancockrwd@gmail.com>, mjg59@srcf.ucam.org, lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 12 Apr 2011 10:48:06 +0200
Jiri Slaby <jslaby@suse.cz> wrote:

> On IBM Bartolo machines, cards in 00:09.0 are defunct (if use
> interrupts). DSDT says that this slot (with function 0, i.e. pin A) is
> routed to \_SB_.PCI0.PIB_.LNKB. But it's not, it's wired to LNKC, so
> interrupts are misrouted. Add a quirk for this to workaround the
> issue.
> 
> References: https://bugzilla.novell.com/show_bug.cgi?id=595683
> References: https://bugzilla.kernel.org/show_bug.cgi?id=18092
> 
> ---
> Hi,
> 
> as Robert Hancock suggested at:
> http://lkml.org/lkml/2010/9/7/206
> 
> I reported this in bugzilla (the link above). But I got only replies
> requesting another infos which I provided. Could anybody look into
> the bug and confirm whether this patch is correct or not. And if yes,
> could you apply that?

I'll defer to the ACPI experts, Len or Matthew have you checked this
one out?

-- 
Jesse Barnes, Intel Open Source Technology Center
