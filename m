From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [PATCH 2/2] nfit: update address range scrub commands to the acpi
 6.1 format
Date: Mon, 22 Feb 2016 18:08:11 -0500
Message-ID: <56CB94DB.6050205@hpe.com>
References: <20160220224637.20667.84618.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20160220224648.20667.43800.stgit@dwillia2-desk3.amr.corp.intel.com>
 <56CB8A39.3030107@hpe.com>
 <CAPcyv4gmdK-7jUb-WQoayMD7qtTkpY_r3yjK1fxZs1XXF8=1-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t4621.austin.hp.com ([15.73.212.80]:33095 "EHLO
	g2t4621.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756393AbcBVXIO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Feb 2016 18:08:14 -0500
In-Reply-To: <CAPcyv4gmdK-7jUb-WQoayMD7qtTkpY_r3yjK1fxZs1XXF8=1-A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Vishal Verma <vishal.l.verma@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>



On 2/22/2016 5:41 PM, Dan Williams wrote:
> On Mon, Feb 22, 2016 at 2:22 PM, Linda Knippers <linda.knippers@hpe.com> wrote:
>>
>>
>> On 2/20/2016 5:46 PM, Dan Williams wrote:
>>> The original format of these commands from the "NVDIMM DSM Interface
>>> Example" [1] are superseded by the ACPI 6.1 definition of the "NVDIMM Root
>>> Device _DSMs" [2].
>>>
>>> [1]: http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
>>> [2]: http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf
>>>      "9.20.7 NVDIMM Root Device _DSMs"
>>>
>>> Changes include:
>>> 1/ New 'restart' fields in ars_status, unfortunately these are
>>>    implemented in the middle of the existing definition so this change
>>>    is not backwards compatible.  The expectation is that shipping
>>>    platforms will only ever support the ACPI 6.1 definition.
>>
>> I agree with that.
>>
>>>
>>> 2/ New status values for ars_start ('busy') and ars_status ('overflow').
>>>
>>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>>> Cc: Linda Knippers <linda.knippers@hpe.com>
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
> [..]
>>> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
>>> index 99953b34fa1d..5d28e9405f32 100644
>>> --- a/drivers/nvdimm/bus.c
>>> +++ b/drivers/nvdimm/bus.c
>>> @@ -382,14 +382,14 @@ static const struct nd_cmd_desc __nd_cmd_bus_descs[] = {
>>>       [ND_CMD_ARS_CAP] = {
>>>               .in_num = 2,
>>>               .in_sizes = { 8, 8, },
>>> -             .out_num = 2,
>>> -             .out_sizes = { 4, 4, },
>>> +             .out_num = 4,
>>> +             .out_sizes = { 4, 4, 4, 4, },
>>
>> The status was 4 bytes but now it's 2 bytes of status and 2 bytes of extended
>> status.  Where things are didn't actually change but should the two status
>> fields be defined separately to match the spec?  It would save some shifting and
>> anding.  Maybe a nit...
> 
> For this patch, since I'm tagging it for -stable and ndctl.h is
> exported to userspace, I don't want "status" to have a different
> meaning depending on which version of the kernel header an application
> happened to be compiled against.  I think we're stuck with the unified
> u32.

I was originally thinking that this would be a good time to change since
some of the data formats were changing too but I've reconsidered based
on some other draft/example DSMs I've seen.

The one thing that's consistent is that there are 4 bytes of status.
Sometimes the bytes are split into sub-status fields but not necessarily
into 2 2-byte chunks.  It's more flexible the way it is.

-- ljk
