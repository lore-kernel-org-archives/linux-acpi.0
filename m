From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] acpi/blacklist: enable OSI(Linux) on newer eeepc
Date: Mon, 23 Nov 2009 18:01:58 +0100
Message-ID: <71cd59b00911230901l50fd063aof27d50688c871cc7@mail.gmail.com>
References: <1258752548-9299-1-git-send-email-corentincj@iksaif.net>
	 <20091121184503.GA15141@srcf.ucam.org>
	 <71cd59b00911211322t45be6c92g2a0c78c03d7eb5e9@mail.gmail.com>
	 <20091121232815.GA17749@srcf.ucam.org>
	 <alpine.LFD.2.00.0911231113520.858@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:43672 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbZKWRBw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2009 12:01:52 -0500
Received: by pzk1 with SMTP id 1so4079834pzk.33
        for <linux-acpi@vger.kernel.org>; Mon, 23 Nov 2009 09:01:58 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0911231113520.858@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux acpi <linux-acpi@vger.kernel.org>

On Mon, Nov 23, 2009 at 5:24 PM, Len Brown <lenb@kernel.org> wrote:
> On Sat, 21 Nov 2009, Matthew Garrett wrote:
>
>> On Sat, Nov 21, 2009 at 10:22:45PM +0100, Corentin Chary wrote:
>>
>> > I think we could add that patch to 2.6.32, then revert it in 2.6.33 (or later)
>> > when a eeepc-wmi driver (or wmi support inside eeepc-laptop) is available.
>> > And I don't think such a driver (patch) will be available before 2.6.32.
>> >
>> > That means that owner of 1000h and 1005ha won't be able to use eeepc-laptop
>> > (camera, rfkill, hotkeys) without adding acpi_osi="Linux" manually in 2.6.32.
>> >
>> > I know this is not a long term solution.
>>
>> The reason I'm not keen is that hardware vendors seem to continue
>> believing that Linux claims to be Linux - it's almost understandable for
>> Asus when they're shipping 2.6.remotely_exploitable on their hardware,
>> but Lenovo are still doing it for no obvious reason. I'm worried that
>> even doing a single release with this defined will result in Asus
>> pulling the same trick at some point in the future.
>
> I agree with Matthew that this is distasteful -- particularly
> since the models in question came out well after upstream Linux
> stopped setting OSI(Linux) (2.6.32).
>
> However, I think the fact that this DMI is specific to the 1000h and
> 1005ha makes it less scary.

I added 1000h and 1005h because I only get reports for these,
but I think this will affect all models with Windows 7 support :/

I'm currently trying to get the hardware, but don't think I can get it before
2.6.32 release...

-- 
Corentin Chary
http://xf.iksaif.net
