From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [RFT] hp-wmi: improved rfkill support for wifi
Date: Sat, 18 Jul 2009 21:46:08 +0100
Message-ID: <4A623490.50305@tuffmail.co.uk>
References: <4A61FE7D.9080409@tuffmail.co.uk> <8db1092f0907181155h3d603a17q11815b9f174ac333@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f226.google.com ([209.85.219.226]:54356 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbZGRUqL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Jul 2009 16:46:11 -0400
In-Reply-To: <8db1092f0907181155h3d603a17q11815b9f174ac333@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>, Frans Pop <elendil@planet.nl>, Larry Finger <Larry.Finger@lwfinger.net>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Maciej Rutecki wrote:
> 2009/7/18 Alan Jenkins <alan-jenkins@tuffmail.co.uk>:
>   
>> I borrowed a HP G7000 last week.  The hp-wmi driver seemed a bit
>> confused about hard v.s. soft blocks on the wifi, so I fixed it based on
>> acpidump output [1].  I hope this will work on other HP model numbers,
>> but it would benefit from testing.  Any volunteers?
>>     
>
> HP/Compaq nx6310
> 2.6.31-rc3+patch
>
> When is enabled by button:
> root@gumis:/sys/class/rfkill# ls
> rfkill0  rfkill1  rfkill2  rfkill3
> root@gumis:/sys/class/rfkill# cat rfkill*/name
> phy0
> hci0
> hp-wifi
> hp-bluetooth
> root@gumis:/sys/class/rfkill# cat rfkill*/state
> 1
> 1
> 1
> 1
>
> When disabled by button:
> root@gumis:/sys/class/rfkill# ls
> rfkill0  rfkill2  rfkill3
> root@gumis:/sys/class/rfkill# cat rfkill*/name
> phy0
> hp-wifi
> hp-bluetooth
> root@gumis:/sys/class/rfkill# cat rfkill*/state
> 2
> 1
> 0
>
> I enable again by button:
> root@gumis:/sys/class/rfkill# ls
> rfkill0  rfkill2  rfkill3  rfkill4
> root@gumis:/sys/class/rfkill# cat rfkill*/name
> phy0
> hp-wifi
> hp-bluetooth
> hci0
> root@gumis:/sys/class/rfkill# cat rfkill*/state
> 1
> 1
> 1
> 1
>
> I disable "by software" in Windows XP (bluetooth and wireless):
> root@gumis:/sys/class/rfkill# ls
> rfkill0  rfkill1  rfkill2  rfkill3
> root@gumis:/sys/class/rfkill# cat rfkill*/name
> phy0
> hp-wifi
> hp-bluetooth
> hci0
> root@gumis:/sys/class/rfkill# cat rfkill*/state
> 2
> 0
> 1
> 1
>
> Bluetooth works fine when I back to Linux, it seems be enabled during
> boot. Wireless is disabled. I cannot connect to network. So I
> re-enable it in Windows:
> root@gumis:/sys/class/rfkill# ls
> rfkill0  rfkill1  rfkill2  rfkill3
> root@gumis:/sys/class/rfkill# cat rfkill*/name
> phy0
> hci0
> hp-wifi
> hp-bluetooth
> root@gumis:/sys/class/rfkill# cat rfkill*/state
> 1
> 1
> 1
> 1
>
> Regards
>   

Great detail!  That all fits with what I was expecting.

Linux can also do enabling "by software".  At the moment, you need to
download and compile a utility to poke /dev/rfkill.  I wouldn't bother
testing it, because I didn't change that bit :-).

I'll try extending this to bluetooth and wwan as Matthew suggested.  If
you have time to run "acpidump" and send me the output, that would help
me check the details.

Thanks for volunteering :-)
Alan
