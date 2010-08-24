From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] ACPI: pci_irq, add PRT_ quirk for IBM Bartolo
Date: Tue, 24 Aug 2010 10:11:11 +0200
Message-ID: <4C737E9F.7060107@gmail.com>
References: <1277673679-21458-1-git-send-email-jslaby@suse.cz>	<4C27E965.80508@gmail.com>	<4C283D84.6080504@suse.cz>	<20100628171410.GA27367@srcf.ucam.org>	<4C290245.2040001@suse.cz>	<20100628204820.GA32503@srcf.ucam.org>	<AANLkTil-sdbojCXBp6sR_4xL3JIe6ZENqXuueB61VJ8c@mail.gmail.com>	<4C2A3E27.4060407@suse.cz>	<AANLkTimkElR1u-iRyFfCEQR5VTZvcyEIGQodfmFNtbC_@mail.gmail.com>	<4C2B0C73.9050200@suse.cz>	<4C3278C8.60503@gmail.com>	<4C447D6D.5060801@suse.cz> <AANLkTin9_yEyMZImRbtKTvTeokks8dz0htQCu0B3RqXH@mail.gmail.com> <4C456C69.60606@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38341 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab0HXILR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Aug 2010 04:11:17 -0400
In-Reply-To: <4C456C69.60606@suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Robert Hancock <hancockrwd@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>

On 07/20/2010 11:29 AM, Jiri Slaby wrote:
> On 07/19/2010 09:19 PM, Robert Hancock wrote:
>> On Mon, Jul 19, 2010 at 10:29 AM, Jiri Slaby <jslaby@suse.cz> wrote:
>>>>> I still no point in comparing this to Windows' setup. We can't find out
>>>>> whether it is quirked or better (without some bug) handled there.
>>>>
>>>> Well, you can see if Windows shows IRQ 10 or 11 for that device..
>>>
>>> But how can I find out which link it is routed to in Windows? Without
>>> that information the number is meaningless, no?
>>
>> If you look at the pattern of which IRQs are shared by what devices in
>> Linux and compare it to Windows you can get a good idea. Normally the
>> assignment of devices to interrupt lines is hard-wired on the
>> motherboard and doesn't change.
> 
> Ok, thanks for the hint.
> 
> What we've found out is that it works on 2.6.27 (with slightly changed
> configuration).

No, this was a false alarm. It never worked with acpi irq routing on
older kernels in this HW configuration.

So, to sum up:
1) acpi routing enabled (no kernel parameter) => ports 4+5 defunct.
ports 4+5+6+7 are all on irq 11

2) acpi routing disabled (acpi=noirq) => all ports working, 4+5 on irq
10, 6+7 on irq 11

3) with the quirk [1] and acpi routing enabled => all ports working,
ports 4+5 on irq 10, 6+7 on irq 11

4) in windows => 4+5+6+7 are all on irq 9 and the ports are all working.

Any ideas what this means? Especially point 4)?

[1] http://lkml.org/lkml/2010/6/27/85

thanks,
-- 
js
