From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI][2.6.10-rc3][SUSPEND] S3 mode - Cannot resume from PCI devices
Date: Fri, 10 Dec 2004 15:20:10 +0100
Message-ID: <20041210142010.GA3654@openzaurus.ucw.cz>
References: <200412100315.21725.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262236AbULMMKr@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200412100315.21725.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Starr <shawn.starr@rogers.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi!

> I have netconsole configured I can see kernel messages on a remote machine, but when I suspend the laptop it goes into S3.
> I am unable to capture the (oops) the laptop when bringing it out of S3. It remains in a half suspended-unsuspended state.
> (the crescent moon LED is solidly on, video is back on (can see the 'Back to C!' string), cannot use sysctl key combos, 
> netconsole doesn't display the output since no PCI devices resume (the video is AGP onboard).
> 
> Is there any way I can capture this output somehow? I don't think even serial would work (it would be a USB to serial converter which would be PCI)

If you can see Back to C, your video works, just capture oops
with paper and pencil.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
