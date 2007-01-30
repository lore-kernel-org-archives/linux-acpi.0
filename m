From: emisca <emisca.ml@gmail.com>
Subject: Re: Fan speeds on HP nc6400 and nc8430
Date: Tue, 30 Jan 2007 21:22:20 +0100
Message-ID: <414cba4e0701301222l52691fe3gbbde5aa62d7b192d@mail.gmail.com>
References: <45B100A0.40305@gmail.com>
	 <C3FA62B1A90D7440B9B6C7C31895994F03663675@zadbn02100.vodacom.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:20847 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbXA3UWX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jan 2007 15:22:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1639851uga
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jan 2007 12:22:21 -0800 (PST)
In-Reply-To: <C3FA62B1A90D7440B9B6C7C31895994F03663675@zadbn02100.vodacom.corp>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pieter De Wit <Pieter.DeWit@vodacom.co.za>
Cc: linux-acpi@vger.kernel.org

I have noticed that disabling cpu frequency scaling doesn't matter too
much on my core 2 duo processor. On normal usage the temperature is
50=B0 with fixed 1.66mhz and tz4=3D30 (fan speed), and 45=B0 using
cpufreq-ondemand (tz4=3D30). This is not a big difference...

2007/1/29, Pieter De Wit <Pieter.DeWit@vodacom.co.za>:
> Hi Guys,
>
> I tried the suggestion below and it didn't seem to change anything - =
I
> even set the same trip points to TZ1. The fans still seem to spin fas=
ter
> in Linux compared to Windows. Then the other issue is that I can't
> switch a fan off once I force it on.
>
> Thanks,
>
> Pieter
>
>
> Show:
> cat /proc/acpi/thermal_zone/TZ0/trip_points
>
> or change TZ0 to TZ1
>
> For many HP notebooks first trip point is to low. To change manually,
> for example:
>
> echo "105:100:100:78:70:60:50" > /proc/acpi/thermal_zone/TZ0/trip_poi=
nts
> echo 10  > /proc/acpi/thermal_zone/TZ0/polling_frequency
>
> Then I have:
> maciek@rutek:~$ cat /proc/acpi/thermal_zone/TZ0/trip_points
> critical (S5):           105 C
> active[0]:               78 C: devices=3D0xcf7aea40
> active[1]:               70 C: devices=3D0xcf7ae9dc
> active[2]:               60 C: devices=3D0xcf7ae98c
> active[3]:               50 C: devices=3D0xcf7ae93c
>
> maciek@rutek:~$ cat /proc/acpi/thermal_zone/TZ0/polling_frequency
> polling frequency:       10 seconds
>
> --
> Maciej Rutecki <maciej.rutecki@gmail.com> http://www.unixy.pl LTG -
> Linux Testers Group
> (http://www.stardust.webpages.pl/ltg/wiki/)
>
> "This e-mail is sent on the Terms and Conditions that can be accessed=
 by Clicking on this link http://www.vodacom.co.za/legal/email.jsp "
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
