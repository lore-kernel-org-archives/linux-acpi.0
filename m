From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH] CPPC: Initialize and check CPUFreq CPU co-ord type correctly
Date: Thu, 19 Nov 2015 19:10:10 -0500
Message-ID: <CAJ5Y-ebA2X_5rNgFWw844cYMvh9TUxeQTxY6KZQa+6x6XYDLhQ@mail.gmail.com>
References: <CAJ5Y-eY=fo=JT11CqYR09Nis--TLpdHtxo+JyC6nh07kVgUrdg@mail.gmail.com>
 <1447947607-10822-1-git-send-email-ashwin.chaugule@linaro.org> <2207845.vCMVaXtKa3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35770 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758547AbbKTAKb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2015 19:10:31 -0500
Received: by lbbsy6 with SMTP id sy6so53037522lbb.2
        for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2015 16:10:30 -0800 (PST)
In-Reply-To: <2207845.vCMVaXtKa3@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rafael Wysocki <rafael@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>

On 19 November 2015 at 17:17, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, November 19, 2015 10:40:07 AM Ashwin Chaugule wrote:
>> The CPU policy struct indicates the co-ordination type
>> for all CPUs of a common freq domain. Initialize it
>> correctly using the CPU specific data gathered from
>> CPPC ACPI lib via acpi_get_psd_map().
>>
>> The PSD object is optional, so the cpu->shared_type
>> can also be 0. So instead of assuming any value other
>> than SW_ANY(0xFD) is unsupported, explictly check
>> if shared_type is SW_ALL and then bail.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>
> I'm assiming that this is a replacement for https://patchwork.kernel.org/patch/7607581/
> so I'm going to replace that patch with this one, but that means it will go
> into -rc3 instead.
>

Replacement is correct. I guess I didn't realize you had pulled it in
already. :)

Thanks,
Ashwin.
