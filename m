From: Milan Oravec <moravec@ukf.sk>
Subject: Re: ACPI linux problem
Date: Wed, 17 Sep 2008 08:48:18 +0200
Message-ID: <48D0A832.2090200@ukf.sk>
References: <48BE93DB.7080801@ukf.sk> <960B77DF2E6D974DBE24FD066EAEE8DA014A6B4F@azsmsx422.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from posta.ukf.sk ([193.87.12.33]:58665 "EHLO posta.ukf.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbYIQHPT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Sep 2008 03:15:19 -0400
In-Reply-To: <960B77DF2E6D974DBE24FD066EAEE8DA014A6B4F@azsmsx422.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi Len, sorry for using wrong emial address.

After your consultation I've found what caused my problems with broken 
hibernation resume on battery.
It's sony_laptop driver directly compiled in kernel. When it's compiled 
as module and reloaded every suspend cycle everything works as suspected.

I observed this problem first time in 2.6.25 kernel tree, but there were 
this problem only occassionaly present (2nd or 3th reboot it's resumed 
properly), but in 2.6.26 is permanenet resume problem.

What's next step? How can I help to solve this problem.

Thank you very much for help!

Best regards

Milan

Brown, Len wrote:
> Hello Milan,
> 
>> When I hibernate on AC-power and try to resume on battery system
> hangs.
> 
> Interesting.
> 
> try to simplify.
> 
> remove the sony-laptop module,
> also remove the ac and battery modules.
> 
> 
> if the absence of one of these helps, then that is a big clue.
> (also, did any previous releases work properly?)
> 
> best to send mail to linux-acpi@vger.kernel.org
> and/or file a bug at bugzilla.kernel.org
> rather than sending e-mail to my intel account.
> for others in the community besides me may have this problem,
> or the solution to it.
> 
> thanks,
> -Len
> 
>> -----Original Message-----
>> From: Milan Oravec [mailto:moravec@ukf.sk] 
>> Sent: Wednesday, September 03, 2008 9:41 AM
>> To: Brown, Len
>> Subject: ACPI linux problem
>>
>> Hallo, my name is Milan Oravec. I'm playing a little with linux and 
>> TuxOnIce (Hibernate2) on my laptop. I have problems with 2.6.26 kernel 
>> tree and suspend to disk. When I hibernate on AC-power and try 
>> to resume 
>> on battery system hangs. I've attached screenshot with dead end. The 
>> same problem is with stock kernel swsuspend (without tuxonice 
>> patches). 
>>  I've consulted this with Nigel Cunningham and he suggested me to 
>> report this bug to you. If you need more information I'll do my best.
>>
>> Laptop is sony vaio sz1xp and here is my lspci output:
>>
>> 00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS, 943/940GML 
>> and 945GT Express Memory Controller Hub (rev 03)
>> 00:02.0 VGA compatible controller: Intel Corporation Mobile 945GM/GMS, 
>> 943/940GML Express Integrated Graphics Controller (rev 03)
>> 00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/GME, 
>> 943/940GML Express Integrated Graphics Controller (rev 03)
>> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High 
>> Definition Audio Controller (rev 02)
>> 00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
>> Port 1 (rev 02)
>> 00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
>> Port 2 (rev 02)
>> 00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
>> Port 3 (rev 02)
>> 00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
>> Port 4 (rev 02)
>> 00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) 
>> USB UHCI 
>> Controller #1 (rev 02)
>> 00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) 
>> USB UHCI 
>> Controller #2 (rev 02)
>> 00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) 
>> USB UHCI 
>> Controller #3 (rev 02)
>> 00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) 
>> USB UHCI 
>> Controller #4 (rev 02)
>> 00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) 
>> USB2 EHCI 
>> Controller (rev 02)
>> 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
>> 00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface 
>> Bridge (rev 02)
>> 00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE 
>> Controller (rev 02)
>> 00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 
>> Family) SATA 
>> IDE Controller (rev 02)
>> 00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller 
>> (rev 02)
>> 06:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG 
>> Network Connection (rev 02)
>> 07:00.0 Ethernet controller: Marvell Technology Group Ltd. 
>> 88E8036 PCI-E 
>> Fast Ethernet Controller (rev 15)
>> 09:04.0 CardBus bridge: Texas Instruments PCIxx12 Cardbus Controller
>> 09:04.1 FireWire (IEEE 1394): Texas Instruments PCIxx12 OHCI Compliant 
>> IEEE 1394 Host Controller
>> 09:04.2 Mass storage controller: Texas Instruments 5-in-1 Multimedia 
>> Card Reader (SD/MMC/MS/MS PRO/xD)
>>
>> I'm sorry if I'm bothering you.
>>
>> Thank you very much!
>>
>> Milan
>>
>>
> 
