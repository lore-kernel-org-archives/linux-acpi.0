From: Richard <tuxbox.guru@gmail.com>
Subject: Re: 2.6.25 pci=noacpi
Date: Tue, 29 Apr 2008 08:27:11 +0100
Message-ID: <4816CDCF.50100@gmail.com>
References: <20080425183807.366134771@ldl.fc.hp.com>	<20080425183934.516655076@ldl.fc.hp.com>	<4813B5AB.4060308@keyaccess.nl>	<200804281507.38309.bjorn.helgaas@hp.com>	<4816C605.4000601@gmail.com> <20080429000411.ce73230f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:58355 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760269AbYD2H1U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 03:27:20 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1059888ugc.16
        for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2008 00:27:19 -0700 (PDT)
In-Reply-To: <20080429000411.ce73230f.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>

Sorry,

I sent my previous mail too eagerly..

2.6.22 worked
2.6.23 not tested
2.6.24 broken

I will grab a .23 kernel and see if its problem too :-P

R

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

