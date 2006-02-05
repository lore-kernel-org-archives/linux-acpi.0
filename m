From: Pavel Troller <patrol@sinus.cz>
Subject: Re: Question about AthlonXP on nforce 2 : C2-C3 states
Date: Sun, 5 Feb 2006 15:37:42 +0100
Message-ID: <20060205143742.GA20815@tangens.sinus.cz>
References: <20060205152120.1688bd7b.arthur.huillet@agoctrl.org>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:49624 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S1750856AbWBEOiO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2006 09:38:14 -0500
Content-Disposition: inline
In-Reply-To: <20060205152120.1688bd7b.arthur.huillet@agoctrl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arthur Huillet <arthur.huillet@agoctrl.org>
Cc: linux-acpi@vger.kernel.org

> Hello,
> 
> I've recently discovered that my system didn't seem to go into C2/C3 states. In fact, they're not
> even recognized :
> 
> # cat /proc/acpi/processor/CPU0/info 
> processor id:            0
> acpi id:                 0
> bus mastering control:   no
> power management:        no
> throttling control:      no
> limit interface:         no
> 
> # cat /proc/acpi/processor/CPU0/power 
> active state:            C1
> max_cstate:              C8
> bus master activity:     00000000
> states:
>    *C1:                  type[C1] promotion[--] demotion[--] latency[000] usage[00000000]
> 
> Would you happen to know why the Cx states are not seen ? Also, isn't there supposed to be bus
> mastering control available ? 
> My mainboard is a Asus A7N8X rev 1.xx (nforce2).
> The kernels I tried with no success in whatever case are 2.4.29 and 2.6.15.2.
> Unfortunately, google doesn't seem to know much about this problem...
> 
Hi!
  Please try to do something like this:

root@porygon:~/# cat /proc/acpi/fadt |acpitbl |grep P_LVL
P_LVL2_LAT:       190
P_LVL3_LAT:       1900
If you will see more than 100 in the first line and more than 1000 in the second one, your
Cx states are blocked by BIOS. My example is from ASUS A7V8X, which may be similar.

              With regards, Pavel Troller
