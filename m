From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] eeepc-laptop: split eeepc_backlight_exit()
Date: Tue, 20 Jan 2009 17:56:49 +0100
Message-ID: <71cd59b00901200856s7d1fcfbep4aeefccc35881723@mail.gmail.com>
References: <1232301715-20292-1-git-send-email-corentincj@iksaif.net>
	 <1232301715-20292-2-git-send-email-corentincj@iksaif.net>
	 <200901181911.05619.corentincj@iksaif.net>
	 <alpine.LFD.2.00.0901201137350.5575@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:39053 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392AbZATRFI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Jan 2009 12:05:08 -0500
Received: by bwz14 with SMTP id 14so11171426bwz.13
        for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2009 09:05:06 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901201137350.5575@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

> Len Brown, Intel Open Source Technology Center
>
> On Sun, 18 Jan 2009, Corentin Chary wrote:
>
>> Arg .. don't know what I did, but I clearly messed up with git-send-email.
>>
>> Isn't git send-email --compose --to linux-acpi@vger.kernel.org --cc
>> lenb@kernel.org  *patch the right command line ?
>>
>> It seems the intro email was lost in the process:
>>
>> > Hi Len,
>> > Here are some patch for asus platform drivers.
>> > The last one is the most interesting, it adds
>> > input layer support for reporting hotkeys.
>
>
> yes, it is correct, and I received the intro message.
> I use this.
>
> git send-email --from "Len Brown <lenb@kernel.org>" --compose --to
> linux-acpi@vger.kernel.org  --suppress-from --no-chain-reply-to
> patch-release
>
> Note that you can assume i'm on linux-acpi, so you don't
> have to cc me.  The intro message is helpful, however,
> so I know if you think the patches are for testing
> or you think they're ready for release.
>
> cheers,
> -Len

Thanks for the tips.

As I said in another mail you can forget this series and some forgoten
patch in the mailling list from Mathiew.
I now have a working git tree
http://git.iksaif.net/?p=acpi4asus.git;a=summary and I just send
another series
regrouping all this patches.

git is really a great tool =).

-- 
Corentin Chary
http://xf.iksaif.net
