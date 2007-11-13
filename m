From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/5][RFC] Physical PCI slot objects
Date: Tue, 13 Nov 2007 09:01:29 -0800
Message-ID: <20071113170129.GA20185@kroah.com>
References: <20071113000853.GA13341@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759395AbXKMRF0@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071113000853.GA13341@ldl.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, matthew@wil.cx, richard.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 12, 2007 at 05:08:53PM -0700, Alex Chiang wrote:
> Hello,
> 
> [this patch series touches a few subsystems; hopefully I got all
> the right maintainers]
> 
> Recently, Matthew Wilcox sent out the following mail about PCI
> slots:
> 
>   http://marc.info/?l=linux-pci&m=119432330418980&w=2
> 
> The following patch series is a rough first cut at implementing
> the ideas he outlined, namely, that PCI slots are physical
> objects that we care about, independent of their hotplug
> capabilities.

I'm still not sold on this idea at all.  I'm really betting that there
is a lot of incorrect acpi slot information floating around in machines
and odd things will show up in these slot entries.

I say this because for a long time there was no "standard" acpi entries
for hotplug slots and different companies did different things.  Hence
the "odd" IBM acpi hotplug implementation as one example.  If this is
going to go anywhere, you need to get IBM to agree that it works
properly with all their machines...

Also, some companies already provide userspace tools to get all of this
information about the different slots in a system and what is where,
from userspace, no kernel changes are needed.  So, why add all this
extra complexity to the kernel if it is not needed?

thanks,

greg k-h
