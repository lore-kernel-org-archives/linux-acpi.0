From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] ACPI, APEI, Print resource errors in conventional format
Date: Tue, 30 Aug 2011 10:32:22 -0600
Message-ID: <CAErSpo73-RPNuVy==bm6VHAbDOUOz2ZTSF5eXSqiy=+z+_k89w@mail.gmail.com>
References: <20110826171052.7959.94505.stgit@bhelgaas.mtv.corp.google.com>
 <4E5AE210.2000105@intel.com> <CAErSpo5tKqKtUKmcq1S81YABXunFY5VW81iWDYsv9v5HeLAVGg@mail.gmail.com>
 <4E5C31C2.90607@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:31056 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab1H3Qcq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Aug 2011 12:32:46 -0400
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id p7UGWiu2029624
	for <linux-acpi@vger.kernel.org>; Tue, 30 Aug 2011 09:32:45 -0700
Received: from gwb11 (gwb11.prod.google.com [10.200.2.11])
	by wpaz21.hot.corp.google.com with ESMTP id p7UGVvK2024978
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 30 Aug 2011 09:32:43 -0700
Received: by gwb11 with SMTP id 11so6875355gwb.34
        for <linux-acpi@vger.kernel.org>; Tue, 30 Aug 2011 09:32:43 -0700 (PDT)
In-Reply-To: <4E5C31C2.90607@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Mon, Aug 29, 2011 at 6:41 PM, Huang Ying <ying.huang@intel.com> wrot=
e:
> On 08/29/2011 10:08 PM, Bjorn Helgaas wrote:
>> On Sun, Aug 28, 2011 at 6:49 PM, Huang Ying <ying.huang@intel.com> w=
rote:
>>> On 08/27/2011 01:10 AM, Bjorn Helgaas wrote:
>>>> Use the normal %pR-like format for MMIO and I/O port ranges.
>>>>
>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> ---
>>>> =A0drivers/acpi/apei/apei-base.c | =A0 =A08 ++++----
>>>> =A01 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/ape=
i-base.c
>>>> index 8041248..8bd5f1a 100644
>>>> --- a/drivers/acpi/apei/apei-base.c
>>>> +++ b/drivers/acpi/apei/apei-base.c
>>>> @@ -460,9 +460,9 @@ int apei_resources_request(struct apei_resourc=
es *resources,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0desc);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!r) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(APEI_PFX
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 "Can not request iomem region <%016llx-%=
016llx> for GARs.\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 "Can not request [mem %#010llx-%#010llx]=
 for %s registers\n",
>>>
>>> Why %#010llx instead of %#016llx?
>>
>> Because %#010llx is effectively what we use for %pR. =A0Two characte=
rs
>> for "0x", then eight for the value. =A0IMHO, sixteen uninterrupted h=
ex
>> characters is too hard to read.
>
> That is reasonable. Thanks.
>
> Acked-by: Huang Ying <ying.huang@intel.com>

Disregard this patch; I'll send a v2 that does the same for another APE=
I file.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
