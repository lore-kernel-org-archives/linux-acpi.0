From: Al Stone <al.stone@linaro.org>
Subject: Re: [RFC 0/5] console/acpi: add DBG2 and SPCR console configuration
Date: Tue, 12 Jan 2016 17:07:49 -0700
Message-ID: <56959555.6090705@linaro.org>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
 <56951841.4010101@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36027 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbcAMAHw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2016 19:07:52 -0500
Received: by mail-oi0-f50.google.com with SMTP id o124so74806394oia.3
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jan 2016 16:07:52 -0800 (PST)
In-Reply-To: <56951841.4010101@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christopher Covington <cov@codeaurora.org>, Leif Lindholm <leif.lindholm@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, graeme.gregory@linaro.org
Cc: mark.rutland@arm.com, linaro-acpi@lists.linaro.org, jcm@redhat.com, torez@redhat.com, lv.zheng@intel.com, Timur Tabi <timur@quicinc.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On 01/12/2016 08:14 AM, Christopher Covington wrote:
> Hi,
> 
> On 09/08/2015 08:43 AM, Leif Lindholm wrote:
>> Support for configuring bootconsole and console via the ACPI tables
>> DBG2 (Debug Port Table 2) [1] and SPCR (Serial Port Console Redirection
>> Table) [2], defined by Microsoft, has been discussed on and off over the
>> years.
>>
>> [1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639131(v=vs.85).aspx
>> [2] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx
>>
>> Licensing concerns have prevented this happening in the past, but as of
>> 10 August 2015, these tables have both been released also under OWF 1.0
>> (http://www.openwebfoundation.org/legal/the-owf-1-0-agreements/owfa-1-0)
>> which is think is noncontroversially GPL-compatible?
>>
>> This set is a first attempt at implementing this.
>>
>> Submitting as an RFC since the SPCR handling currently depends on the
>> console driver being initialized after subsystem initcalls. Workaround
>> to enable testing surrounding infrastructure in 5/5, _really_ not
>> intended to be merged.
>> (Suggestions for acceptable ways of working around this appreciated.)
> 
> What's required for this to graduate from RFC status? Is anyone working
> on it?
> 
> Thanks,
> Christopher Covington
> 

Well, we have asked Aleksey Makarov <aleksy.makarov@linaro.org> to pick
this task up from Leif within Linaro.  Perhaps drop him a line and see
if the two of you can collaborate on this somehow?  I think it just needs
nudging and a bit of TLC to get it past being an RFC.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
