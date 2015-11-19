From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [RFC PATCH] Fix _FIT vs. NFIT processing breakage
Date: Thu, 19 Nov 2015 11:25:43 -0500
Message-ID: <564DF807.7080208@hpe.com>
References: <20151118175359.GA2209@ljk840.redhat.com>	 <1447880848.30346.9.camel@intel.com> <564CED90.5000501@hpe.com>	 <1447885355.21443.159.camel@hpe.com> <1447890234.30346.20.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t6225.austin.hp.com ([15.73.96.126]:57945 "EHLO
	g1t6225.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbbKSQZq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2015 11:25:46 -0500
Received: from g1t6220.austin.hp.com (g1t6220.austin.hp.com [15.73.96.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g1t6225.austin.hp.com (Postfix) with ESMTPS id 0E30955F8
	for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2015 16:25:46 +0000 (UTC)
In-Reply-To: <1447890234.30346.20.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, "toshi.kani@hpe.com" <toshi.kani@hpe.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "elliott@hpe.com" <elliott@hpe.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

On 11/18/2015 6:43 PM, Verma, Vishal L wrote:
> On Wed, 2015-11-18 at 15:22 -0700, Toshi Kani wrote:
>> On Wed, 2015-11-18 at 16:28 -0500, Linda Knippers wrote:
>>> On 11/18/2015 4:07 PM, Verma, Vishal L wrote:
>>>> On Wed, 2015-11-18 at 12:54 -0500, Linda Knippers wrote:
>>>>> Since commit 209851649dc4f7900a6bfe1de5e2640ab2c7d931, we no
>>>>> longer
>>>>> see NVDIMM devices on our systems.  The NFIT/_FIT processing at
>>>>> initialization gets a table from _FIT but doesn't like it.
>>>>>
>>>>> When support for _FIT was added, the code presumed that the data
>>>>> returned by the _FIT method is identical to the NFIT table,
>>>>> which
>>>>> starts with an acpi_table_header.  However, the _FIT is defined
>>>>> to return a data in the format of a series of NFIT type
>>>>> structure
>>>>> entries and as a method, has an acpi_object header rather tahn
>>>>> an acpi_table_header.
>>>>
>>>> Hm, I couldn't find any reference to this in the spec - that NFIT
>>>> will
>>>> have the acpi_table_header but _FIT will have a different header -
>>>> but
>>>> I'm no ACPI expert - is this usual convention? Any pointers where
>>>> I
>>>> could look at?
>>>
>>> I'm no ACPI expert either so maybe Toshi or someone else will help
>>> me
>>> here but according to the FW developer, the convention is that there
>>> is
>>> no ACPI table header because you already know what the table is.
>>
>> map_mat_entry() handles _MAT for processor objects, which expects no
>> MADT header
>> table.
>
> Ok, thanks for the clarifications. I'm fine with the fix. Could you
> resend an updated patch without the extra debug.

Yes, I will do that.  I've only tested the boot path of the patch though.
Is there an easy way for me to trigger the notification so I can test the other
code path?

- ljk

> We'd also have to
> update the unit test framework - in tools/testing/nvdimm/test/nfit.c, in
> nfit_test0_setup, based on whether it is being called with the hotplug
> flag or not, decide which header to include.
>
> Thanks,
> 	-Vishal
>
>>
>> Thanks,
>> -Toshi
>>
>>> Also, if you look at the NFIT definition (table 5-126) , the
>>> definition
>>> explicitly includes the APCI table header but the _FIT definition
>>> does not.
>>> It just says it's a series of NFIT Types structure entries.
>>>

