From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v4] acpi, apei: add Boot Error Record Table (BERT) support
Date: Tue, 19 Jan 2016 15:12:27 +0800
Message-ID: <CADyBb7sZU=rbimwo-PHSWj3uyiiGd5n1HOEQgdy7V3XFkcNssg@mail.gmail.com>
References: <1452260742-13625-1-git-send-email-fu.wei@linaro.org>
	<20160116191604.GE31869@pd.tnic>
	<569CFFD0.5050102@codeaurora.org>
	<20160118160816.GG12644@pd.tnic>
	<569D232C.2000903@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:32782 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbcASHM2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2016 02:12:28 -0500
Received: by mail-ob0-f180.google.com with SMTP id is5so180004910obc.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jan 2016 23:12:28 -0800 (PST)
In-Reply-To: <569D232C.2000903@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Abdulhamid, Harb" <harba@codeaurora.org>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "Chen, Gong" <gong.chen@intel.com>, Huang Ying <ying.huang@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, tbaicar@codeaurora.org, rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@qti.qualcomm.com>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Jon Masters <jcm@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, "Chen, Gong" <gong.chen@linux.intel.com>

Hi Borislav, Harb,

On 19 January 2016 at 01:38, Abdulhamid, Harb <harba@codeaurora.org> wrote:
>
>
> On 1/18/2016 11:08 AM, Borislav Petkov wrote:
>> On Mon, Jan 18, 2016 at 10:08:00AM -0500, Abdulhamid, Harb wrote: >> Here
>> is my crack at massaging the language a bit more: "Under >> normal
>> circumstances, when a hardware error occurs, the kernel gets >> notified via
>> an NMI, MCE or some other method. When the error has a >> fatal severity or
>> is unrecoverable, the kernel would normally >> panic. > > So this is still
>> not exact. It all depends on what the hardware > does. Even more
>> importantly, does the hardware even run the error > handler and let it
>> access MCA banks to find about the error or does > it directly warm-reset
>> the system. > > The error can happen, it is critical, *nothing* might be
>> visible in > the MCA registers (this is x86-specific) and the machine would
>> reset. > Only when you warm-reset, you may or may not see anything in there.
>> > > In reading the BERT explanation in the ACPI spec, I have to say, it >
>> sounds pretty ok to me: > > "18.3.1 Boot Error Source > > Under normal
>> circumstances, when a hardware error occurs, the error > handler receives
>> control and processes the error. This gives OSPM a > chance to process the
>> error condition, report it, and optionally > attempt recovery. In some
>> cases, the system is unable to process an > error. For example, system
>> firmware or a management controller may > choose to reset the system or the
>> system might experience an > uncontrolled crash or reset.The boot error
>> source is used to report > unhandled errors that occurred in a previous
>> boot. This mechanism is > described in the BERT table." > > I think we
>> should take that text. :)
> Agreed. That would be best.

Thanks, guys.
Will use this instead.


>
> Apologies for the format of the last email.
>
> --
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux
> Foundation Collaborative Project



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
