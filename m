From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/Power: Check physical device's runtime pm status
 before requesting to resume it
Date: Fri, 18 Oct 2013 21:05:13 +0800
Message-ID: <52613209.3000104@intel.com>
References: <1381479385-1614-1-git-send-email-tianyu.lan@intel.com> <525F372A.5070807@intel.com> <525F4E03.2050606@intel.com> <4249062.PmvqKh0Nrz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5509 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871Ab3JRNFf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Oct 2013 09:05:35 -0400
In-Reply-To: <4249062.PmvqKh0Nrz@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lan Tianyu <lantianyu1986@gmail.com>, Aaron Lu <aaron.lu@intel.com>

On 10/17/2013 07:38 PM, Rafael J. Wysocki wrote:
>>>>>>> Unfortunately, I don't see how we can fix this race in a
>>>>>>> satisfactory way and I'm starting to think that the whole
>>>>>>> resuming of dependent devices may be a bad idea.
>>>>>>>
>>>>>>> IIRC, the original concern was that devices may end up in
>>>>>>> D0-uninitialized if we don't do that, but then whoever
>>>>>>> turned the power resource on will probably turn if off at
>>>>>>> one point anyway, so they will be in that state
>>>>>>> temporarily.  In other words, in addition to the fact
>>>>>>> that this is racy, there even is no reason to do it.
>>>>>>>
>>>>>>> I'll send a patch to rip off that stuff later today.
>>>
>>> Currently, dropping it should be the better choice but I think we
>>> still need to resolve the D0-uninitialized problem, right?
> Why do you think it is a problem in the first place?  Those devices
> will not be accessed while in that state (unless there's a bug
> somewhere).
>

Yes, those devices will not be accessed but they will continue to stay
D0-uninitiallized without any users before next resume and suspend. PM
core and device driver still think they are in the lower power state.

At this point, it seems these devices should be put into lower power
state(E.G D3hot) than D0-uninitiallized.

E.G, two devices share one power resource. After they are suspended and
power resource turns off, one device is resumed and power resource turns
on. The other device will remain D0-uninitallized until there are resume
and suspend for it. It may consume more power than lowest power state it
can reach at that point.

> Thanks!
>
> -- I speak only for myself. Rafael J. Wysocki, Intel Open Source
> Technology Center.

