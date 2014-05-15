From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC][PATCH 2/3] PM / sleep: Mechanism to avoid resuming
 runtime-suspended devices unnecessarily
Date: Thu, 15 May 2014 14:06:59 +0200
Message-ID: <CAPDyKFry+O=HvtFtvZh=sYqq9aaFJ78C=8x2euh6MbGExLyuWw@mail.gmail.com>
References: <16671603.abrivY8Odm@vostro.rjw.lan>
	<Pine.LNX.4.44L0.1405141041360.1432-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1405141041360.1432-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-acpi@vger.kernel.org

> Do we want to allow ->prepare() to return > 0 if the device isn't
> runtime suspended?  If we do then non-suspended devices may be a common
> case.  We should then avoid the extra overhead of disable + enable.
> So I would write:
>
>         if (dev->power.direct_complete) {
>                 if (pm_runtime_status_suspended(dev)) {
>                         pm_runtime_disable(dev);
>                         if (dev->power.disable_depth == 1
>                             && pm_runtime_status_suspended(dev))
>                                 goto Complete;
>                         pm_runtime_enable(dev);
>                 }
>                 dev->power.direct_complete = false;
>         }
>

I am wondering whether the above pm_runtime_disable|enable actually
belongs better in driver/subsystem in favour of the PM core?

Doesn't the driver/subsystem anyway needs to be on top of what goes
on? Typically, while runtime PM has been disabled, that might affect
it's wakeup handling? Or this case are already handled due to other
circumstances?

Kind regards
Ulf Hansson
