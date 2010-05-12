From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Automatic S1 sleep
Date: Wed, 12 May 2010 09:39:08 -0400
Message-ID: <4BEAAF7C.6070004@cfl.rr.com>
References: <4BE97FC9.4040302@cfl.rr.com> <alpine.LFD.2.00.1005120133190.5297@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from exhub016-1.exch016.msoutlookonline.net ([207.5.72.163]:42345
	"EHLO EXHUB016-1.exch016.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753965Ab0ELNjO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 May 2010 09:39:14 -0400
In-Reply-To: <alpine.LFD.2.00.1005120133190.5297@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On 5/12/2010 1:57 AM, Len Brown wrote:
> I'm not aware of any ACPI systems that can keep the display enabled
> when in S1 (or S3).  If you've been able to get into this state,
> I'd like to know more about it.

If it is a laptop I would imagine that S1 would power down the display,
but on my desktop the display remains visible during S1, though I would
not expect that while the video card is in D3Hot as I believe it is.  I
did pull out my trusty Kill-a-watt last night and measure the load and
it remained 120 watts both idle ( no C states, but cpufreq downclocked
to 1 GHz and rotating disks spun down with hdparm -y ) and in S1.

I also tried using setpci to force the video card into D1 and did not
see any change in load, though at 120 watts, I may be hitting the lower
efficiency bound of my PSU, so it may have saved a watt and it just
didn't make it past the psu to the Kill-a-watt to be measured.  Also as
I mentioned before, there seem to be control registers in the radeon
that the bios is supposed to configure for what power saving options are
wanted in D1 and D2, so it is possible that since this is a desktop, it
may not be set up to save much power.

> Please measure the power difference between S0 and S1 -- don't assume
> that S1 consumes less power than S0.  Also, note that the latency
> difference between S1 and S3 may effectively be 0.

There currently is not much difference in latency between S1 and S3, but
I believe that this is more the fault of the kernel, since when it
resumes from S1 it still does full device reinitialization just like it
does for S3, when most devices do not require that to come out of D3Hot,
and indeed, devices that do not support the power management capability
remain in D0 for S1.  A good chunk of the time spent suspending and
resuming was being spent waiting for disks to spin down/up, but I put a
stop to that by changing the scsi_disk's manage_start_stop entry in
sysfs from 1 to 0.  After that total time to resume from S1 was around
500ms.  I believe that if the display did not get blanked and redrawn
and other unnecessary hardware reinitialization was not done, S1 resume
could take as little as 10-50ms.
