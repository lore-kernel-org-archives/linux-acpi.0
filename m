From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Input Brightness events on EeePc 1201HA
Date: Sun, 2 May 2010 14:31:19 +0200
Message-ID: <q2k71cd59b01005020531n8f827e63qd03588fd980c3c9a@mail.gmail.com>
References: <1272383014.8403.12.camel@plop>
	 <w2t71cd59b01004280220rbbff08cek497c98985e996748@mail.gmail.com>
	 <1272446724.12834.24.camel@plop>
	 <g2o71cd59b01004280508m99790717x9d9f10c71fd1145b@mail.gmail.com>
	 <1272457434.12834.29.camel@plop>
	 <q2z71cd59b01004280528scc775622lf85055f797cec79e@mail.gmail.com>
	 <1272461780.12834.93.camel@plop> <1272462009.12834.95.camel@plop>
	 <t2g71cd59b01004292311sd797e259g6340d701bc52a93e@mail.gmail.com>
	 <1272643738.26706.63.camel@plop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53123 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab0EBMbW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 May 2010 08:31:22 -0400
Received: by bwz19 with SMTP id 19so850607bwz.21
        for <linux-acpi@vger.kernel.org>; Sun, 02 May 2010 05:31:20 -0700 (PDT)
In-Reply-To: <1272643738.26706.63.camel@plop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pascal Terjan <pterjan@mandriva.com>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: acpi4asus-user@lists.sourceforge.net, linux acpi <linux-acpi@vger.kernel.org>

CCing linux-acpi and Zhang Rui.

>> - Does brightness react to keypress (up and/or down) in grub ? windows
>> ? linux wihout X ?
>
> It does not work in GRUB for an unknown reason but I have "good" news
>
> It works in Linux, without using video (which can not manage this
> machine), until psb driver is loaded and creates a backlight device
> using PWM!

Looking at the dsdt:

                        Method (STBR, 0, Serialized)
                        {
                            If (And (^^^GFX0.TCHE, 0x02))
                            {
                                ISMI (0x7A)
                                ^^^GFX0.AINT (One, PAR0)
                            }
                            Else
                            {
                                ISMI (0x78)
                            }
                        }

ISMI (0x78) is the working path, so when psb load, And (^^^GFX0.TCHE,
0x02) become true,  Maybe in this case the psb driver should do
something that it doesn't.

A quick workaround would be to send input events in eeepc-laptop if
GFX0.TCHE & 0x2, but does not sound pretty.

> Unfortunately I can't think of a solution for machines using psb except
> disabling backlight handling there.
>
> It would either conflict (2 backlights device, on in psb, the other in
> eeepc-laptop/wmi) or have keys not handled (as both would not handle
> them if they do not handle backlight)



-- 
Corentin Chary
http://xf.iksaif.net
