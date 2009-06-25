From: Richard Purdie <rpurdie@linux.intel.com>
Subject: Re: a backlight issue
Date: Thu, 25 Jun 2009 10:39:41 +0100
Message-ID: <1245922781.6001.34.camel@dax.rpnet.com>
References: <1245895749.7266.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:21862 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750866AbZFYJlM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jun 2009 05:41:12 -0400
In-Reply-To: <1245895749.7266.70.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

Hi,

On Thu, 2009-06-25 at 10:09 +0800, yakui_zhao wrote:
>     On some boxes there is neither generic ACPI backlight I/F nor
> platform backlight I/F. That means that the backlight brightness can't
> be changed by using sys backlight I/F. But the backlight brightness can
> be changed by using the driver backlight I/F. For example: on the box
> based on intel-integrated graphics card the backlight brightness can
> also be changed by using the LBB register in pci device. 
>     Can the graphics driver register the sys backlight I/F so that we
> can change the backlight by using sys I/F? 
>     
>     If the graphics driver can also register the backlight I/F, it seems
> that we can register three types of backlight I/F.
>     a. generic ACPI backlight I/F. This is registered by acpi video
> driver.
>     b. platform backlight I/F. This is registered by the platform driver
>     c. graphics backlight I/F. This can be registered by the graphics
> driver.
> 
>     As there exist three types of backlight I/F, how can we make the
> coordination among the three backlight I/F? In fact only one backlight
> I/f is enough for user to change the brightness.

I think in the short term you're right and that there needs to be
something acpi specific as a backlight arbitrator. This problem is quite
specific to acpi. Its worth thinking about the wider picture too though.

Taking a machine with say, three graphics cards in it, what should
happen? It should probably register one control for each screen with an
adjustable backlight so if each card was dual head you'd get 6 controls.

The key problem is knowing which backlight interface corresponds to
which driver+screen. If we had that information, exporting your three
interfaces above might be less of an issue as userspace could tell they
were for the same hardware. The kernel could pick the best interface
internally too, if it can tell they're for the same screen.

I suspect at this point we've gone far beyond the environment the sysfs
backlight interface was designed for and we'd be better off having the
backlight control in parallel with the other screen data which probably
runs through the DRM code.

Even then its not straightforward though as even just considering the
i915 driver, can it always use the i915 registers for the backlight or
does it sometimes have to make ACPI calls?

Cheers,

Richard

-- 
Richard Purdie
Intel Open Source Technology Centre

