From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5 1/3] mfd: Add support for Cherry Trail Dollar Cove TI
 PMIC
Date: Tue, 5 Sep 2017 10:00:23 +0200
Message-ID: <93a46383-1e32-679e-c36f-35156e666382@redhat.com>
References: <20170904144340.27693-1-tiwai@suse.de>
 <20170904144340.27693-2-tiwai@suse.de> <20170905072451.ephscqjqgwpnl6da@dell>
 <s5hmv69twov.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <s5hmv69twov.wl-tiwai@suse.de>
Content-Language: en-US
Sender: platform-driver-x86-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Lee Jones <lee.jones@linaro.org>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 05-09-17 09:46, Takashi Iwai wrote:
> On Tue, 05 Sep 2017 09:24:51 +0200,
> Lee Jones wrote:
>>
>> On Mon, 04 Sep 2017, Takashi Iwai wrote:
>>
>>> This patch adds the MFD driver for Dollar Cove (TI version) PMIC with
>>> ACPI INT33F5 that is found on some Intel Cherry Trail devices.
>>> The driver is based on the original work by Intel, found at:
>>>    https://github.com/01org/ProductionKernelQuilts
>>>
>>> This is a minimal version for adding the basic resources.  Currently,
>>> only ACPI PMIC opregion and the external power-button are used.
>>>
>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>> ---
>>> v4->v5:
>>> * Minor coding-style fixes suggested by Lee
>>> * Put GPL text
>>> v3->v4:
>>> * no change for this patch
>>> v2->v3:
>>> * Rename dc_ti with chtdc_ti in all places
>>> * Driver/kconfig renames accordingly
>>> * Added acks by Andy and Mika
>>> v1->v2:
>>> * Minor cleanups as suggested by Andy
>>>
>>>   drivers/mfd/Kconfig                   |  13 +++
>>>   drivers/mfd/Makefile                  |   1 +
>>>   drivers/mfd/intel_soc_pmic_chtdc_ti.c | 184 ++++++++++++++++++++++++++++++++++
>>>   3 files changed, 198 insertions(+)
>>>   create mode 100644 drivers/mfd/intel_soc_pmic_chtdc_ti.c
>>
>> For my own reference:
>>    Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Thanks!
> 
> Now the question is how to deal with these.  It's no critical things,
> so I'm OK to postpone for 4.15.  OTOH, it's really a new
> device-specific stuff, thus it can't break anything else, and it'd be
> fairly safe to add it for 4.14 although it's at a bit late stage.
> 
> IMO, it'd be great if you can carry all stuff through MFD tree; or
> create an immutable branch (again).  But how to handle it, when to do
> it, It's all up to you guys.

Since the mfd driver only instantiates platform devices there
is only a runtime dependency between the drivers AFAICT so each
driver can be merged through it own subsystem without problem /
without the need for an immutable branch, or am I missing something ?

Regards,

Hans
