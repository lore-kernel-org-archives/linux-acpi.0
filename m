From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] drivers/platform/x86: Add driver for INT0002 ACPI device
Date: Fri, 21 Apr 2017 13:52:24 +0200
Message-ID: <bd024a28-9c48-7a1c-cee9-54ea66870e5d@redhat.com>
References: <20170421074157.19159-1-hdegoede@redhat.com>
 <s5hfuh2mayi.wl-tiwai@suse.de>
 <24d0d0f1-93dc-8413-651d-104703cdb216@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1037114AbdDULw1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Apr 2017 07:52:27 -0400
In-Reply-To: <24d0d0f1-93dc-8413-651d-104703cdb216@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi,

On 21-04-17 12:11, Hans de Goede wrote:
> Hi,
> 
> On 21-04-17 10:17, Takashi Iwai wrote:
>> On Fri, 21 Apr 2017 09:41:57 +0200,
>> Hans de Goede wrote:
>>>
>>> Some peripherals on Baytrail and Cherrytrail platforms signal PME to the
>>> PMC to wakeup the system. When this happens software needs to clear the
>>> PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.
>>>
>>> This is modelled in ACPI through the INT0002 ACPI device.
>>>
>>> This commit adds a driver which will bind to that device, call the
>>> ACPI event handler for the wakeup and clear the interrupt source
>>> avoiding the irq storm.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> This patch requires your previous "always present" patchset, right?
> 
> On boards where the _STA for INT0002 returns 0, that patchset
> is needed for the driver to bind to the device, so yes it has
> a functional requirement on some (most it seems) board, but
> only at run-time, it can be merged independently.
> 
>> Some nitpicking:
>>
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/intel_int0002.c
>> ...
>>> +struct int0002_data {
>>> +    struct spinlock lock;
>>> +    struct device *dev;
>>> +    const struct x86_cpu_id *cpu_id;
>>> +    acpi_handle handle;
>>> +    char ev_name[5];
>>
>> Are 5 bytes enough?  I see the code below:
>>
>>> +        snprintf(data->ev_name, sizeof(data->ev_name), "_%c%02X",
>>> +            res->data.gpio.triggering ? 'E' : 'L',
>>> +            res->data.gpio.pin_table[0]);
>>
>> So it counts 6 including NUL.
> 
> The name is e.g. _E02 or _L02 so 5 bytes including the NUL is enough :)
> 
>>
>>> +static int int0002_probe(struct platform_device *pdev)
>>> +{
>>> +    struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>>> +    struct device *dev = &pdev->dev;
>>> +    struct int0002_data *data;
>>> +    struct acpi_resource *res;
>>> +    acpi_status status;
>>> +    acpi_handle hdl;
>>> +    int irq, ret;
>>> +
>>> +    data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>> +    if (!data) {
>>> +        dev_err(dev, "can't allocate memory for int0002\n");
>>
>> The error message is mostly superfluous.
> 
> Agreed, will fix for v2.
> 
>>> +static int int0002_runtime_suspend(struct device *dev)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +static int int0002_runtime_resume(struct device *dev)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct dev_pm_ops int0002_pm_ops = {
>>> +    .runtime_suspend = int0002_runtime_suspend,
>>> +    .runtime_resume = int0002_runtime_resume,
>>> +};
>>
>> Do we need these runtime PM?  If not, we can remove the header
>> inclusion, too.
> 
> We enable runtime pm for this device, at which point these
> are mandatory.

Correction, I thought the driver was enabling runtime pm but
it does not, so these can simply be removed. Will fix for v2.

Regards,

Hans
