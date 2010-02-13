From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: closing lid on laptop suspends it
Date: Sat, 13 Feb 2010 12:31:20 -0600
Message-ID: <4B76EFF8.6000108@gmail.com>
References: <1265718787.2459.56.camel@pc.interlinx.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f201.google.com ([209.85.223.201]:33432 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab0BMSbX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Feb 2010 13:31:23 -0500
Received: by iwn39 with SMTP id 39so961062iwn.1
        for <linux-acpi@vger.kernel.org>; Sat, 13 Feb 2010 10:31:23 -0800 (PST)
In-Reply-To: <1265718787.2459.56.camel@pc.interlinx.bc.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-acpi@vger.kernel.org

On 02/09/2010 06:33 AM, Brian J. Murrell wrote:
> I have a Toshiba Tecra M9 laptop running a 2.6.31 kernel.
>
> I'm not even sure if this is really the correct list, but if not,
> hopefully somebody can give me a gentle shove in the right direction.
>
> The problem I'm having with this laptop is that once it has booted up,
> prior to logging into the gnome desktop, if I (open if not already
> opened and then) close the lid, it suspends, even when plugged into AC.
>
> If I log into gnome, my gnome-power-manager preferences are applied and
> closing the lid with AC plugged in only blanks the screen, it does not
> suspend the laptop.

I suspect there's some power management task running even before login 
that's using some default preferences. The kernel doesn't trigger a 
suspend by itself.

>
> Additionally, after this suspend-on-lid-close operation, I get the
> following complaints on the kernel message buffer:
>
> Feb  8 12:33:58 brian-laptop kernel: [14735.616976] NVRM: rm_init_adapter(0) failed
> Feb  8 12:34:03 brian-laptop kernel: [14739.756068] NVRM: RmInitAdapter failed! (0x26:0x38:1096)
> Feb  8 12:34:03 brian-laptop kernel: [14739.756075] NVRM: rm_init_adapter(0) failed
> Feb  8 12:34:07 brian-laptop kernel: [14744.044665] NVRM: RmInitAdapter failed! (0x26:0x38:1096)
> Feb  8 12:34:07 brian-laptop kernel: [14744.044671] NVRM: rm_init_adapter(0) failed
> Feb  8 12:34:11 brian-laptop kernel: [14748.200786] NVRM: RmInitAdapter failed! (0x26:0x38:1096)
>
> and the graphic display is no longer working.  The above of course may
> or may not be related, but might just be a casualty of some other
> problem.  I just offer it in hopes that it provides more clue as to what
> is going on.

Those messages come from the NVIDIA binary driver, we have no way of 
knowing what they mean - only they can likely help you with them..
