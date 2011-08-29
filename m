From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] ACPI, APEI, Print resource errors in conventional format
Date: Mon, 29 Aug 2011 08:08:32 -0600
Message-ID: <CAErSpo5tKqKtUKmcq1S81YABXunFY5VW81iWDYsv9v5HeLAVGg@mail.gmail.com>
References: <20110826171052.7959.94505.stgit@bhelgaas.mtv.corp.google.com> <4E5AE210.2000105@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:2260 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807Ab1H2OIz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Aug 2011 10:08:55 -0400
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com [172.25.149.12])
	by smtp-out.google.com with ESMTP id p7TE8s3n011354
	for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2011 07:08:54 -0700
Received: from ywf7 (ywf7.prod.google.com [10.192.6.7])
	by hpaq12.eem.corp.google.com with ESMTP id p7TE8qWC023575
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2011 07:08:53 -0700
Received: by ywf7 with SMTP id 7so4746365ywf.19
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2011 07:08:52 -0700 (PDT)
In-Reply-To: <4E5AE210.2000105@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Sun, Aug 28, 2011 at 6:49 PM, Huang Ying <ying.huang@intel.com> wrot=
e:
> On 08/27/2011 01:10 AM, Bjorn Helgaas wrote:
>> Use the normal %pR-like format for MMIO and I/O port ranges.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>> =A0drivers/acpi/apei/apei-base.c | =A0 =A08 ++++----
>> =A01 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-=
base.c
>> index 8041248..8bd5f1a 100644
>> --- a/drivers/acpi/apei/apei-base.c
>> +++ b/drivers/acpi/apei/apei-base.c
>> @@ -460,9 +460,9 @@ int apei_resources_request(struct apei_resources=
 *resources,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0desc);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!r) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(APEI_PFX
>> - =A0 =A0 =A0 =A0 =A0 =A0 "Can not request iomem region <%016llx-%01=
6llx> for GARs.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "Can not request [mem %#010llx-%#010llx] f=
or %s registers\n",
>
> Why %#010llx instead of %#016llx?

Because %#010llx is effectively what we use for %pR.  Two characters
for "0x", then eight for the value.  IMHO, sixteen uninterrupted hex
characters is too hard to read.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
