From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: backlight mystery
Date: Mon, 5 Mar 2007 23:48:12 -0800
Message-ID: <20070305234812.d8b2b08d.akpm@linux-foundation.org>
References: <20070305233037.0c5727e7.akpm@linux-foundation.org>
	<20070306074312.GC23955@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:54904 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933986AbXCFHsX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Mar 2007 02:48:23 -0500
In-Reply-To: <20070306074312.GC23955@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-acpi@vger.kernel.org

On Tue, 6 Mar 2007 02:43:12 -0500 Dave Jones <davej@redhat.com> wrote:

> On Mon, Mar 05, 2007 at 11:30:37PM -0800, Andrew Morton wrote:
>  > 
>  > I always get stuff like this coming out when I boot my x86_64 machine:
>  > 
>  > asus_acpi: Unknown symbol backlight_device_unregister
>  > asus_acpi: Unknown symbol backlight_device_register
>  > ibm_acpi: Unknown symbol backlight_device_unregister
>  > ibm_acpi: Unknown symbol backlight_device_register
>  > toshiba_acpi: Unknown symbol backlight_device_unregister
>  > toshiba_acpi: Unknown symbol backlight_device_register
>  > video: Unknown symbol backlight_device_unregister
>  > video: Unknown symbol backlight_device_register
>  > 
>  > This is a nocoma server, not a laptop.  I'm not sure how those modules are
>  > even getting loaded.  The distro is FC4, which might be doing something
>  > peculiar.  
> 
> I covered this on the list last week.  There's no way to
> have a module autoload based on dmi strings or the like,
> (Which is the only sane way these modules can determine
>  if they need to run).
> 
> Given the absense of mechanism, there's a pretty gross hack
> in Fedora's rc.sysinit which loads every module in drivers/acpi/*/*
> that it finds.  Shameful I know.
> 
> 	Dave

I thought it might be something like that.  I'm a bit surprised that we
can't get at the DMI stuff from userspace, or export it from the kernel. 
But whatever.

Something appears to have gone wrong with the dependencies though - the
load of the acpi drivers should have triggered a load of the backlight
driver.

