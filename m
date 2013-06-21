From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] mce: acpi/apei: Add a boot option to disable ff
 mode for corrected errors
Date: Fri, 21 Jun 2013 22:13:55 +0530
Message-ID: <51C482CB.9040700@linux.vnet.ibm.com>
References: <20130619180441.GK28300@pd.tnic> <3908561D78D1C84285E8C5FCA982C28F2DA88106@ORSMSX106.amr.corp.intel.com> <20130619183640.GL28300@pd.tnic> <3908561D78D1C84285E8C5FCA982C28F2DA881C2@ORSMSX106.amr.corp.intel.com> <20130619201438.GM28300@pd.tnic> <3908561D78D1C84285E8C5FCA982C28F2DA8838B@ORSMSX106.amr.corp.intel.com> <20130619210706.GP28300@pd.tnic> <3908561D78D1C84285E8C5FCA982C28F2DA884F0@ORSMSX106.amr.corp.intel.com> <51C37251.4000008@linux.vnet.ibm.com> <3908561D78D1C84285E8C5FCA982C28F2DA8993C@ORSMSX106.amr.corp.intel.com> <20130621072725.GB22006@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:41231 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161590Ab3FUQoI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jun 2013 12:44:08 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Sat, 22 Jun 2013 02:36:57 +1000
In-Reply-To: <20130621072725.GB22006@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
Cc: "ananth@in.ibm.com" <ananth@in.ibm.com>, "masbock@linux.vnet.ibm.com" <masbock@linux.vnet.ibm.com>, "lcm@linux.vnet.ibm.com" <lcm@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>, Robert Richter <rric@kernel.org>

On 06/21/2013 12:57 PM, Borislav Petkov wrote:
> On Thu, Jun 20, 2013 at 10:11:27PM +0000, Luck, Tony wrote:
>>> - Two, the Generic Error Data Entry (aka UEFI Section Descriptor) has a
>>> flag which indicates 'Error Threshold Exceeded'. From the UEFI spec, it
>>> looks like we could consider this as an indication to offline the page;
>>> though I am not sure if/how this relates to the threshold value above.
>>
>> This one sounds to make sense ... the flag description sounds exactly what
>> we want - I won't feel embarrassed explaining to people why Linux takes
>> action when it sees a record like this.
>
> Yep, and firmware can set that flag when it wants to, so decision when
> to offline a page is left to the platform.
>

Ok, I will work towards a patch which does this.

Thanks,
Naveen

