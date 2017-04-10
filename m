From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [Intel-gfx] [PATCH] ACPI / bus: Introduce a list of ids for
 "always present" devices
Date: Mon, 10 Apr 2017 17:44:07 +0200
Message-ID: <7df348bc-5f8c-94e0-e3cf-dfe7024d8804@redhat.com>
References: <20170225182328.26644-1-hdegoede@redhat.com>
 <3161510.WQnmWnCBb0@aspire.rjw.lan>
 <ccbbaa31-9140-f976-bdcd-7e5ad23a47c8@redhat.com>
 <s5hwpcb3dfc.wl-tiwai@suse.de>
 <CAJZ5v0hcc6FmEk+k_VX=nPUe4EGM5Fe2WNTrb3mjvJETBcf1ug@mail.gmail.com>
 <s5h7f4bnt2z.wl-tiwai@suse.de>
 <591c099a-4b2b-0b69-575a-cd4c95c02682@redhat.com>
 <s5hinmcwemi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754406AbdDJPoK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Apr 2017 11:44:10 -0400
In-Reply-To: <s5hinmcwemi.wl-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, intel-gfx <intel-gfx@lists.freedesktop.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>

Hi,

On 10-04-17 15:56, Takashi Iwai wrote:
> On Sun, 09 Apr 2017 22:32:46 +0200,
> Hans de Goede wrote:
>>
>> Hi,
>>
>> On 27-02-17 23:53, Takashi Iwai wrote:
>>> On Mon, 27 Feb 2017 22:27:58 +0100,
>>> Rafael J. Wysocki wrote:
>>>>
>>>> On Mon, Feb 27, 2017 at 3:40 PM, Takashi Iwai <tiwai@suse.de> wrote:
>>
>> <snip>
>>
>>>>> Oh, this is interesting, please let me join to the party.
>>>>>
>>>>> We've hit a similar problem, but for other one: namely, it's INT0002
>>>>> that is found on a few CHT devices.  It's never bound properly by a
>>>>> similar reason, where _STA is always zero on Linux:
>>>>>
>>>>>             Method (_STA, 0, NotSerialized)  // _STA: Status
>>>>>             {
>>>>>                 If (SOCS <= 0x04)
>>>>>                 {
>>>>>                     Return (0x0F)
>>>>>                 }
>>>>>                 Else
>>>>>                 {
>>>>>                     Return (Zero)
>>>>>                 }
>>>>>             }
>>>>>
>>>>> The device is supposed to be a "virtual GPIO" stuff, and the driver
>>>>> hasn't been upstreamed from Intel.  Due to the lack of this driver
>>>>> (and it's binding), the machine gets spurious IRQ#9 after the PM
>>>>> resume, and it locks up at the second time of PM.
>>>>
>>>> Well, the solution here seems to be to acquire the missing driver
>>>> instead of adding quirks to the ACPI core.
>>>
>>> The driver is available (not upstreamed, though), but it's not bound
>>> due to _STA above.  That's why I'm interested in this thread.
>>
>> Takashi thanks for pointing me to the INT0002 device / driver to
>> fix the spurious IRQ#9 after the PM resume issue. I was seeing this
>> on the GPD-win too (when suspending with power-button + wakeup with
>> spacebar). I've added a patch to add the INT0002 device to the
>> always present device list + cleaned up the INT0002 driver. I plan
>> to submit this upstream soon.
>>
>> If you want to test this on your device you need these patches:
>>
>> https://github.com/jwrdegoede/linux-sunxi/commit/a1a6e92f2665376ed72f575553238a93e88bb037
>> https://github.com/jwrdegoede/linux-sunxi/commit/4946f68f8eaa300f42289bf767722d78cf7fa9e2
>> https://github.com/jwrdegoede/linux-sunxi/commit/32640c816dd60d17f003ae8306863da01c215afb
>> https://github.com/jwrdegoede/linux-sunxi/commit/abb6a9d69690bb2a1a00b184b06cdae43d6ad001
>
> Thanks Hans, these look promising!
>
> One remaining concern is that INT0002 seems serving for other purpose,
> too, in drivers/platform/x86/intel_menlow.c for the thermal
> management.  I wonder whether we can enable INT0002 unconditionally.

Oh, good point I already had the following in the driver to deal with this:

static const struct x86_cpu_id int0002_cpu_ids[] = {
/*
  * Limit ourselves to Cherry Trail for now, until testing shows we
  * need to handle the INT0002 device on Baytrail too.
  *      ICPU(INTEL_FAM6_ATOM_SILVERMONT1),       * Valleyview, Bay Trail *
  */
         ICPU(INTEL_FAM6_ATOM_AIRMONT),          /* Braswell, Cherry Trail */
         {}
};


probe()
{
         /* Menlow has a different INT0002 device? <sigh> */
         data->cpu_id = x86_match_cpu(int0002_cpu_ids);
         if (!data->cpu_id)
                 return -ENODEV;
}

But I guess we need to do the same for the always present stuff to force the
status to present, so now I've :

#ifdef CONFIG_X86
/*
  * Some ACPI devices are hidden (status == 0x0) in recent BIOS-es because
  * some recent windows drivers bind to one device but poke at multiple
  * devices at the same time, so the others get hidden.
  * We work around this by always reporting ACPI_STA_DEFAULT for these
  * devices. Note this MUST only be done for devices where this is safe.
  *
  * This forcing of devices to be present is limited to specific CPU (SoC)
  * models both to avoid potentially causing trouble on other models and
  * because some HIDs are re-used on different SoCs for completely
  * different devices.
  */
struct always_present_device_id {
         struct acpi_device_id hid[2];
         struct x86_cpu_id cpu_id[2];
};

#define ENTRY(hid, cpu_model) {                                         \
         { { hid, }, {} },                                               \
         { { X86_VENDOR_INTEL, 6, cpu_model, X86_FEATURE_ANY, }, {} }    \
}

static const struct always_present_device_id always_present_device_ids[] = {
         /*
          * Cherrytrail pwm directly poked by GPU driver in win10,
          * but Linux uses a separate pwm driver, harmless if not used.
          */
         ENTRY("80862288", INTEL_FAM6_ATOM_AIRMONT),
         /*
          * The INT0002 device is necessary to clear wakeup interrupt sources
          * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
          */
         ENTRY("INT0002", INTEL_FAM6_ATOM_AIRMONT),
};
#endif

void acpi_set_device_status(struct acpi_device *adev, u32 sta)
{
         u32 *status = (u32 *)&adev->status;
#ifdef CONFIG_X86
         int i;

         /* acpi_match_device_ids checks status, so start with default */
         *status = ACPI_STA_DEFAULT;
         for (i = 0; i < ARRAY_SIZE(always_present_device_ids); i++) {
                 if (acpi_match_device_ids(adev,
                         always_present_device_ids[i].hid) == 0 &&
                     x86_match_cpu(always_present_device_ids[i].cpu_id)) {
                         dev_info(&adev->dev, "Device [%s] is in always present l
                                  adev->pnp.bus_id, ACPI_STA_DEFAULT);
                         return;
                 }
         }
#endif
         *status = sta;
}



Which limits the forcing of status to present for INT0002 to cherrytrail
systems (and this probably is a good idea for the "80862288" pwm device too,
so it is done there too).

You can find the latest version of my patches, with these changes here:

https://github.com/jwrdegoede/linux-sunxi/commits/master

Regards,

Hans
