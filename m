From: Andreas Saur <saur@acmelabs.de>
Subject: Re: Double/Tripple lan0 entries in /proc/interrupts
Date: Wed, 24 May 2006 23:52:29 +0000
Message-ID: <4474F1BD.5040404@acmelabs.de>
References: <CFF307C98FEABE47A452B27C06B85BB68AD7DF@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from natlemon.rzone.de ([81.169.145.170]:8338 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S932375AbWEXXwZ
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 May 2006 19:52:25 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB68AD7DF@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, len.brown@intel.com

Hello Len,

1) Double lan0 entry persists, no matter if your patch (see your link) 
is applied or not. I guess, the following is categorized for you now as 
'not my job anymore', but just for your entertainment, lay back and enjoy:

2) After fresh boot there are still two lan0 entries (w/o your patch)
--> 
http://as68.homeip.net/kernel/2.6.17-rc4-len2/interrupts-fresh-boot-2.6.17-rc4-len2

3) After suspend(S3) and resume by KeyBoard there are three lan0 entries
--> 
http://as68.homeip.net/kernel/2.6.17-rc4-len2/interrupts-after-S3-KBD-2.6.17-rc4-len2

4) After your suggested rmmod, the lan0 entries are replaced now by a 
bunch of random characters.
--> 
http://as68.homeip.net/kernel/2.6.17-rc4-len2/interrupts-after-rmmod_forcedeth-2.6.17-rc4-len2

5) Doing a insmod and a '/etc/init.d/networking restart' provokes a 
kernel panic. Btw.: insmoding does not trigger a dmesg output.
--> http://as68.homeip.net/kernel/2.6.17-rc4-len2/2006-05-24-221108.jpg

6) If I leave out step 5, reloading the module is possible, this leads 
to four lan0 entries in /proc/interrupts. But hey, guys, I don't really 
need that much ;-)

Len, You were completely right: 'Bad bad NIC' ;-) Thanks anyway!

Regards,

Andreas

-------------------------------------------
SUMMERY (alway the same .config)

2.6.17-rc1 --> always resuming(S3) w/o USB in BIOS using WOL, with USB 
three times, forth time dead.
2.6.17-rc3 --> resumes from S3 only with KeyBoard or PowerButton. WOL 
not working. Interrupt entries for lan0 are OK.
2.6.17-rc4 --> resumes from S3 only with KeyBoard or PowerButton and 
this only once. WOL not working. Interrupt entries for lan0 are messed up.

Since 2.6.17-rc2 all mm-patches are causing kernel panics. Standalone 
ACPI-patches does not have any effects (OK, why should they, seems 
something else is broken).
I have the massive feeling something is developing not quite the way it 
should.
-------------------------------------------


Brown, Len schrieb:

>>after getting kernel panics with the mm-patches, I've just patched the 
>>kernel 2.6.17-rc4 only with the latest appropriate git-acpi patch.
>>Question #1: Is this a valid option, to patch the kernel like 
>>that? (If >YES -> Next Question)
>>    
>>
>
>Yes. the latest acpi patch is against Linus' tree.
>eg.
>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6
>.17/acpi-test-20060310-2.6.17-rc4.diff.bz2
>
>  
>
>>Question #2: Is it bad to have two lan0 entries after a fresh boot in 
>>/proc/interrupts, although there is just only one NIC in my system?
>>    
>>
>
>bad NIC, no packet for you.
>
>  
>
>>Question #3: After suspend (S3) and wake up the system via 
>>PowerButton, 
>>I have three lan0 in /proc/interrupts. Is this even worse?
>>    
>>
>
>bad bad NIC...
>
>  
>
>>Question #4: Could this be an indicator for having problems with 
>>resuming from S3 via WOL (magic packet)?
>>    
>>
>
>I doubt it, since something is very broken immediately after the fresh
>boot.
>
>  
>
>>With one older kernel (2.6.17-rc1) I've found a constellation 
>>where I at 
>>least could WOL the system from S3 up to three times, the 
>>forth time it 
>>died. The same kernel-config doesn't work here at all.
>>    
>>
>
>So this multiple lan0 thing goes away when you boot 2.6.17-rc4
>without the acpi patch?
>
>if you rmmod the driver, and the modprobe it again
>does it add an additional entry to /proc/interrupts?
>
>thanks,
>-Len
>
>
>  
>
>>###### BEFORE S3###(have a look at lan0#)############
>>    
>>
>
>  
>
>>16:    49265   IO-APIC-level  ohci_hcd:usb1, lan0, lan0
>>    
>>
>
>  
>
>>####### AFTER RESUME FROM S3 VIA POWERBUTTON ########
>>          CPU0
>>16:    140356   IO-APIC-level  lan0, lan0, lan0, ohci_hcd:usb2
>>    
>>

