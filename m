From: Greg KH <greg@kroah.com>
Subject: Re: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Date: Fri, 5 Nov 2004 10:05:13 -0800
Message-ID: <20041105180513.GA32007@kroah.com>
References: <20041105001328.3ba97e08.akpm@osdl.org> <20041105164523.GC1295@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262731AbUKESGr@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041105164523.GC1295@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>, rml@novell.com, linux-kernel@vger.kernel.org, len.brown@intel.com, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 05, 2004 at 05:45:23PM +0100, Adrian Bunk wrote:
> The following error (compin from Linus' tree) is caused by the fact that 
> hotplug_path is no longer EXPORT_SYMBOL'ed:
> 
> 
> <--  snip  -->
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.10-rc1-mm3; fi
> WARNING: /lib/modules/2.6.10-rc1-mm3/kernel/drivers/acpi/container.ko needs unknown symbol hotplug_path
> 
> <--  snip  -->

Hm, must be an -mm specific change that is causing this.  I don't see
this in the current tree.

Len, why would any ACPI code be wanting to get access to hotplug_path
directly?

thanks,

greg k-h
