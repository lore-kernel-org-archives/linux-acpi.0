From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [2.6 patch] the scheduled ACPI_PROCFS removal
Date: Wed, 11 Jul 2007 13:54:49 -0400
Message-ID: <46951969.4030109@tmr.com>
References: <20070709145755.GD3492@stusta.de> <20070709174544.2a6b7067@the-village.bc.nu> <Pine.LNX.4.64.0707092044520.2887@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765850AbXGKRwE@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0707092044520.2887@fbirervta.pbzchgretzou.qr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@stusta.de>, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Jan Engelhardt wrote:
> On Jul 9 2007 17:45, Alan Cox wrote:
>>> This patch contains the scheduled removal of the ACPI procfs interface.
>> What part of "we do not gratuitously break user space interfaces" is so
>> hard for people to understand.
> 
> Generally I am with you on that, but if everyone keeps on using /proc --
> and I do[*] -- we will never get rid of it.
> 
Is there some reason why you should get rid of it? Is it causing a lot 
work to maintain?
> 
> [*] Does someone have an alternative for /proc/acpi/battery/BAT1/{state,info}?
> 


-- 
Bill Davidsen <davidsen@tmr.com>
   "We have more to fear from the bungling of the incompetent than from
the machinations of the wicked."  - from Slashdot
