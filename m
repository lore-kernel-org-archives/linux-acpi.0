From: Adrian Bunk <bunk@stusta.de>
Subject: Re: Regression in kernel linux-2.6.20-rc1/2: Problems with poweroff
Date: Tue, 2 Jan 2007 20:07:23 +0100
Message-ID: <20070102190722.GT20714@stusta.de>
References: <459069AA.20809@rrz.uni-koeln.de> <20061228221616.GI20714@stusta.de> <45999C47.40204@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2327 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754918AbXABTHU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Jan 2007 14:07:20 -0500
Content-Disposition: inline
In-Reply-To: <45999C47.40204@rrz.uni-koeln.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Berthold Cogel <cogel@rrz.uni-koeln.de>, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Jan 02, 2007 at 12:41:59AM +0100, Berthold Cogel wrote:
> Adrian Bunk schrieb:
> > On Tue, Dec 26, 2006 at 01:15:38AM +0100, Berthold Cogel wrote:
> > 
> >> Hello!
> > 
> > Hi Berthold!
> > 
> >> 'shutdown -h now' doesn't work for my system (Acer Extensa 3002 WLMi)
> >> with linux-2.6.20-rc kernels. The system reboots instead.
> >> I've checked linux-2.6.19.1 with an almost identical .config file
> >> (differences because of new or changed options). For pre 2.6.20 kernels
> >> shutdown works for my computer.
> >> ...
> > 
> > Thanks for your report.
> > 
> > Please send:
> > - the .config for 2.6.20-rc2
> > - the output of "dmesg -s 1000000" with 2.6.20-rc2
> > - the output of "dmesg -s 1000000" with 2.6.19
> 
> Hello Adrian,

Hi Berthold,

> I've attached the informations you requested.

thanks for this information.

> In additon to the poweroff problem I see a lot of messages with
> linux-2.6.20-rc2 that I do not see with linux-2.6.20-rc1:
> 
> kernel: ACPI: EC: evaluating _Q80
> kernel: ACPI: EC: evaluating _Q81
> kernel: ACPI: EC: evaluating _Q09
> kernel: ACPI: EC: evaluating _Q20
> 
> I'm running Debian testing/unstable with 'homemade' kernels. The laptop
> is one of those using the Smart Battery System.

The ACPI warnings might be harmless, but there's nothing obvious I see 
outside of ACPI that might be related to your problem (ACPI maintainers 
Cc'ed).

> Berthold

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

