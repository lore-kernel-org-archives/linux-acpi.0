From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi-video: Add use native backlight quirk for the ThinkPad
 W530
Date: Thu, 15 May 2014 10:56:40 +0200
Message-ID: <53748148.2020402@redhat.com>
References: <1399881432-26124-1-git-send-email-hdegoede@redhat.com> <5370837A.5070708@intel.com> <5370AA2C.1080506@redhat.com> <53734EED.5070807@redhat.com> <53741C4A.3090502@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34621 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbaEOI4t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 May 2014 04:56:49 -0400
In-Reply-To: <53741C4A.3090502@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc: linux-acpi@vger.kernel.org, stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>

Hi,

On 05/15/2014 03:45 AM, Aaron Lu wrote:
> On 05/14/2014 07:09 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 05/12/2014 01:02 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 05/12/2014 10:16 AM, Aaron Lu wrote:
>>>> On 05/12/2014 03:57 PM, Hans de Goede wrote:
>>>>> Like all of the other *30 ThinkPad models, the W530 has a broken acpi-video
>>>>> backlight control. Note in order for this to actually fix things on the
>>>>> ThinkPad W530 the commit titled:
>>>>> "nouveau: Don't check acpi_video_backlight_support() before registering backlight"
>>>>> is also needed.
>>>>
>>>> Note that the backlight_device_registered(raw) may return false as when
>>>> acpi_video_verify_backlight_support is called, the nouveau driver may
>>>> not run yet.
>>>>
>>>> Previously, we don't know anything about how laptops with nvidia graphics
>>>> card alone control backlight in Win8, so the existing solution doesn't
>>>> consider this case. If nvidia graphics system also should favour native
>>>> backlight control interface in Win8, the current solution needs
>>>> modifications.
>>>
>>> Hmm, how is this dealt with in the case of the intel gfx driver ?
>>
>> Ok, I've figured out now how this is dealt with in the case of the intel gfx
> 
> Reading your other reply, I thought you already figured this out so I
> didn't explain, sorry for that.
> 
>> drivers. That looks like something which will likely be hard to do for
>> nouveau, since it relies on some intel gfx specific ACPI calls being there,
>> which nouveau does not have. So this would require doing something like
>> duplicating the nouveau pci-ids or some such, which would be far from ideal.
>>
>> Still this bug: https://bugzilla.redhat.com/show_bug.cgi?id=1093171
>>
>> Shows that we need *working* video.use_native_brightness=1 support for
>> non intel too. Which the current loading order issues caused by the
>> backlight_device_registered(raw) breaks.
>>
>> So maybe we should simply drop the backlight_device_registered(raw) check?
> 
> Unfortunately, there are indeed systems that with Intel GFX do not have
> a GPU backlight control interface:
> 
> commit c675949ec58ca50d5a3ae3c757892f1560f6e896
> Author: Jani Nikula <jani.nikula@intel.com>
> Date:   Wed Apr 9 11:31:37 2014 +0300
> 
>     drm/i915: do not setup backlight if not available according to VBT
> 
> And I remembered last time when we push the use_native default to 1
> without checking if a raw interface is available, there are people
> complaining about no backlight interface is created on his system(and
> the only working interface is acpi_video on his Win8 system). So simply
> dropping this check doesn't seem like a good idea.

Hmm, ok. So any smart ideas how to deal with the ordering problem we've
here ?

Note this also plays into the proposal I'm about to send to unify and
simplify backlight control selection. Which besides just trying to
clean things up also tries to get rid of various module load ordering
issues.

... <this represent me thinking for half an hour trying to come up with a clever solution>

So I think we really need some clean and generic way to deal with this,
which is not prone to module loading ordering issues, any suggestions?

Regards,

Hans
