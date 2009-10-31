From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 3/3] ACPI: battery: register power_supply subdevice
 even when battery not present
Date: Sat, 31 Oct 2009 03:58:18 +0200
Message-ID: <1256954298.9681.14.camel@maxim-laptop>
References: <4A098D0A.6090509@tuffmail.co.uk>
	 <1252291027.4627.2.camel@maxim-laptop>  <4AA4FCC3.2090805@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:47483 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757624AbZJaB6U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Oct 2009 21:58:20 -0400
Received: by fg-out-1718.google.com with SMTP id d23so72742fga.1
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2009 18:58:23 -0700 (PDT)
In-Reply-To: <4AA4FCC3.2090805@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Mon, 2009-09-07 at 13:29 +0100, Alan Jenkins wrote: 
> Maxim Levitsky wrote:
> > On Tue, 2009-05-12 at 15:51 +0100, Alan Jenkins wrote:
> >   
> >> Keeping this device around lets userspace know that we have a battery
> >> bay, even if there is nothing in it at the moment.  This is what every
> >> other battery driver does, so ACPI should do it as well.
> >>
> >> There is no reason to preserve the old behaviour.  We now correctly
> >> provide the "present" attribute, which will return "0" when the battery
> >> is removed.  HAL was already trying to check this attribute, so
> >> it should be fine.
> >>
> >> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> >>     
> >
> > What happened to this patch?
> >
> > I still get the issue this patch attempts to fix:
> >
> > maxim@maxim-laptop:~/software/kernel/linux-2.6$
> > ls /sys/class/power_supply/
> > AC
> > maxim@maxim-laptop:~/software/kernel/linux-2.6$
> > ls /sys/class/power_supply/
> > AC  BAT0
> > maxim@maxim-laptop:~/software/kernel/linux-2.6$
> > ls /sys/class/power_supply/
> > AC
> > maxim@maxim-laptop:~/software/kernel/linux-2.6$ uname -r
> > 2.6.31-rc8-next-20090904-next
> > maxim@maxim-laptop:~/software/kernel/linux-2.6$ 
> >
> >
> > When I unplug the battery, its sysfs entry disappears.
> > Thus if system was booted without battery, there will be no way to know
> > system has one.
> >
> > This patch doesn't apply.
> >   
> 
> I rebased these patches a while back
> 
> http://patchwork.kernel.org/patch/33118/
> http://patchwork.kernel.org/patch/33119/
> http://patchwork.kernel.org/patch/33120/
> 
> you should find these will still apply.
> 
> Regards
> Alan


Any progress on adding special battery bay device?

Best regards,
Maxim Levitsky

