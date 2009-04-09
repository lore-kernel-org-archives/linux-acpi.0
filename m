From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [RFC] [intel-gfx] :The backlight issue when KMS is used
Date: Thu, 09 Apr 2009 09:12:19 +0800
Message-ID: <1239239539.3635.46.camel@localhost.localdomain>
References: <1238737778.3582.163.camel@localhost.localdomain>
	 <20090407073845.GA15635@srcf.ucam.org>
	 <1239152179.3635.8.camel@localhost.localdomain>
	 <200904081217.15667.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:18545 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752523AbZDIBLI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Apr 2009 21:11:08 -0400
In-Reply-To: <200904081217.15667.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, "sonne@debian.org" <sonne@debian.org>, "Zhang, Rui" <rui.zhang@intel.com>, "rpurdie@linux.intel.com" <rpurdie@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, 2009-04-08 at 18:17 +0800, Thomas Renninger wrote:
> Hi,
> 
> We have these interfaces:
>   - vendor specific implementation
>     (mostly in drivers/platform/x86/vendor-laptop.c)
>   - ACPI generic backlight only
>   - Opregion (this is the KMS/i915 interface you are talking about
>     or is there another abstraction?)
IMO it is unnecessary to consider the Opregion as the interface. In fact
it is only for the communication between the ACPI and graphics driver.
We can send the request by using ACPI generic backlight and then the
brightness is changed in the graphics driver.
>   - Possibly other graphics card specific coming up with KMS?
>   - X-server is doing it (UMS)
Yes. For example: three other control methods are provided in UMS for
intel driver. Native/ Legacy/ Combo mode. 
   And the control methods are hook up by Xrandr tool.
> 
> Matthew and Jesse are looking for following approach:
> Let all drivers try to register for the generic backlight interface.
> As we do not know which driver will get loaded first, you want to 
> detect whether another driver already registered the backlight
> interface and implement a priority to eventually let the newly
> loaded driver unregister the other driver's backlight device, notify
> this driver via a notifier chain and then register the own backlight
> interface (is that correct?).
   
> Priority could look like:
> 1) vendor specific drivers
> 2) ACPI generic drivers
> 3) Graphics card's specific kernel drivers (IGD/Opregion and possibly
>    others)
> 3 has highest prio.
> 
> If I got that right, I do not like:
>   - the complexity that has to be added to the generic backlight
>     interface and each backlight driver.
>   - The fact that several HW access mechanisms might be used. That
>     all are working is rather unlikely. Once e.g. Windows is only
>     using IGD, OEMs might still have a not working vendor specific
>     solution remaining in their BIOSes. If the vendor specific
>     solution is registered first the machine might in worst case
>     freeze, before the i915 driver could have taken over.
> 
> Whatabout a similar approach like video_detect which checks for
> ACPI generic functions and fills a global variable which mechanism
> to go for before module load time.
> 
> If the i915 backlight switching is the IGD implementation, then
> video_detect.c is nearly already sufficient. All that has to be
> added is whether generic ACPI backlight functions support IGD and
> acpi_video_backlight_support() must not only return true/false, but
> e.g.:
>   1 (no acpi things, go for vendor specific)
>   2 (generic ACPI functions, but no IGD, go for video.ko)
>   3 (generic ACPI functions and IGD, video.ko will not register for
>      backlight)
> 
> The main problem with that approach is (for IGD it might not be that
> hard, but for other upcoming graphics cards?), that if the card has
> to be set up first in a complex way (e.g. atombios things for Radeon 
> must be parsed before) you have to statically compile in all necessary
> things to check whether the later loaded graphics cards driver can
> serve backlight functionality or not.
> If upcoming other graphics cards kernel drivers all can do backlight
> switching on all cards, it could simply be checked for:
> "vendor pci id of the graphics card" + "KMS set in .config"
What you said is also OK. 
But I don't know whether this will make the problem complex.
This issue I raised is related with that no backlight can be controlled
by xrandr tool after using KMS.
    For example: >http://bugs.freedesktop.org/show_bug.cgi?id=20963
   
    On this box neither generic ACPI backlight I/F nor platform
backlight I/F exists. In UMS mode the backlight can be controlled by
xrandr(the specific control method is used). But in KMS mode the
specific control method is realized in kernel space and this is not
exposed to user space. In such case the backlight can't be controlled.
    And we expect that the backlight still can be controlled by xrandr
tool in KMS mode.

Another issue is the inconsistency between the ACPI backlight I/F and
specific control method. 
    For example: there exists the generic ACPI backlight I/F and this
depends on intel opregion. If the legacy control method is selected,
then ACPI backlight I/F can't report the correct brightness after the
brightness is changed by xrandr tool. 
    So we expect to avoid the inconsistency in KMS mode.
> 
> Advantage:
>   - It does not have above mentioned disadvantages
>   - It's easy to add boot params or a blacklist to fallback to another
>     backlight solution
> 
> Disadvantage:
>   - You have the backlight functionality detection code
>     compiled into the kernel
>   - The code could get complex if graphics cards have to be set up
>     or similar to check whether a KMS graphics driver will be able
>     to do backlight switching
> 
>      Thomas

