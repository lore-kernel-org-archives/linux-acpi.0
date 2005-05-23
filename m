From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 2/2] x86_64: Collect host bridge resources
Date: Mon, 23 May 2005 18:15:07 +0200
Message-ID: <20050523161507.GN16164@wotan.suse.de>
References: <20050521004239.581618000@csdlinux-1> <20050521004506.842235000@csdlinux-1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261900AbVEWQPN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050521004506.842235000@csdlinux-1>
Sender: linux-kernel-owner@vger.kernel.org
To: rajesh.shah@intel.com
Cc: ak@suse.de, len.brown@intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Fri, May 20, 2005 at 05:42:41PM -0700, rajesh.shah@intel.com wrote:
> This patch reads and stores host bridge resources reported by
> ACPI BIOS for x86_64 systems. This is needed since ACPI hotplug
> code now uses the PCI core for resource management. This patch
> simply adds the boot parameter (acpi=root_resources) to enable
> the functionality that is implemented in arch/i386.
> 

This means all hot plug users have to pass this strange parameter?
That does not sound very user friendly. Especially since you usually
only need pci hotplug in emergencies, and then you likely didnt pass it.

Cant you find a way to do this without parameters? Any reason
to not make it default?

-Andi
