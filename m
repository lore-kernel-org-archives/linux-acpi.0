From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Generic battery interface
Date: Sun, 30 Jul 2006 13:46:12 +0200
Message-ID: <20060730114612.GB4898@suse.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com> <41840b750607280819t71f55ea7off89aa917421cc33@mail.gmail.com> <d120d5000607280910t458fb6e0hdb81367b888a46db@mail.gmail.com> <20060730085500.GB17759@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:44516 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932274AbWG3LqP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Jul 2006 07:46:15 -0400
Content-Disposition: inline
In-Reply-To: <20060730085500.GB17759@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shem Multinymous <multinymous@gmail.com>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On Sun, Jul 30, 2006 at 01:55:00AM -0700, Greg KH wrote:

> No, ick, why would you want that?
> 
> Just look at the "dev" file in sysfs, which shows the major:minor
> number.
> 
> Or just look at the directory that you are in, and that's almost always
> the /dev node name.
> 
> For example, /sys/block/sda/sda1/ is /dev/sda1.
> /sys/class/tty/ttyS1 is /dev/ttyS1.
> 
> It's usually not that difficult to do the mapping :)
 
But it's wrong to rely on it API-wise. 

-- 
Vojtech Pavlik
Director SuSE Labs
