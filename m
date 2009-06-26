From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH v3 11/12] ACPI: video: convert to acpi_get_pci_dev
Date: Fri, 26 Jun 2009 13:28:17 -0600
Message-ID: <20090626192817.GD16840@ldl.fc.hp.com>
References: <20090610194714.28982.51363.stgit@bob.kio> <20090610195600.28982.3404.stgit@bob.kio> <81b0412b0906251538j2614bf91ya2edbaf120796dfc@mail.gmail.com> <20090625230535.GE1723@ldl.fc.hp.com> <81b0412b0906260356p12fd7807y40223175bf785cc0@mail.gmail.com> <81b0412b0906260528j229f7e05i3c473fbdb643a2dd@mail.gmail.com> <20090626121926.12fccba0@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090626121926.12fccba0@jbarnes-g45>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Alex Riesen <raa.lkml@gmail.com>, lenb@kernel.org, twmoure@szypr.net, alessandro.suardi@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

* Jesse Barnes <jbarnes@virtuousgeek.org>:
> 
> Here's the output from my machine, including ACPI paths (summary of not
> found stuff at the top):
> 
> ...
> [    0.177188] + Adding \_SB_.PCI0.AGP_
> [    0.177294] pci_bus 0000:00: I'm a little pci_bus, short and stout...
> [    0.177407] Searching for 0000:00:01.0...not found
> ...
> [    0.179259] + Adding \_SB_.PCI0.EXP2
> [    0.179364] pci_bus 0000:00: I'm a little pci_bus, short and stout...
> [    0.179477] Searching for 0000:00:1c.2...not found
> ...
> [    0.180128] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP3._PRT]
> [    0.180200] Starting root bridge search from \_SB_.PCI0.EXP3.EXUP
> [    0.180310] + Adding \_SB_.PCI0.EXP3.EXUP
> [    0.180418] + Adding \_SB_.PCI0.EXP3
> [    0.180523] pci_bus 0000:00: I'm a little pci_bus, short and stout...
> [    0.180636] Searching for 0000:00:1c.3...found
> [    0.180787] Searching for 0000:05:00.0...not found
> ...
> 
> So looks like one is an express slot, another is the AGP this machine
> lacks, and then there's this 05:00.0; not sure what that is.
> 
> At any rate, it does appear we have to take care not to assume
> *everything* in the ACPI tree has an associated PCI dev, since
> namespaces could be shared accross different platforms with just enable
> or present bits to mask them out from the initial PCI scan.

Yup, as per our irc discussion, I'm now a lot more confident that
this was the root cause.

Troy's original patch is correct, just needs an explanation of
_why_. :)

I'll send a patch updating acpi_get_pci_dev() with a comment that
explains the "why".

Thanks everyone.

/ac
