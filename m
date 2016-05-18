From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH 1/2] ACPI / button: Send "open" state after boot/resume
Date: Wed, 18 May 2016 23:41:09 +0200
Message-ID: <CAJZ5v0hcYKSnnrFxZJQBjfdV4jWr_OAdKUCySKWi5voO0O1EGg@mail.gmail.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
	<1463576234.3440.25.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34101 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbcERVlL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2016 17:41:11 -0400
In-Reply-To: <1463576234.3440.25.camel@hadess.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, May 18, 2016 at 2:57 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Tue, 2016-05-17 at 16:27 +0800, Lv Zheng wrote:
>> (This patch hasn't been tested, it's sent for comments)
>>

[cut]

>
> As mentioned previously, I'd be much happier if either:
> - a new system was put in place that matched the ACPI specs and the way
> they are used by Windows
> - an additional tag/property was added to show that the API offered by
> the LID switch is different from the one that existing since ACPI
> support was added to Linux.

I'm sorry, but I'm not following either of the above.

> And I'd really appreciate it if you stopped saying that it's systemd's
> fault.
>
> The kernel has offered an API to user-space that included the state of
> the LID switch.

To be precise, this is not what the kernel has been providing.

It really is the state of the lid switch as reported by the platform
firmware.  The "as reported by the platform firmware" part appears to
be missing from your argumentation and it is quite relevant, because
the firmware, being what it is, messes up things at least
occasionally, so by using that interface you may end up having to deal
with a value that has been messed up by the firmware.

Now, the kernel is not entirely innocent here, because it sometimes
reports input events that it has not received to user space.  That
happens during system initialization and during resume from system
suspend and is generally problematic, so I'd prefer to get rid of that
behavior.  That, however, has nothing to do with the spec compliance
and/or the Windows' behavior.

> And the state of the LID switch has been correct for
> the majority of systems and devices for the past decade or so. The fact
> that this device means that the LID state isn't reliable anymore means
> that the kernel needs to communicate that to user-space.

The problem, though, is that the kernel has no idea about the value
being incorrect.  It just passes the value over to user space and has
no way to validate it.

> I'm volunteering to modify systemd and UPower to respect the fact that
> the LID switch state isn't available on those devices. If you want to
> find something to blame, blame the kernel for implementing an API that
> doesn't reflect what the hardware makes available.

The API works as I described: it passes the value reported by the
firmware to user space.  I has always worked this way.  Whether or not
that is a useful API is a good question.

I guess, however, that the fake input events reported by the kernel
are really problematic here, because had they not been reported, you
wouldn't have seen an incorrect lid switch state, most likely.
