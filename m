From: Matthew <jackdachef@gmail.com>
Subject: Re: Linux 2.6.25
Date: Sat, 19 Apr 2008 12:18:33 +0200
Message-ID: <e85b9d30804190318u74e14f0ct6ab53cb86f6ce15f@mail.gmail.com>
References: <e85b9d30804180837y39c52e26i588e4b67c87a5e9d@mail.gmail.com>
	 <alpine.LFD.1.00.0804180843150.2879@woody.linux-foundation.org>
	 <20080418193802.GK7674@cvg> <20080418200338.GL7674@cvg>
	 <48096179.4060803@keyaccess.nl> <480964F7.3040701@keyaccess.nl>
	 <20080419061701.GA7688@cvg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760096AbYDSKTH@vger.kernel.org>
In-Reply-To: <20080419061701.GA7688@cvg>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

>Hello Mat,
>I'm not familiar with "coretemp", can you point me to the exact version
>of the application you are running so I can see how it is getting at
>the underlying information?

>Also, do you see any change with and without kernel built with
CONFIG_THERMAL=y?

>thanks,
>-Len

Hi Len,

sure, the apps I am using for reading out the processor's temp via
coretemp are / were:
lm_sensors: version 2.10.4, 2.10.6 and (currently) 3.0.1: all report
the same (higher) temperatures (compared to 2.6.24 series)

CONFIG_THERMAL currently is enabled in the kernel:
grep CONFIG_THERMAL /usr/src/linux/.config
CONFIG_THERMAL=y

I'll recompile the kernel now & let you know the effect in a few hours
(currently I'm working on the box)

"Dairinin" on forums.gentoo.org pointed out that the desktop-cpu
simply might not be identified correctly:
http://forums.gentoo.org/viewtopic-p-5065902.html#5065902

"Thats because new kernel (lm_sensors, etc?, etc?)incorrectly thinks
our cpu's Tj is 100C, whereas for all core 2 duo's it is 85C (100C is
for C0 stepping and above, AFAIK). Substract 15 and you'll get real
temps."

I don't know if that's the case but it sounds plausible to me

thanks everyone for your answer & help so far

Regards

Mat
