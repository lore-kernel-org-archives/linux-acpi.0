From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Sun, 30 Jul 2006 15:50:08 +0300
Message-ID: <41840b750607300550r4337a8e1n1d6f93db1dde46c8@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
	 <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com>
	 <41840b750607280819t71f55ea7off89aa917421cc33@mail.gmail.com>
	 <d120d5000607280910t458fb6e0hdb81367b888a46db@mail.gmail.com>
	 <20060730085500.GB17759@kroah.com>
	 <41840b750607300252w445974b1udedf1a67114d1580@mail.gmail.com>
	 <20060730114741.GC4898@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:34467 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751332AbWG3MuK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Jul 2006 08:50:10 -0400
Received: by ug-out-1314.google.com with SMTP id m3so356837ugc
        for <linux-acpi@vger.kernel.org>; Sun, 30 Jul 2006 05:50:08 -0700 (PDT)
In-Reply-To: <20060730114741.GC4898@suse.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On 7/30/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Sun, Jul 30, 2006 at 12:52:52PM +0300, Shem Multinymous wrote:
>
> > Coming to think of it, to solve the dev->sys direction, maybe we
> > should have symlinks like the following?
> > /sys/dev/8/0 -> /sys/block/sda
> > /sys/dev/11/0 -> /sys/block/sr0
> > /sys/dev/116/24 -> /sys/class/sound/pcmC0D0c
>
> Since you can have more nodes in /dev with the same node numbers, and
> this actually is useful (for granting more users/groups access to the
> devices in question), this is not going to fly.

No, I'm talking about the *other* direction now: I'm looking at a file
in /dev and I want to find the corresponding sysfs device (if any).

Anyway turns out that sysfs dev numbers are not unique either -- some
devices with major=1 apper twice in sysfs. To give a random example:

$ cat /sys/block/ram8/dev /sys/class/mem/random/dev
1:8
1:8

And these aren't symlinks.
  Shem
