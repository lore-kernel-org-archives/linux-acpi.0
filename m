From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC] dev_acpi: device driver for userspace access to ACPI
Date: Tue, 03 Aug 2004 10:31:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1091554271.27397.5327.camel@nighthawk>
References: <1091552426.4981.103.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266741AbUHCRbr@vger.kernel.org>
In-Reply-To: <1091552426.4981.103.camel@tdi>
To: Alex Williamson <alex.williamson@hp.com>
Cc: acpi-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-08-03 at 10:00, Alex Williamson wrote:
>    This is by no means ready for release, but I wanted to get a sanity
> check.  I'm still stuck on this idea that userspace needs access to ACPI
> namespace.  Manageability apps might use this taking inventory of
> devices not exposed by other means, things like X can locate chipset
> components that don't live in PCI space, there's even the possibility of
> making user space drivers.

The only thing that worries me about a patch like this is that it
encourages people to write arch-specific tools that have no chance of
working on multiple platforms.  

Right now, on ppc64, we have a system for making direct calls into the
firmware, as well as a copy of the firmware's device-tree exported to
userspace.  This means that we have userspace applications that do very
generic things like counting CPUs, or activating memory in very
arch-specific ways.  

Creating more of these interfaces encourages more of these arch-specific
applications, and what we end up with are lots of tools that only work
on Intel platforms or IBM ppc, but not Linux in general.

So, what kinds of generic, arch-independent interfaces should we
implement in the kernel that would reduce the need for something like
your driver?

-- Dave
