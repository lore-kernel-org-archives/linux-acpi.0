From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v4] acpi, apei, arm64: APEI initial support for aarch64.
Date: Tue, 08 Dec 2015 20:52:28 +0800
Message-ID: <5666D28C.4090305@linaro.org>
References: <1449558183-12259-1-git-send-email-fu.wei@linaro.org> <20151208123433.GB404@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:32886 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432AbbLHMwb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2015 07:52:31 -0500
Received: by wmec201 with SMTP id c201so210973390wme.0
        for <linux-acpi@vger.kernel.org>; Tue, 08 Dec 2015 04:52:30 -0800 (PST)
In-Reply-To: <20151208123433.GB404@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, fu.wei@linaro.org
Cc: tomasz.nowicki@linaro.org, tn@semihalf.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, graeme.gregory@linaro.org, al.stone@linaro.org, mark.rutland@arm.com, Marc.Zyngier@arm.com, rruigrok@codeaurora.org, harba@qti.qualcomm.com, jcm@redhat.com, msalter@redhat.com, grant.likely@linaro.org, rrichter@cavium.com, jarkko.nikula@linux.intel.com, jon.zhixiong.zhang@gmail.com

Hi Lorenzo,

On 12/08/2015 08:34 PM, Lorenzo Pieralisi wrote:
> On Tue, Dec 08, 2015 at 03:03:03PM +0800, fu.wei@linaro.org wrote:
>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>
> [...]
>
>> +#if defined(__i386__) || defined(__x86_64__)
>>   /*
>>    * Check if firmware advertises firmware first mode. We need FF bit to be set
>>    * along with a set of MC banks which work in FF mode.
>>    */
>>   static int __init hest_parse_cmc(struct acpi_hest_header *hest_hdr, void *data)
>>   {
>> -	return arch_apei_enable_cmcff(hest_hdr, data);
>> +	if (!acpi_disable_cmcff)
>
> Why do not you define the flag above in this file (move it out of x86 -
> that's what I was aiming at in my previous reply) and remove this ifdeffery
> altogether (First firmware handling could apply to arm64 too according to
> specs and ACPI on arm64 guidelines) ?

If I understand it correctly, CMC (Corrected Machine Check) is for IA32
only, see section 18.3.2.1 IA-32 Architecture Machine Check Exception
in ACPI 6.0. for ARM64, we can use other type of error source for
firmware first handling, such as Generic Hardware Error Source, did
I miss something?

Thanks
Hanjun
