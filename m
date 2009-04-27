From: Kaushik Barde <Kaushik_Barde@Phoenix.com>
Subject: RE: s2ram on Lenovo X300 is broken
Date: Sun, 26 Apr 2009 17:47:56 -0700
Message-ID: <6D80BDFB1A1FA74DA476417C24C452A102495C837E@scl-exch2k7.phoenix.com>
References: <6D80BDFB1A1FA74DA476417C24C452A102495C8361@scl-exch2k7.phoenix.com>
 <200904270112.28813.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from scl-exch2k.phoenix.com ([216.148.212.222]:37138 "EHLO
	scl-exch2k.phoenix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbZD0Arw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Apr 2009 20:47:52 -0400
In-Reply-To: <200904270112.28813.rjw@sisk.pl>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

I tried with both stable 2.6.28.9 and 2.6.29.1, and yes, issue is reproducible.

On 28.9, if move AP (disable_nonboot_cpu) before suspend_console followed by a msleep(500), and keep it seem to work OK. But I don't like it.

On 29.1, looks like order is changed again, that solution does not work.

Either-way, its stopping somewhere in __cpu_down, I need to track it down.

-Kaushik

-----Original Message-----
From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
Sent: Sunday, April 26, 2009 4:12 PM
To: Kaushik Barde
Cc: linux-acpi@vger.kernel.org
Subject: Re: s2ram on Lenovo X300 is broken

On Sunday 26 April 2009, Kaushik Barde wrote:
> I am using stable-2.6.29.1 on Lenovo X300.
> 
> echo mem > /sys/power/state works if I disable AP core using echo 0 > /sys/devices/system/cpu/cpu1/online.
> 
> With SMP, first s3 cycle goes through, subsequent suspend does not work.
> 
> Is this a known issue with CPU_HOTPLUG or suspend re-ordering code?

Similar symptoms have been reported, but the previous reporter did not connect
them with the CPU hotplugging.

The issue isn't actually known and suspend-resume works on many SMP systems.

Is the problem reproducible with the current mainline kernel?

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
