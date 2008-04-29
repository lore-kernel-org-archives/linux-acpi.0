From: Richard <tuxbox.guru@gmail.com>
Subject: Re: 2.6.25 pci=noacpi
Date: Tue, 29 Apr 2008 12:01:10 +0100
Message-ID: <4816FFF6.5060700@gmail.com>
References: <20080425183807.366134771@ldl.fc.hp.com>	<20080425183934.516655076@ldl.fc.hp.com>	<4813B5AB.4060308@keyaccess.nl>	<200804281507.38309.bjorn.helgaas@hp.com>	<4816C605.4000601@gmail.com> <20080429000411.ce73230f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:47570 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273AbYD2LBW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 07:01:22 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1099346ugc.16
        for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2008 04:01:20 -0700 (PDT)
In-Reply-To: <20080429000411.ce73230f.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>

Hi there,

Now I am at a loss.. I cant get any logs from netconsole. With ACPI
enabled it drops dead just after the kernel hands control to Init. When
I reboot with acpi disabled there is no trace of the previous boot in
/var/log/message or kernel logs.

The network card I have is a Tigon3 and its not initialised before the
system dies... or so it looks (altho I cant seem to get any netconsole
working - I suspect pebkac)

I have tried to find an option where the kernel boot is logged
explicitly to disk, but I cant seem to find the option. There is so much
chaff I cant seem to get my brain to find the REAL options list thats up
to date.

Any pointers are appreciated
Richard





Andrew Morton wrote:
> On Tue, 29 Apr 2008 07:53:57 +0100 Richard <tuxbox.guru@gmail.com> wrote:
>
>   
>> Hi all,
>>
>> Using an AMD Sempron notebook (HP Compaq 6715b) single processor 
>> machine,  It shuts down during bootup when ACPI is fully enabled.  I 
>> added pci=noacpi to the cmdline and it finally boots, but its extremely 
>> slow...  (kdm times out with error saying it took too long to load and 
>> disables graphical)
>>
>> Dmesg doest show anything out of the ordinary, irq_stats only shows the 
>> timer interrupts being incremented. (noirq also works, but same 
>> behaviour) Can someone please offer me some pointers so I can fault find 
>> this problem.
>>
>>     
>
> Did any earlier kernels work OK?  If so, which versions?
>
> Thanks.
>
>   

