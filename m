From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 1/2] PCI/ACPI: move _OSC code to pci_root.c
Date: Fri, 6 Feb 2009 08:14:02 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858142EBF63@orsmsx503.amr.corp.intel.com>
References: <498AF51F.7070200@jp.fujitsu.com>
 <498AF557.4040601@jp.fujitsu.com> <20090205154936.GC24033@ldl.fc.hp.com>
 <4911F71203A09E4D9981D27F9D830858142EB3B4@orsmsx503.amr.corp.intel.com>
 <498BCDEA.6030307@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <498BCDEA.6030307@jp.fujitsu.com>
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Alex Chiang <achiang@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Andrew Patterson <andrew.patterson@hp.com>
List-Id: linux-acpi@vger.kernel.org

I guess this means that Linux does not currently use this interface.

I think I remember that Linux implements a utility module with an interface something like "acpi_evaluate_integer", and a couple more. Perhaps acpi_evaluate_buffer already exists, you could use that.


>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Kenji Kaneshige
>Sent: Thursday, February 05, 2009 9:43 PM
>To: Moore, Robert
>Cc: Alex Chiang; Jesse Barnes; linux-pci@vger.kernel.org; linux acpi;
>Andrew Patterson
>Subject: Re: [PATCH 1/2] PCI/ACPI: move _OSC code to pci_root.c
>
>Moore, Robert wrote:
>> The acpi_evaluate_object_typed interface automatically handles the two
>error cases you check for:
>>
>> 1) Checks for the case where no object is returned
>> 2) Checks for the correct return object type (buffer in this case)
>>
>> Use of this interface would simplify and shrink the code.
>>
>
>Sounds good to me, but I have a question.
>
>The acpi_evaluate_object_typed() function seems to be compiled
>only when ACPI_FUTURE_USAGE is defined. And it seems that there
>is no prototype declaration. I don't know about ACPI_FUTURE_USAGE
>at all. Could you please tell me what I should do to use
>acpi_evaluate_object_typed()?
>
>Thanks,
>Kenji Kaneshige
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
