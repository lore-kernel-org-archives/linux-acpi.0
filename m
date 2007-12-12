From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [ACPICA] EmbeddedControl region handling bug in PNP0C14
Date: Wed, 12 Dec 2007 18:44:36 +0300
Message-ID: <476001E4.9020900@gmail.com>
References: <200711280350.08539.carlos@strangeworlds.co.uk> <B28E9812BAF6E2498B7EC5C427F293A403C0F46D@orsmsx415.amr.corp.intel.com> <200712121410.15587.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:48270 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760297AbXLLPny (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Wed, 12 Dec 2007 10:43:54 -0500
Received: by ug-out-1314.google.com with SMTP id z38so600436ugc.16
        for <Linux-acpi@vger.kernel.org>; Wed, 12 Dec 2007 07:43:52 -0800 (PST)
In-Reply-To: <200712121410.15587.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: "Moore, Robert" <robert.moore@intel.com>, Linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

_STA for EC is not needed -- might be worth trying to remove it

AnyAcc is not right -- should be ByteAcc.

OperationRegion EC01, EC02 also seem to be good recipe for trouble...


Carlos Corbacho wrote:
> On Wednesday 28 November 2007 18:08:44 Moore, Robert wrote:
>   
>> This will probably require a trace.
>>     
>
> Here's the relevant ACPI error messages (with full ACPI debugging enabled) 
> from acer_acpi, with some comments as to which method is 
> being called and what arguments we're passing.
>
> This user tested this on Kubuntu Gutsy (7.10) x86-64, with a custom 2.6.23.9 
> kernel (basically, just the ACPI debugging enabled so we can get a better 
> trace).
>
> So, for reference, this is the DSDT we're working with:
> http://files.strangeworlds.co.uk/5040.dsl
>
> WMCA(1, 3, NULL):
> [23375.726016] ACPI Error (evregion-0316): No handler for Region
> [RAM_] (ffff81000132d1a0) [EmbeddedControl] [20070126]
> [23375.726246] ACPI Error (exfldio-0289): Region EmbeddedControl(3)
> has no handler [20070126]
> [23375.726475] ACPI Exception (dswexec-0462): AE_NOT_EXIST, While
> resolving operands for [Store] [20070126]
> [23375.726708] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.AMW0.WMCA] (Node ffff8100013315f0), AE_NOT_EXIST
>
> WMCA(1, 6, BUF(4 bytes) = 1):
> [23444.490213] ACPI Error (evregion-0316): No handler for Region
> [RAM_] (ffff81000132d1a0) [EmbeddedControl] [20070126]
> [23444.490218] ACPI Error (exfldio-0289): Region EmbeddedControl(3)
> has no handler [20070126]
> [23444.490223] ACPI Exception (dswexec-0462): AE_NOT_EXIST, While
> resolving operands for [LGreater] [20070126]
> [23444.490228] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.AMW0.WMCA] (Node ffff8100013315f0), AE_NOT_EXIST
> [23444.490263] acer_acpi:   In: 0x00000001
>
> -Carlos
>   

