From: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: hot-addacpi-hotplug-decouple-slot-power-state-changes-from-physical-hotplug.patch
Date: Mon, 18 Apr 2005 16:28:03 -0700
Message-ID: <20050418162803.B408@unix-os.sc.intel.com>
References: <20050416184613.85317.qmail@web50202.mail.yahoo.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261200AbVDRX2R@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050416184613.85317.qmail@web50202.mail.yahoo.com>; from i_p_a_u_l@yahoo.com on Sat, Apr 16, 2005 at 11:46:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Ionescu <i_p_a_u_l@yahoo.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Apr 16, 2005 at 11:46:13AM -0700, Paul Ionescu wrote:
> 
> Was this setup supposed to work ?
> 
Not yet, sorry. This patch was simply decoupling the power state
of the device from its physical presence in the slot. It had 
nothing to do about programming p2p bridges and subordinate
devices correctly.

I know some folks from Fujitsu are working on this and should
be sending out patches shortly. Not sure if these will support
docking stations fully but even if they don't, we'll have a better
starting base to build on.

Rajesh
