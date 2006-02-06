From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] acpiphp: handle dock stations
Date: Mon, 6 Feb 2006 14:21:51 +0100
Message-ID: <20060206132151.GA1655@elf.ucw.cz>
References: <20060201233005.GA4999@nerpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59069 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932087AbWBFNWE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2006 08:22:04 -0500
Content-Disposition: inline
In-Reply-To: <20060201233005.GA4999@nerpa>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristenc@cs.pdx.edu>
Cc: pcihpd-discuss@lists.sourceforge.net, greg@kroah.com, len.brown@intel.com, linux-kernel@vger.kernel.org, muneda.takahiro@jp.fujitsu.com, linux-acpi@vger.kernel.org

Hi!

> This patch will add hot add/remove of docking stations to acpiphp.  Because
> some docking stations will have a _DCK method that is not associated with
> a dock bridge, we use the _EJD method to determine which devices are 
> dependent on the dock device, then try to find which of these dependent
> devices are pci devices.  We register a separate event handler with acpi
> to handle dock notifications, but if we have discovered any pci devices
> dependent on the dock station, we notify the acpiphp driver to rescan
> the correct bus.  If no pci devices are found, but there is still a _DCK method
> present, the driver will stay loaded to deal with the dock
> notifications.

Even while machine is locked in dock, I don't see aditional devices at
lspci. Is there some additional steps I need to do?

-rw-r--r--  1 root root 4096 Feb  6 14:17 attention

..should probably be write-only. It seems to only return errors on
read, anyway.

Is there a way to physicaly remove my machine from dock? echo 0 >
power should do it, right? Well, it does not :-).

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
