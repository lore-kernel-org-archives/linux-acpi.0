From: Janosch Machowinski <scotch@tzi.de>
Subject: Re: High pitched sound with 2.6.15-ck1 --  Update info
Date: Sat, 28 Jan 2006 12:10:19 +0100
Message-ID: <43DB511B.5020605@tzi.de>
References: <200601280105.44804.gkanis@cems.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m1.informatik.uni-bremen.de ([134.102.201.18]:62460 "EHLO
	informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S932131AbWA1LJI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Jan 2006 06:09:08 -0500
In-Reply-To: <200601280105.44804.gkanis@cems.umn.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vasileios Gkanis <gkanis@cems.umn.edu>
Cc: linux-acpi@vger.kernel.org

Vasileios Gkanis wrote:
> Hi,
> 
> I had some free time and I was switching from one C-state to another to check 
> when I hear this high pitched sound, I discover the following:
> 
> When the system is in the C4-state I hear this high pitched sound only when 
> the USB-mouse is plugged in!  If I unplug the mouse, the sound is not audible 
> anymore. If I plug in the USB-stick the sound is not audible!  I did some 
> experiments and I found that when the system is in the C3 or C4-state, I hear 
> the sound only when the USB-mouse is plugged in. On the other hand, in the C1 
> or C2-state the sound is not audible regardless of whether the USB-mouse is 
> plugged in or not. 
> I see a similar behavior in windows, but the only difference is that the sound 
> is not audible when the USB-stick and the USB-mouse are both plugged in!
> 
> Does anybody have any idea why this is happening?
> 
Jep,
this happens because your power converters starts "singing". If
you switch the C-State, you need a different amount of power. So if
you have a kernel frequency of 1000 herz, your power converter has
to adjust the amount of power 1000 times per second. And because
of that it starts "singing". By the way, you can also modulate the sound
by scaling your CPU frequency up or down. (Perhaps you could also write
a programm, that can play some melody based on this phaenomenon ;-) )

    Janosch
