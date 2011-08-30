From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] ACPI, APEI, Print resource errors in conventional format
Date: Tue, 30 Aug 2011 08:41:38 +0800
Message-ID: <4E5C31C2.90607@intel.com>
References: <20110826171052.7959.94505.stgit@bhelgaas.mtv.corp.google.com> <4E5AE210.2000105@intel.com> <CAErSpo5tKqKtUKmcq1S81YABXunFY5VW81iWDYsv9v5HeLAVGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11778 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab1H3Alj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Aug 2011 20:41:39 -0400
In-Reply-To: <CAErSpo5tKqKtUKmcq1S81YABXunFY5VW81iWDYsv9v5HeLAVGg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On 08/29/2011 10:08 PM, Bjorn Helgaas wrote:
> On Sun, Aug 28, 2011 at 6:49 PM, Huang Ying <ying.huang@intel.com> wrote:
>> On 08/27/2011 01:10 AM, Bjorn Helgaas wrote:
>>> Use the normal %pR-like format for MMIO and I/O port ranges.
>>>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> ---
>>>  drivers/acpi/apei/apei-base.c |    8 ++++----
>>>  1 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
>>> index 8041248..8bd5f1a 100644
>>> --- a/drivers/acpi/apei/apei-base.c
>>> +++ b/drivers/acpi/apei/apei-base.c
>>> @@ -460,9 +460,9 @@ int apei_resources_request(struct apei_resources *resources,
>>>                                      desc);
>>>               if (!r) {
>>>                       pr_err(APEI_PFX
>>> -             "Can not request iomem region <%016llx-%016llx> for GARs.\n",
>>> +             "Can not request [mem %#010llx-%#010llx] for %s registers\n",
>>
>> Why %#010llx instead of %#016llx?
> 
> Because %#010llx is effectively what we use for %pR.  Two characters
> for "0x", then eight for the value.  IMHO, sixteen uninterrupted hex
> characters is too hard to read.

That is reasonable. Thanks.

Acked-by: Huang Ying <ying.huang@intel.com>

Best Regards,
Huang Ying
