From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Generic battery interface
Date: Fri, 28 Jul 2006 08:25:35 -0400
Message-ID: <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:6199 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161134AbWG1MZh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Jul 2006 08:25:37 -0400
Received: by ug-out-1314.google.com with SMTP id m3so734713ugc
        for <linux-acpi@vger.kernel.org>; Fri, 28 Jul 2006 05:25:35 -0700 (PDT)
In-Reply-To: <20060728074202.GA4757@suse.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Shem Multinymous <multinymous@gmail.com>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Fri, Jul 28, 2006 at 03:27:00AM +0300, Shem Multinymous wrote:
> >
> > "Generic interface for accelerometers (AMS, HDAPS, ...)" on LKML, a
> > few weeks ago, about moving accelerator-based hard disk parking from
> > sysfs polling to the the input infrastructure. One unresolved issue
> > was how to find which input device happens to be the relevant
> > accelerometer.
>
> The current well known methods are:
>
>        1) udev/hotplug. It can create device nodes and symlinks based on the
>                capabilities and IDs of an input device.
>        1a) HAL. It has all the info from hotplug as well.
>        2) open them all and do the capability checks / IDs yourself.
>        3) (obsolete, deprecated) parse /proc/bus/input/devices, which
>                lists all the input devices
>

4) sysfs - all capabilities, IDs, etc for input devices exported there as well.

-- 
Dmitry
