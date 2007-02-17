From: "Andras Lorincz" <andras.lorincz@gmail.com>
Subject: Re: Help with fan on fujitsu siemens
Date: Sat, 17 Feb 2007 10:12:54 +0200
Message-ID: <a21d779b0702170012g523fe950vaec79ef2190aecdb@mail.gmail.com>
References: <a21d779b0702152346l35b83cadw2d2b4e9f3939da7e@mail.gmail.com>
	 <200702161202.43455.lenb@kernel.org>
	 <a21d779b0702161025v275a2890ke243bdf4957a96d8@mail.gmail.com>
	 <200702161658.37249.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:12770 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946440AbXBQIM4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Feb 2007 03:12:56 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1118794nze
        for <linux-acpi@vger.kernel.org>; Sat, 17 Feb 2007 00:12:55 -0800 (PST)
In-Reply-To: <200702161658.37249.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On 2/16/07, Len Brown <lenb@kernel.org> wrote:
> On Friday 16 February 2007 13:25, you wrote:
> > On 2/16/07, Len Brown <lenb@kernel.org> wrote:
> > > On Friday 16 February 2007 02:46, Andras Lorincz wrote:
> > >
> > > > and the output of cat /proc/acpi/thermal_zone/*/* is:
> > > >
> > > > cooling mode:   active
> > > > polling frequency:       30 seconds
> > > > state:                   ok
> > > > temperature:             49 C
> > > > critical (S5):           105 C
> > > > passive:                 79 C: tc1=3 tc2=1 tsp=80
> > > > devices=0xf7e9c720
> > > > active[0]:               65 C: devices=0xc17e4d9c
> > > > active[1]:               55 C: devices=0xc17e4d38
> > > >
> > > > Some remarks:
> > > >
> > > >  - the polling frequency is not set by default so I
> > > > run a script on startup which sets the polling
> > > > frequency to 30 secs
> > >
> > > if you don't set polling frequency it is 0?
> > > Does anything not work in that case?
> > >
> > > That is the ideal case -- as polling frequency 0
> > > means that the system is event-driven.
> > >
> > > If you need to enable polling b/c something isn't working,
> > > 3 seconds may be more prudent than 30 seconds.
> > >
> > > >  - the state reported by
> > > > /proc/acpi/thermal_zone/THRM/state changes correctly
> > > > according to changing temperatures but it is not in
> > > > accordance with the real state of the cooler.
> > >
> > > Do you have /proc/acpi/fan/*/* files?
> > > What do they say?
> > >
> > > -Len
> > >
> >
> > Now I'm playing around with 2.6.20. If I don't set the polling
> > frequency at boot time then cat
> > /proc/acpi/thermal_zone/polling_frequency gives me:
> >
> > <polling disabled>
> >
> > I also tried setting the polling frequency to 0 but doesn't help. ls
> > /proc/acpi/fan gives me:
>
> right, polling frequency of 0 disables polling.
> when polling is disabled, the thermal system is event driven.
>
> why do you want to enable polling -- what is not working
> when it is disabled?
>
> > FAN0  FAN1
> >
> > and ls /proc/acpi/fan/FAN0 and ls /proc/acpi/fan/FAN1 give me:
> >
> > state
>
> s/ls/cat/
>
> -Len
>
>

The CPU cooler doesn't start spinning when temperature raises,
although the output of `cat /proc/acpi/thermal_zone/THRM/state`
changes according to the temperature, so if temperature is less than
55 then `cat /proc/acpi/thermal_zone/THRM/state` returns state ok, if
temperature is between 55 and 65 then it returns state active[1] and
finally if temperature is higher then 65, `cat
/proc/acpi/thermal_zone/THRM/state` returns active[0] but the cpu
cooler won't ever start. If I issue the commands `echo 3 >
/proc/acpi/fan/FAN0/state` and `echo 0 > /proc/acpi/fan/FAN0/state`
then the cooler starts but then never stops even if the temperature
falls bellow 55 and manually also can be stopped by `echo 3 >
/proc/acpi/fan/FAN0/state`.
The same situation with polling set or not.
