From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] acpi: handle ACPI0007 Device in acpi_early_set_pdc
Date: Fri, 17 Sep 2010 11:37:21 -0700
Message-ID: <4C93B561.2040902@kernel.org>
References: <4C89906B.1050406@kernel.org> <201009131128.42519.bjorn.helgaas@hp.com> <4C931714.2080905@kernel.org> <201009170756.53100.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:20219 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755162Ab0IQSik (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Sep 2010 14:38:40 -0400
In-Reply-To: <201009170756.53100.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Brown, Len" <len.brown@intel.com>, Suresh Siddha <suresh.b.siddha@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>

On 09/17/2010 06:56 AM, Bjorn Helgaas wrote:
> On Friday, September 17, 2010 01:21:56 am Yinghai Lu wrote:
>> On 09/13/2010 10:28 AM, Bjorn Helgaas wrote:
>>> On Friday, September 10, 2010 08:06:26 pm Yinghai Lu wrote:
>>>
>>> I timed the original on a 64-CPU box where the namespace walk cost
>>> should be relatively high, and the walk you added takes about 0.01
>>> seconds.  The one already there took about 0.03 seconds, so neither
>>> costs very much.
>>>
>>> And I don't like the fact that the patch below changes the ACPI CA
>>> and it only partly implements acpi_get_devices(), since it ignores
>>> _CID and _STA.
>>
>> please check this one. it still keep _STA etc.
> 
> I think you missed this line in my previous response:
> 
>>> But I do see your point, and having seen the patch
>>> below, I prefer the original one-line version.
> 
> The patch below is better, because it doesn't reimplement quite
> so much stuff, but it still changes the CA,
not sure.
> and I think the end
> result is still quite confusing to read.
yeah, it is confusing to read.... callback with callback.
> 
> So I still prefer the original one-line version.

ok, Will resend out original one with updated changelog.

Yinghai
