From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/7] resource, PNPACPI: add bus number and window
 support
Date: Sat, 6 Mar 2010 11:50:37 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1003061145260.31447@localhost.localdomain>
References: <20100305174656.21946.93874.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100305174656.21946.93874.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <abelay@mit.edu>
List-Id: linux-acpi@vger.kernel.org



I have nothing against this patch-series, but I'm not really much of a 
pnp person, so I'd like to see this at a minimum being acked by people who 
are, and who would use this. 

In fact, since the primary _reason_ for this seems to be to improve on the 
_CRS parsing code for PCI, I'd have expected that the people involved 
with previous _CRS issues be involved, and perhaps this whole thing could 
go through the PCI tree? But Yinghai Lu and Jesse Barnes weren't even 
cc'd. 

But maybe this really is more of an ACPI issue. I dunno. I get the feeling 
that ACPI doesn't really care, though - the subsystem that actually gets 
_affected_ by all this in the end is PCI.

Anyway, more acks, please. And preferably involve the PCI people too.

			Linus
