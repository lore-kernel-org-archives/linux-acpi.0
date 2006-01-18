From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 0/4]  Hot Dock/Undock support
Date: Wed, 18 Jan 2006 13:16:15 +0100
Message-ID: <20060118121615.GA13800@elf.ucw.cz>
References: <1137545813.19858.45.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46790 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030195AbWARMQf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 07:16:35 -0500
Content-Disposition: inline
In-Reply-To: <1137545813.19858.45.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org

Hi!

> This series of patches is against the -mm kernel, and will enable
> docking station support.  It is an early patch, but still pretty 
> functional, so I think it's worthwhile to include at this point.

They seem to be in 2.6.16-rc1-mm1 patch, good.

> Supported Features:
> * Hot Dock/Undock via hardware control
> * Enumeration of PCI Devices on Dock Station (Hot Add/Remove) via pci 
> 
> Not Supported Yet (but will be with laptops with sane dsdts):
> * _EJD, _EDL support for devices that aren't enumerable
> * hot add of devices other than PCI devices (such as the serial/lpt etc).
> * More thorough testing needs to be done for everything, but especially
>   video, as I've not even begun to worry about that.
...
> Please comment on these patches, and test if you have a docking station
> available.  When you find problems, if you would like me to debug them,
> please load the acpiphp driver with the debug param (modprobe
> acpiphp debug=1),

I'll try to test them and write some small docking HOWTO (or maybe
force you to write it :-). This is not exactly easy to setup...
								Pavel
-- 
Thanks, Sharp!
