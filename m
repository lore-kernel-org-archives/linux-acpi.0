From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [linux-pm] [RFC PATCH] thermal: Add support to report cooling
 statistics achieved by cooling devices
Date: Mon, 6 Feb 2012 15:16:17 -0800
Message-ID: <CAK44p22FWxiXyBA1zbiuO0cbDScTSMRSV9pFDDMxXsc43ebGpw@mail.gmail.com>
References: <1326878467-17766-1-git-send-email-amit.kachhap@linaro.org>
	<20120206165658.GA28687@atrey.karlin.mff.cuni.cz>
	<20120206170348.GA19749@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44004 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753158Ab2BFXQT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2012 18:16:19 -0500
In-Reply-To: <20120206170348.GA19749@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rob.lee@linaro.org

On 6 February 2012 09:03, Greg KH <greg@kroah.com> wrote:
> On Mon, Feb 06, 2012 at 05:56:58PM +0100, Pavel Machek wrote:
>> Hi!
>>
>> > Add a sysfs node code to report effective cooling of all cooling devices
>> > attached to each trip points of a thermal zone. The cooling data reported
>> > will be absolute if the higher temperature trip points are arranged first
>> > otherwise the cooling stats is the cumulative effect of the earlier
>> > invoked cooling handlers.
>> >
>> > The basic assumption is that cooling devices will bring down the temperature
>> > in a symmetric manner and those statistics can be stored back and used for
>> > further tuning of the system.
>>
>> /sys fs should be one-value-per-file, talk to gregkh.
>
> That's correct.
>
> Why not use debugfs for this instead?
>
> thanks,
>
> greg k-h

Thanks Greg/Pavel for looking into the patch.
Basically I checked the places where single sysfs entry is showing
more then 1 output. And
1) /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state
2) /sys/devices/system/cpu/cpu0/cpufreq/stats/trans_table
are the places where the output is more than 1 value.

Anyway I can enclose this sysfs inside CONFIG_THERMAL_COOLING_STATS macro.

Thanks,
Amit Daniel
