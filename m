From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Fri, 28 Jul 2006 18:38:13 +0300
Message-ID: <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz>
	 <20060728134307.GD29217@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:65065 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752017AbWG1PiR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Jul 2006 11:38:17 -0400
Received: by ug-out-1314.google.com with SMTP id m3so820969ugc
        for <linux-acpi@vger.kernel.org>; Fri, 28 Jul 2006 08:38:14 -0700 (PDT)
In-Reply-To: <20060728134307.GD29217@suse.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > I do not understand this. Any polling (in kernel or in userspace) will
> > wake the CPU, wasting power.
>
> The kernel, however, has all the gory details at hand, and can decide
> much better about the polling frequency, than the (hopefully) hardware
> agnostic userspace.
>
> Imagine your Zaurus: You don't need to poll very often when you are on
> the flat part of the LiIon discharge curve, you probably want more
> detailed info near the end.

Another example: on my ThinkPad, the readouts provided by the EC
change only every 2 seconds, regardless of how much you poll it.

Hence my proposal for a polling-based interface with kernel-side
caching. This way, the hardware query rate is the minimum of two
rates: what the application can use and what the kernel thinks is the
hardware's change rate.

This doesn't solve the timer interrupt (tickless kernel) issue. Sane
apps would never ask for battery updates at more than a few Hz, are we
likely to see tickless machines where this makes a difference
beyondnormal load?

  Shem
