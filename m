From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v6 1/7] scsi: sr: support runtime pm for ODD
Date: Fri, 07 Sep 2012 22:53:02 +0800
Message-ID: <504A0A4E.9040801@intel.com>
References: <Pine.LNX.4.44L0.1209061103530.1363-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:35053 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760649Ab2IGOxG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Sep 2012 10:53:06 -0400
In-Reply-To: <Pine.LNX.4.44L0.1209061103530.1363-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Aaron Lu <aaron.lwe@gmail.com>, Oliver Neukum <oneukum@suse.de>, James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Garzik <jgarzik@pobox.com>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On 09/06/2012 11:06 PM, Alan Stern wrote:
> On Thu, 6 Sep 2012, Aaron Lu wrote:
>
>>> That's why we have an autosuspend delay.  Although for some reason the
>>> SCSI subsystem doesn't use it currently...  We need to add a call to
>>> pm_runtime_use_autosuspend() in scsi_sysfs_add_sdev().  Likewise, the
>>> pm_schedule_suspend() call in scsi_runtime_idle() should be changed to
>>> pm_runtime_autosuspend().  And there should be calls to
>>> pm_runtime_set_autosuspend_delay() in the sd and sr drivers.
>>
>> I tried to use autosuspend when preparing the patch, but the fact that
>> the devices will be polled every 2 seconds make it impossible to enter
>> suspend state if the autosuspend delay is larger than that.
>
> You can always increase the polling interval.
> But in the long run that wouldn't be a good solution.

Agree.

> What I'd really like is a way to do the status polling without having
> it reset the idle timer.

I like this, I'll try to see if this can be done.

If we idle the device immediately, we would suspend/resume the ODD every
2 seconds, which may not be a good idea.

And we can't increate the polling interval that much, like to the level
of minutes, and if we can't put the device into suspend state long
enough, it may not worth the effort.

What do you think?

-Aaron
