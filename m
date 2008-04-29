From: Richard <tuxbox.guru@gmail.com>
Subject: Re: 2.6.25 pci=noacpi
Date: Tue, 29 Apr 2008 08:17:53 +0100
Message-ID: <4816CBA1.4050907@gmail.com>
References: <20080425183807.366134771@ldl.fc.hp.com>	<20080425183934.516655076@ldl.fc.hp.com>	<4813B5AB.4060308@keyaccess.nl>	<200804281507.38309.bjorn.helgaas@hp.com>	<4816C605.4000601@gmail.com> <20080429000411.ce73230f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:42602 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbYD2HSC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 03:18:02 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1058317ugc.16
        for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2008 00:17:59 -0700 (PDT)
In-Reply-To: <20080429000411.ce73230f.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>

Hi Andrew/all

A stock standard 2.6.24 kernel worked fine, but it exhibited a problem 
where the timer sources didnt run as expected. ( I didnt put too much 
effort in to it as I wanted a hot off the press kernel ) in 2.6.24 the 
ACPI done its job :-)

I am going to enable netconsole to try see if it can throw me a bone.

Thanks,
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

