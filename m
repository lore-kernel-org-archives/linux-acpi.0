From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Sun, 30 Jul 2006 14:33:01 +0300
Message-ID: <41840b750607300433t7a0c3708q1bd1ccbcfca9c31d@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz>
	 <20060728134307.GD29217@suse.cz> <20060730091848.GC3801@elf.ucw.cz>
	 <41840b750607300314t3280fd04ne17bb663c385fd6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:41546 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932270AbWG3LdD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Jul 2006 07:33:03 -0400
Received: by ug-out-1314.google.com with SMTP id m3so343169ugc
        for <linux-acpi@vger.kernel.org>; Sun, 30 Jul 2006 04:33:01 -0700 (PDT)
In-Reply-To: <41840b750607300314t3280fd04ne17bb663c385fd6b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org, Greg KH <greg@kroah.com>, Jean Delvare <khali@linux-fr.org>

On 7/30/06, Shem Multinymous <multinymous@gmail.com> wrote:
> Alternatively, we can add an extra parameter to that new
> syscall/ioctl: "block until the time is T+N and you have a refresh
> that was received from the hardware at time T+M, whichever is later"
> (where T is the current time and N>M).
>
> That's semantically equivalent to an msleep(M) followed by the
> original delayed_update(N-M),  but will save one timer interrupt per
> iteration in some cases (e.g., an event-based hardware data source).

No, wait, the explicit two-parameter version is far superior.

First, it makes it easier to poll multiple attributes. How'd you do
that with the one-parameter version, if you need to sleep separately
for each attribute?

Second, it gives the driver (or its sysfs support infrastructure) a
better picture of the future, which it can use to optimize the
hardware query scheduling. No, I don't think anyone will implement
*that* soon, but it's good to have an API that lets us add it later
without affecting userspace.


Is anyone interested in adding this "delayed updates" support to
sysfs, for the benefit of hwmon, tp_smapi and probably numerous other
drivers?
I have some ideas for how to do it so that that per-driver support is
really easy (or even free), but I don't know sysfs well enough to
implement it and don't have the resources.

  Shem
