From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 1/3] backlight: Allow drivers to update the core, and
	generate events on changes
Date: Tue, 14 Jul 2009 13:29:33 +0100
Message-ID: <1247574573.23871.8.camel@dax.rpnet.com>
References: <1247517685-7719-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752627AbZGNMdD@vger.kernel.org>
In-Reply-To: <1247517685-7719-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, corentincj@iksaif.net
List-Id: linux-acpi@vger.kernel.org

On Mon, 2009-07-13 at 21:41 +0100, Matthew Garrett wrote:
> Certain hardware will send us events when the backlight brightness
> changes. Add a function to update the value in the core, and
> additionally send a uevent so that userspace can pop up appropriate
> UI. The uevents are flagged depending on whether the update originated
> in the kernel or from userspace, making it easier to only display UI
> at the appropriate time.

This looks good and I like the idea. 

My main concern is that we don't start getting bug reports of 'missing'
events and have clearly defined expectations of when we see what kind of
events. For example, should an event be emitted when low battery causes
the backlight to be limited? How about console blanking events turning
off the backlight? Are there any other occasions we should be emitting
change events and do we need to audit other drivers?

I did look to see if we could integrate this more into the backlight
core but that doesn't look to be possible unfortunately, at least not
without changing the drivers which these patches start.

Also, are "userspace" and "kernel" as meaningful as they could be? Would
"sysfs" and "hwkeys" make more sense and allow for other future hardware
differences? Perhaps someone will tie the backlight to an ambient light
sensor for example...

Cheers,

Richard

-- 
Richard Purdie
Intel Open Source Technology Centre
