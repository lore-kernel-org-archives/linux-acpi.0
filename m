From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH resend 2/4] backlight: Add backlight device (un)registration
 notification
Date: Mon, 26 May 2014 13:21:07 +0200
Message-ID: <538323A3.1050209@redhat.com>
References: <1400679596-19663-1-git-send-email-hdegoede@redhat.com> <20140522090215.GO6679@lee--X1> <000301cf788f$1a59e870$4f0db950$%han@samsung.com> <2139692.XxRO5tdkik@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24924 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbaEZLV2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 May 2014 07:21:28 -0400
In-Reply-To: <2139692.XxRO5tdkik@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jingoo Han <jg1.han@samsung.com>
Cc: 'Lee Jones' <lee.jones@linaro.org>, 'Aaron Lu' <aaron.lu@intel.com>, 'Bryan Wu' <cooloney@gmail.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Ben Skeggs' <bskeggs@redhat.com>, 'David Airlie' <airlied@linux.ie>, 'Zhang Rui' <rui.zhang@intel.com>, 'Len Brown' <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi,

On 05/26/2014 01:03 PM, Rafael J. Wysocki wrote:
> On Monday, May 26, 2014 12:03:43 PM Jingoo Han wrote:
>> On Thursday, May 22, 2014 6:02 PM, Lee Jones wrote:
>>> On Thursday, May 22, 2014 5:45 PM, Hans de Goede wrote:
>>>> On Thursday, May 22, 2014 8:31 AM, Rafael J. Wysocki wrote:
>>>>> On Wednesday, May 21, 2014 10:40 PM, Hans de Goede wrote:
>>>>>> Some firmware drivers, ie acpi-video want to get themselves out of the
>>>>>> way (in some cases) when their also is a raw backlight device available.
>>>>>>
>>>>>> Due to module loading ordering being unknown, acpi-video cannot be certain
>>>>>> that the backlight_device_registered(BACKLIGHT_RAW) it does for this is
>>>>>> the final verdict wrt there being a BACKLIGHT_RAW device.
>>>>>>
>>>>>> By adding notification acpi-video can listen for backlight devices showing
>>>>>> up after it has loaded, and unregister its backlight device if desired.
>>>>>>
>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>
>>>>> Backlight maintainer's ACK is requisite here.
>>>>
>>>> Agreed, which is why I send this set to all 3 the backlight maintainers
>>>> directly on both postings.
>>>>
>>>> What may be helpful for them is to hear from you if you're ok with the
>>>> acpi-video bits which are actually going to use this, since those will
>>>> be the only user of the new backlight api (for now).
>>>
>>> I'm happy to apply any Backlight patches which have either Bryan or
>>> Jingoo's Ack, as they are the reviewers for the BL subsystem.
>>
>> Acked-by: Jingoo Han <jg1.han@samsung.com>
>>
>> Lee Jones,
>> Would you merge this patch into your backlight git tree?
> 
> Hans, does this series depend on things that I've applied already?  If so,
> I'd very much prefer to take this series too as a whole.

The 3th patch in this series:
" acpi-video: Unregister the backlight device if a raw one shows up later"
depends on my "acpi-video: Add an acpi_video_unregister_backlight function"
patch, which you've applied to your linux-next branch already.

As well as on the 2nd patch in this series:
"backlight: Add backlight device (un)registration notification"

So I agree that it is a good idea to take the whole series through your tree.

Thanks & Regards,

Hans
