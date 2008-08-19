From: "Karthik Gopalakrishnan" <karthik.g.krishnan@gmail.com>
Subject: Re: Thinkpad X60s power usage on battery - Windows/Linux comparison
Date: Mon, 18 Aug 2008 23:12:47 -0400
Message-ID: <5e0a1fd80808182012pc654ecdu288a37929ff57404@mail.gmail.com>
References: <8ccf2e9c0808181554o930f235maa79bdb365cd808d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.180]:24595 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbYHSDMt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Aug 2008 23:12:49 -0400
Received: by ik-out-1112.google.com with SMTP id c28so2540838ika.5
        for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2008 20:12:47 -0700 (PDT)
In-Reply-To: <8ccf2e9c0808181554o930f235maa79bdb365cd808d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vedran Rodic <vrodic@gmail.com>
Cc: linux-acpi@vger.kernel.org

What sort of a Graphics Accelerator does the system have. I faced a
similar problem on my Laptop & I narrowed down the issue to a bad
driver for my NVidia Graphics card. Once I fixed that, the battery
life on Linux matched up to that on Windows XP.

Regards,
Karthik

On Mon, Aug 18, 2008 at 6:54 PM, Vedran Rodic <vrodic@gmail.com> wrote:
> I've decided to write up something that I've been aware of for some time,
> but that didn't really bother me that much, since I've been waiting for the
> situation to improve quietly.
>
> The basic observation is: My trusty X60s uses less power when on battery
> on Windows than on Linux.
>
> This situation hasn't changed significantly despite the appearance of powertop
> to trim the number of processor wakeups per second thus enabling the
> processor to stay in deep sleep states for longer time and improvements in
> the Xorg intel video driver.
>
> I get arround 3.3 wakeups per second minimally when
> my Xorg/KDE is not active, with laptop using 9.1 W (as reported by
> powertop). When Xorg/KDE is running, with one konsole to monitor usage with
> powertop, I get arround 13 wakeups per second and power usage of 9.4 W. All
> the measurements are done with LCD brightness on the lowest level, wireless
> interfaces disabled, and all power saving features that powertop can detect
> enabled. Processor is in C3 state 99.9% of the time. I tried removing
> various driver modules that I didn't use at the time (irda, pcmcia,
> ethernet, sound), but no change.
>
> Windows power monitoring tool from Lenovo reports power usage of 6.5 W under
> the same LCD brightness level and with wireless disabled.
>
> This was tested under Linux 2.6.26-rc8 (some git level after the rc8
> release). Older
> versions of the kernel didn't show any statistically significant
> differences. powertop
> is version 1.10, and the software used under Windows XP
> is Lenovo ThinkVantage Power Manager.
>
> Since I doubt that Windows XP has less wakeups per second than my
> Linux setup, I guess
> there are still a couple of IBM specific power saving
> registers/controls that can be
> tweaked so that the laptop uses less power. Does anybody have any idea
> on what would that
> be? Any friendly contacts at lenovo?
>
> Thanks
> Vedran Rodic
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
