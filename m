From: "Andras Lorincz" <andras.lorincz@gmail.com>
Subject: Re: Help with fan on fujitsu siemens
Date: Fri, 16 Feb 2007 20:25:40 +0200
Message-ID: <a21d779b0702161025v275a2890ke243bdf4957a96d8@mail.gmail.com>
References: <a21d779b0702152346l35b83cadw2d2b4e9f3939da7e@mail.gmail.com>
	 <200702161202.43455.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:62718 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946194AbXBPSZp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Feb 2007 13:25:45 -0500
Received: by wr-out-0506.google.com with SMTP id i21so1125900wra
        for <linux-acpi@vger.kernel.org>; Fri, 16 Feb 2007 10:25:44 -0800 (PST)
In-Reply-To: <200702161202.43455.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On 2/16/07, Len Brown <lenb@kernel.org> wrote:
> On Friday 16 February 2007 02:46, Andras Lorincz wrote:
>
> > and the output of cat /proc/acpi/thermal_zone/*/* is:
> >
> > cooling mode:   active
> > polling frequency:       30 seconds
> > state:                   ok
> > temperature:             49 C
> > critical (S5):           105 C
> > passive:                 79 C: tc1=3 tc2=1 tsp=80
> > devices=0xf7e9c720
> > active[0]:               65 C: devices=0xc17e4d9c
> > active[1]:               55 C: devices=0xc17e4d38
> >
> > Some remarks:
> >
> >  - the polling frequency is not set by default so I
> > run a script on startup which sets the polling
> > frequency to 30 secs
>
> if you don't set polling frequency it is 0?
> Does anything not work in that case?
>
> That is the ideal case -- as polling frequency 0
> means that the system is event-driven.
>
> If you need to enable polling b/c something isn't working,
> 3 seconds may be more prudent than 30 seconds.
>
> >  - the state reported by
> > /proc/acpi/thermal_zone/THRM/state changes correctly
> > according to changing temperatures but it is not in
> > accordance with the real state of the cooler.
>
> Do you have /proc/acpi/fan/*/* files?
> What do they say?
>
> -Len
>

Now I'm playing around with 2.6.20. If I don't set the polling
frequency at boot time then cat
/proc/acpi/thermal_zone/polling_frequency gives me:

<polling disabled>

I also tried setting the polling frequency to 0 but doesn't help. ls
/proc/acpi/fan gives me:

FAN0  FAN1

and ls /proc/acpi/fan/FAN0 and ls /proc/acpi/fan/FAN1 give me:

state
