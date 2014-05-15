From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi-video: Add use native backlight quirk for the ThinkPad
 W530
Date: Thu, 15 May 2014 11:34:39 +0200
Message-ID: <53748A2F.5020608@redhat.com>
References: <1399881432-26124-1-git-send-email-hdegoede@redhat.com> <5370837A.5070708@intel.com> <5370AA2C.1080506@redhat.com> <53734EED.5070807@redhat.com> <53741C4A.3090502@intel.com> <53748148.2020402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48975 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbaEOJet (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 May 2014 05:34:49 -0400
In-Reply-To: <53748148.2020402@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc: linux-acpi@vger.kernel.org, stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>

Hi,

On 05/15/2014 10:56 AM, Hans de Goede wrote:

<snip>

>>> So maybe we should simply drop the backlight_device_registered(raw) check?
>>
>> Unfortunately, there are indeed systems that with Intel GFX do not have
>> a GPU backlight control interface:
>>
>> commit c675949ec58ca50d5a3ae3c757892f1560f6e896
>> Author: Jani Nikula <jani.nikula@intel.com>
>> Date:   Wed Apr 9 11:31:37 2014 +0300
>>
>>     drm/i915: do not setup backlight if not available according to VBT
>>
>> And I remembered last time when we push the use_native default to 1
>> without checking if a raw interface is available, there are people
>> complaining about no backlight interface is created on his system(and
>> the only working interface is acpi_video on his Win8 system). So simply
>> dropping this check doesn't seem like a good idea.
> 
> Hmm, ok. So any smart ideas how to deal with the ordering problem we've
> here ?
> 
> Note this also plays into the proposal I'm about to send to unify and
> simplify backlight control selection. Which besides just trying to
> clean things up also tries to get rid of various module load ordering
> issues.
> 
> ... <this represent me thinking for half an hour trying to come up with a clever solution>
> 
> So I think we really need some clean and generic way to deal with this,
> which is not prone to module loading ordering issues, any suggestions?

Ok, after yet more thinking about this I think I've what is likely going
to be the best solution for this:

1) Add a callback to the backlight core which allows interested parties
to get notified if a backlight device gets registered / unregistered

2) make acpi/video.c listen to these events and on these events re-check
acpi_video_verify_backlight_support, and if it returns something
different then the current situation (un)register the acpi_video#
backlight devices

This means that we will have ping-ponging of backlight interfaces which
I really wanted to avoid, but given all the interdepencies that
seems unavoidable. This will also simplify my cleanup proposal since
if we accept the ping-ponging all the quirks can stay in the vendor
specific firmware backlight control drivers.

So, good or bad idea ?

Regards,

Hans
