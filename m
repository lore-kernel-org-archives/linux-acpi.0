From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 0/5][RFC] Physical PCI slot objects
Date: Tue, 13 Nov 2007 11:33:53 -0700
Message-ID: <20071113183353.GE17785@parisc-linux.org>
References: <20071113000853.GA13341@ldl.fc.hp.com> <20071113170129.GA20185@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760861AbXKMSeS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071113170129.GA20185@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alex Chiang <achiang@hp.com>, gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, richard.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 13, 2007 at 09:01:29AM -0800, Greg KH wrote:
> I'm still not sold on this idea at all.  I'm really betting that there
> is a lot of incorrect acpi slot information floating around in machines
> and odd things will show up in these slot entries.

Is that the end of the world?  Instead of having no information, we'll
end up with odd information.  If people complain, we can always
blacklist (indeed, won't the ACPI rolling blacklist catch the majority
of these machines?)

> I say this because for a long time there was no "standard" acpi entries
> for hotplug slots and different companies did different things.  Hence
> the "odd" IBM acpi hotplug implementation as one example.  If this is
> going to go anywhere, you need to get IBM to agree that it works
> properly with all their machines...

Not in terms of slot names.  There were various things that ACPI didn't
specify, like attention and latches, but the description of _SUN hasn't
changed.

> Also, some companies already provide userspace tools to get all of this
> information about the different slots in a system and what is where,
> from userspace, no kernel changes are needed.  So, why add all this
> extra complexity to the kernel if it is not needed?

Do you have any examples of this?

We should, IMO, be improving the way we tell users which device has
a problem.  'tulip7', 'eth4', 'pci 0000:04:1e.3' ... all the user wants
to know is which damn card it is so they can replace it.  And slot name
tells them that.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
