From: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: RE: [ACPI] Re: [PATCH] Oops and panic while unloading holder of
 pm_idle
Date: Wed, 8 Sep 2004 21:14:00 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.53.0409082106460.15087@montezuma.fsmlabs.com>
References: <16A54BF5D6E14E4D916CE26C9AD305751210A8@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269281AbUIIBJe@vger.kernel.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305751210A8@pdsmsx402.ccr.corp.intel.com>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, acpi-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hello Shaohua,

> +		/* Wait the idle thread to read the new value, 
> +		 * otherwise we Oops.
> +		 */

I should have mentioned this earlier, but the comment needs work, 
something like this;

"We are about to unload the current idle thread pm callback (pm_idle), 
 Wait for all processors to update cached/local copies of pm_idle before 
 proceeding."

> +			/* If pm_idle is in a module and is preempted,
> +			 * oops occurs. Disable preempt.
> +			 */

"Mark this as an RCU critical section so that synchronize_kernel() in the 
 unload path waits for our completion."

Then resend the patch, i swear it'll be the last time ;)

Thanks,
	Zwane
