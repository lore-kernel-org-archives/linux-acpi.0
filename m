From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: 3.14-rc: /proc/acpi/battery gone?
Date: Sat, 15 Mar 2014 11:10:36 -0400
Message-ID: <53246D6C.5060704@intel.com>
References: <20140314211456.GA23213@amd.pavel.ucw.cz> <CAKb7Uvi-GfOu3_3BMU_Cu4qYS8PQRWzxVm1XETY7y_TJjGPs_A@mail.gmail.com> <CAFLxGvz1Egbg1=Kxfc2DGw8OZUEootr5E=Uh7rW6qTSC8N9+Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30653 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbaCOPKq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Mar 2014 11:10:46 -0400
In-Reply-To: <CAFLxGvz1Egbg1=Kxfc2DGw8OZUEootr5E=Uh7rW6qTSC8N9+Wg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Ilia Mirkin <imirkin@alum.mit.edu>, Pavel Machek <pavel@ucw.cz>, rjw@rjwysocki.net, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, rafael.j.wysocki@intel.com, Linus Torvalds <torvalds@linux-foundation.org>

On 03/14/2014 05:45 PM, Richard Weinberger wrote:
> On Fri, Mar 14, 2014 at 10:29 PM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>> On Fri, Mar 14, 2014 at 5:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>> Hi!
>>>
>>> It seems /proc/acpi/battery interface is gone, and I don't see any
>>> option to reintroduce it... what is going on?
>>
>> The interface went away in a semi-recent kernel release (3.13 or
>> 3.12), breaking pretty much every battery app. (Admittedly the
>> interface was marked as deprecated for quite some time, but that
>> didn't stop everyone from using it and not caring about the new
>> thing.) I've yet to find a windowmaker dock app that works with the
>> current sysfs API :(
>>
>
> commit 1e2d9cdfb4494fce682b4ae010d86a2766816d36
> Author: Lan Tianyu <tianyu.lan@intel.com>
> Date:   Fri Oct 11 09:54:08 2013 +0800
>
>      ACPI / Battery: Remove battery's proc directory
>
>      The battery's proc directory isn't useded and remove it.
>
>      Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Looks like this one is the said commit.
> If it breaks userspace we have to revert it IMHO.
>

Yes, we will revert the commit if it really breaks some APPs.
