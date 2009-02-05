From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 1/2] PCI/ACPI: move _OSC code to pci_root.c
Date: Thu, 5 Feb 2009 08:03:06 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858142EB3B4@orsmsx503.amr.corp.intel.com>
References: <498AF51F.7070200@jp.fujitsu.com>
 <498AF557.4040601@jp.fujitsu.com> <20090205154936.GC24033@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090205154936.GC24033@ldl.fc.hp.com>
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Andrew Patterson <andrew.patterson@hp.com>
List-Id: linux-acpi@vger.kernel.org

The acpi_evaluate_object_typed interface automatically handles the two error cases you check for:

1) Checks for the case where no object is returned
2) Checks for the correct return object type (buffer in this case)

Use of this interface would simplify and shrink the code.

Bob


>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Alex Chiang
>Sent: Thursday, February 05, 2009 7:50 AM
>To: Kenji Kaneshige
>Cc: Jesse Barnes; linux-pci@vger.kernel.org; linux acpi; Andrew Patterson
>Subject: Re: [PATCH 1/2] PCI/ACPI: move _OSC code to pci_root.c
>
>Hi Kenji-san,
>
>Sorry, I didn't read your patch in detail last time, and only saw
>the one wording change that Andrew suggested.
>
>Reading through now, I have a few more suggestions.
>
>> +    status = acpi_evaluate_object(handle, "_OSC", &input, &output);
>> +    if (ACPI_FAILURE(status))
>> +            return status;
>> +
>> +    if (!output.length)
>> +            return AE_NULL_OBJECT;
>> +
>> +    out_obj = output.pointer;
>> +    if (out_obj->type != ACPI_TYPE_BUFFER) {
>> +            printk(KERN_DEBUG "Evaluate _OSC returns wrong type\n");
>
>"_OSC evaluation returned wrong type\n"
>
>> +    if (errors) {
>> +            if (errors & OSC_REQUEST_ERROR)
>> +                    printk(KERN_DEBUG "_OSC request fails\n");
>
>"_OSC request failed\n"
>
>> +            if (errors & OSC_INVALID_UUID_ERROR)
>> +                    printk(KERN_DEBUG "_OSC invalid UUID\n");
>> +            if (errors & OSC_INVALID_REVISION_ERROR)
>> +                    printk(KERN_DEBUG "_OSC invalid revision\n");
>> +            if (errors & OSC_CAPABILITIES_MASK_ERROR) {
>> +                    if (capbuf[OSC_QUERY_TYPE] & OSC_QUERY_ENABLE)
>> +                            goto out_success;
>> +                    printk(KERN_DEBUG"Firmware did not grant requested "
>> +                           "_OSC control\n");
>
>I prefer to see this message on one line (and break the 80 column
>rule) to make grepping easier. But this is a judgement call, and
>I'll let you decide.
>
>Thanks.
>
>/ac
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
