From: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [ACPI] Re: [RFC/Patch 0/12] ACPI based root bridge hot-add
Date: Mon, 21 Mar 2005 14:57:16 -0800
Message-ID: <20050321145716.A7200@unix-os.sc.intel.com>
References: <20050321203408.74684.qmail@web50205.mail.yahoo.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321203408.74684.qmail@web50205.mail.yahoo.com>; from i_p_a_u_l@yahoo.com on Mon, Mar 21, 2005 at 12:34:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Ionescu <i_p_a_u_l@yahoo.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 21, 2005 at 12:34:07PM -0800, Paul Ionescu wrote:
> 
> --- Rajesh Shah <rajesh.shah@intel.com> wrote:
> > 
> > No. The current patches only trigger when a _root_ bridge is
> > hot-added, not a PCI to PCI bridge (which is what the docking 
> > station is). The code to support p2p bridge hotplug will benefit
> > from these patches but more code is needed to support that.
> > 
> 
> Thanks for the info.
> Is p2p hotplug in your roadmap (for i386) ?
> Can you please give me an example of a root bridge ?
> 
I believe others are already working on it. I expect to free up
a bit more in a couple of weeks.  If I don't see any patches or
indication of activity by then, I'll work on adding this support
too.

Rajesh
