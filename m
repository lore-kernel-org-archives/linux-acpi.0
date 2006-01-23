From: Niko Ehrenfeuchter <ehrenfeu@informatik.uni-freiburg.de>
Subject: Re: CPU - Power state (Cx) usage count not working
Date: Mon, 23 Jan 2006 11:40:06 +0100
Message-ID: <1138012807.2948.9.camel@spitfire>
References: <43D491A5.6010000@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:47861 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932440AbWAWKkL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jan 2006 05:40:11 -0500
In-Reply-To: <43D491A5.6010000@sbox.tugraz.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi Gerfried,

On Mon, 2006-01-23 at 09:19 +0100, Gerfried Maier wrote:
> Hi everybody!
> 
> According to the ACPI4Linux doc
> 
> cat /proc/acpi/processor/CPU0/power
> 
> should look like
> 
> active state:            C2
> default state:           C1
> bus master activity:     00004f00
> states:
>     C1:                  promotion[C2] demotion[--] latency[000]
> usage[00033670]
>    *C2:                  promotion[C3] demotion[C1] latency[084]
> usage[00357060]
>     C3:                  promotion[--] demotion[C2] latency[120]
> usage[00000000]
> 
> Unfortunaltely on my system (P4m 1800Mhz; 2.4.31 or .32) the usage count
> shows always 00000000. Unloading several modules (eg usb-ohci) has no
> effect.

the counter normally shows the de facto usage, so I assume your system
never uses C3 in the above situation. Unloading the usb-modules on a 2.4
kernel _might_ help, but it also might not suffice. If you have anything
that causes busmaster activity, your system will never use C3. This
could be a module (as said above, the usb-modules on 2.4 do so - that's
fixed in the 2.6 series) as well as some process, e.g. sound output or
some monitoring stuff (I remember gkrellm  once preventing my system to
enter C3). To check this, you could try to boot into single-user mode,
unload all unnecessary modules and then recheck for C3 usage.

Some time ago, I wrote a couple of lines considering the c-states with
kernel 2.4 on the acpi-wiki. You can have a look there:

http://acpi.sourceforge.net/wiki/index.php/WhyMyCxPowerStateIsNotUsed

hth,
Niko

