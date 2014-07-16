From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [Regression]: Changing brightness does not work with v3.16-rc4
Date: Wed, 16 Jul 2014 13:52:47 +0200
Message-ID: <53C6678F.90905@redhat.com>
References: <20140712180636.698e2e4c@saldaea>	<53C53543.1050207@redhat.com>	<53C53E89.2020505@intel.com>	<2231725.PEI454q0UP@vostro.rjw.lan>	<53C61BD5.8080501@redhat.com>	<53C6276A.6020206@intel.com>	<53C63431.7020205@redhat.com>	<53C63955.2090905@redhat.com> <20140716135035.21106dfe@saldaea>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63521 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932684AbaGPLwy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2014 07:52:54 -0400
In-Reply-To: <20140716135035.21106dfe@saldaea>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julian Wollrath <jwollrath@web.de>
Cc: Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

Hi,

On 07/16/2014 01:50 PM, Julian Wollrath wrote:
> Am Wed, 16 Jul 2014 10:35:33 +0200
> schrieb Hans de Goede <hdegoede@redhat.com>:
> 
>> Hi,
>>
>> On 07/16/2014 10:13 AM, Hans de Goede wrote:
>>
>> <snip>
>>
>>> I realize that this does not fix Julian's problem. As I see it
>>> there are 2 separate problems here:
>>>
>>> 1) backlight control issues on Windows 8 laptops, this is what we
>>> are trying to solve with video.use_native_backlight=1 (and without
>>> using any acpi_osi override)
>>>
>>> 2) Some component in the stack needs to responds to backlight
>>> key-presses and actually use the backlight control to change the
>>> backlight setting, normally this is done by gnome / kde / unity /
>>> xfce, but what about users not running those? For some of those
>>> users brightness_switch_enabled=1 has been making things work for
>>> them, but that only works if acpi-video controls the backlight,
>>> which it does not do everywhere, and which we want to get away from
>>> for Windows 8 laptops since it is just too broken there.
>>>
>>> Note that 2. is not limited to Windows 8 laptops / acpi-video in any
>>> way, we've 23 non acpi-video backlight drivers under
>>> drivers/platform/x86/ alone + the native gpu backlight drivers. So
>>> what we really need is a solution for any laptop not using
>>> acpi-video for backlight control and not running one of the big 4
>>> desktop environments.
>>>
>>> Note that we pretty much have the same problem for any acpi event,
>>> power button pressed, lid closed, etc. are all "key press" type
>>> events typically handles by the desktop enviroment (e.g. we don't
>>> automatically suspend on lid-close, we just tell userspace). And we
>>> already have a solution for these type of events when running a
>>> desktop environment which handles them, these get handled by acpid.
>>> So to me it seems that
>>
>> s/handles/does not handle/  small but important typo.
>>
>>> the obvious (and one and only right) way to fix this is to teach
>>> acpid to deal with brightness key-presses.
>>>
>>> I'm willing to write a patch for acpid to implement this, and then
>>> Julian's setup should just work without needing any special kernel
>>> commandline options.
>>>
>>> Julian would that be an acceptable solution for you, and would you
>>> be willing to test such a patch ?
> Yes, of course that would be an acceptable solution for me and yes, I
> would be willing to test such a patch.

Ok, great. I've putten this (pretty high) on my todo list, I'll let you
know when I've something ready to test.

Regards,

Hans
