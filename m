From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [ACPI][2.6.10-rc3][SUSPEND] S3 mode - Cannot resume from PCI devices
Date: Tue, 14 Dec 2004 12:06:48 +0100
Message-ID: <20041214110648.GA2291@elf.ucw.cz>
References: <200412100315.21725.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200412100315.21725.shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I have netconsole configured I can see kernel messages on a remote machine, but when I suspend the laptop it goes into S3.
> I am unable to capture the (oops) the laptop when bringing it out of S3. It remains in a half suspended-unsuspended state.
> (the crescent moon LED is solidly on, video is back on (can see the 'Back to C!' string), cannot use sysctl key combos, 
> netconsole doesn't display the output since no PCI devices resume (the video is AGP onboard).
> 
> Is there any way I can capture this output somehow? I don't think even serial would work (it would be a USB to serial converter which would be PCI)
> or even trying to get this to print to lp0 since the laptop is totally unresponsive in its state.
> 
> I booted into single and sh for init, mounted /proc /sys and with no kernel modules it would fail to resume after suspending.
> 
> This isn't a nice regression.

So what was the last kernel where it worked?
										Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
