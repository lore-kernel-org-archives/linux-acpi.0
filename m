From: Alex Williamson <alex.williamson@hp.com>
Subject: Re: [RFC] dev_acpi: device driver for userspace access to ACPI
Date: Tue, 03 Aug 2004 15:02:16 -0600
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1091566936.4981.188.camel@tdi>
References: <1091552426.4981.103.camel@tdi>
	 <1091554271.27397.5327.camel@nighthawk>  <1091557050.4981.135.camel@tdi>
	 <1091558040.27397.5523.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266737AbUHCVC0@vger.kernel.org>
In-Reply-To: <1091558040.27397.5523.camel@nighthawk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: acpi-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-08-03 at 11:34 -0700, Dave Hansen wrote:

> Instead of architecting a generic interface, might you simply exclude
> access from your driver to things that already have generic interfaces? 
> I think there are things that we exclude from /proc/device-tree on ppc64
> because there's a generic equivalent elsewhere.  
> 

   The access interfaces I'm exposing are pretty simple building block
type features.  It's a toolset to poke at namespace, not a predefined
set of device specific functions.  I'm sure you can mix them all
together and duplicate something that already exists, but trying to
kludge in limitations sounds futile and would reduce the usefulness of
the entire interface.  Besides, given a choice, I kinda doubt people are
going to choose to implement something that requires them to know about
ACPI ;^)

> There are certainly some very platform-specific things that obviously
> need to be done with direct access to the firmware, and that we don't
> want to pollute the kernel with.  Parsing some of the firmware error
> logs on ppc64 comes to mind.  You just need to be *very* careful with
> the application authors because it's such a big gun :)

   This is certainly a big gun, but in the software world, I'd rather
have a big gun available than no gun at all.  Thanks for the comments,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab
