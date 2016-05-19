From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH 1/2] ACPI / button: Send "open" state after boot/resume
Date: Thu, 19 May 2016 15:21:33 +0200
Message-ID: <CAJZ5v0g2g9nDm+xOYpHQ6=NX40bem5atoSYhM46hjf+X_p+Ouw@mail.gmail.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
	<CAJZ5v0g6RM53oTWRGF-7k2=dDktawmOZbJY56xDXRbQcKoWpmg@mail.gmail.com>
	<1AE640813FDE7649BE1B193DEA596E883BBA2DED@SHSMSX101.ccr.corp.intel.com>
	<CAJZ5v0jZTtim8AeBokzz3uT-6rmNGAz3VMPAn-a4M3zaBm1dtA@mail.gmail.com>
	<1AE640813FDE7649BE1B193DEA596E883BBA3088@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34496 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbcESNVf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2016 09:21:35 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBA3088@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Bastien Nocera:" <hadess@hadess.net>

On Thu, May 19, 2016 at 3:50 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi,
>
>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of
>> Rafael J. Wysocki
>> Subject: Re: [RFC PATCH 1/2] ACPI / button: Send "open" state after
>> boot/resume

[cut]

>> > That's because of systemd implementation.
>> > It contains code logic that:
>> > When the lid state is closed, a re-checking mechanism is installed.
>> > So if we do not send any notification after boot/resume and the old lid state
>> is "closed".
>> > systemd determines to suspend in the re-checking mechanism.
>>
>> If that really is the case, it is plain silly and I don't think we can
>> do anything in the kernel to help here.
>
> [Lv Zheng]
> The problem is:
> If we just removed the 2 lines sending wrong lid state after boot/resume.
> Problem couldn't be solved.
> It could only be solved by changing both the systemd and the kernel (deleting the 2 lines).

There are two things here, there's a kernel issue (sending the fake
input events) and there's a user-visible problem.  Yes, it may not be
possible to fix the user-visible problem by fixing the kernel issue
alone, but pretty much by definition we can only fix the kernel issue
in the kernel.

However, it looks like it may not be possible to fix the user-visible
problem without fixing the kernel issue in the first place, so maybe
we should do that and attach the additional user space patch to the
bug entries in question?

[cut]

>> > I intentionally kept the _LID evaluation right after boot/resume.
>> > Because I validated Windows behavior.
>> > It seems Windows evaluates _LID right after boot.
>> > So I kept _LID evaluated right after boot to prevent compliance issues.
>>
>> I don't quite see what compliance issues could result from skipping
>> the _LID evaluation after boot.
>
> [Lv Zheng]
> I'm not sure if there is a platform putting named object initialization code in _LID.
> If you don't like it, we can stop evaluating _LID in the next version.

Well, unless there is a well-documented reason for doing this, I'd at
least try to see what happens if we don't.

Doing things for unspecified reasons is not a very good idea overall IMO.

[cut]

>> > [Lv Zheng]
>> > If we did this right now, many other userspace could be broken.
>> > So we prepared the options to allow users to choose.
>>
>> Do we have any evidence that any other user space stacks are affected?
>
> [Lv Zheng]
> I didn't know any of such affections except the systemd.

So let's focus on this one until we actually find another example.
