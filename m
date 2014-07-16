From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [Regression]: Changing brightness does not work with v3.16-rc4
Date: Wed, 16 Jul 2014 08:29:41 +0200
Message-ID: <53C61BD5.8080501@redhat.com>
References: <20140712180636.698e2e4c@saldaea> <53C53543.1050207@redhat.com> <53C53E89.2020505@intel.com> <2231725.PEI454q0UP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12148 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbaGPGet (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2014 02:34:49 -0400
In-Reply-To: <2231725.PEI454q0UP@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>
Cc: Julian Wollrath <jwollrath@web.de>, linux-acpi@vger.kernel.org

Hi,

On 07/16/2014 02:43 AM, Rafael J. Wysocki wrote:
> On Tuesday, July 15, 2014 10:45:29 PM Aaron Lu wrote:
>> On 07/15/2014 10:05 PM, Hans de Goede wrote:
> 
> [cut]
> 
>>> On 07/15/2014 04:00 PM, Aaron Lu wrote:
>>>
>>>  > If we have to consider the following config:
>>>  > 1 ACPI backlight interface works(or can work with some cmdline option);
>>>
>>> And the BIOS advertises native win8 support.
>>
>> Right.
>> So this condition should be:
>> 1 ACPI backlight interface works in Win8 mode;
>>
>> This means, for Julian's system, the commit 751109aad583 doesn't need to
>> be reverted as the ACPI backlight interface on his system only works
>> when the acpi_osi="!Windows 2012" is added. In that case, the
>> video.use_native_backlight=X doesn't make any difference anymore.
> 
> But Julian reports that he needs to revert that commit to make things work
> as before for him.  What gives?

Likely what is happening is that this commit is still affecting Julian because
we check if the bios is advertising win8 support, not if we are advertising win8
support ourselves.

Julian, I've jumped into this thread halfway, so I'm not 100% clear on your
original problem. From what I've read sofar you need acpi_osi="!Windows 2012"
for backlight control to work. That in itself is a sign that things are not
as they should be, and this is actually what the new default of
video.use_native_backlight=1 is trying to fix.

If you boot the new kernel without acpi_osi="!Windows 2012" and without
video.use_native_backlight=X (so using the new default of
video.use_native_backlight=1), what does ls /sys/class/backlight say then ?

If there is a directory in there can you then cd in to that directory,
and do: "cat max_brightness" and then "echo value > brightness" (the latter
as root) with value being a number, once half of max_brightness, once
full brightness and see if this controls your backlight brightness.

Assuming this test succeeds, is your problem resolved then? And if not
what is the problem?

Regards,

Hans
