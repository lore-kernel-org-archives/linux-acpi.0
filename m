From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Thu, 27 Jul 2006 23:07:53 +0300
Message-ID: <41840b750607271307w76016f07wf6c5a4a04a62e008@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011259C4@hdsmsx411.amr.corp.intel.com>
	 <41840b750607270923j21074661v6254ba52ec67b67a@mail.gmail.com>
	 <Pine.LNX.4.64.0607271236440.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:2699 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161054AbWG0UHz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jul 2006 16:07:55 -0400
Received: by ug-out-1314.google.com with SMTP id m3so458766ugc
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jul 2006 13:07:54 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0607271236440.9789@iabervon.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On 7/27/06, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Maybe it would be best to have a virtual driver that knows about the union
> of the features, and makes whatever features are provided by the
> underlying driver available to userspace. That way, all of the drivers are
> implementing features out of a shared set, so you don't end up with
> thinkpad/force_discharge and something/discharge_battery. This is the
> principle behind, for example, the generic cdrom driver, which doesn't
> actually implement much but rather provides uniformity across devices
> handled by different drivers.
>
> I don't think this is a case where each driver provides very similar
> functionality, but with critical differences which can't be corrected for;
> it seems like features are clearly available or not.

It's a bit trickier than it first looks.

For example, take the "force discharge" and "inhibit charge" commands.
Do they take effect until further notice, or for a given time period?
Whichever variant you pick, the ThinkPad hardware can't do it: you can
only tell it to force discharging until further notice, and you can
only tell it to avoid charging for N minutes. Note that the variants
cannot emulate each other, because when the laptop is suspended the
embedded controller still ticks but the kernel can't use timers to
issue new commands.

Another examle: suppose one hardware interface provide average power
reading while another interface provides only voltage and average
current. The two are not equivalent: if you try to compute power as
voltage*current you'll get inaccurate results, because power is the
integral over (instantaneous current)*(instantaneous voltage) and the
latter fluctuates. So you'd want to somehow prioritize the first
interface over the second, at least when it comes to power readings.

These details are inconsequential for most applications, but some do
care. So an interface that forces a certain view and hides the rest
may not be a good idea.

  Shem
