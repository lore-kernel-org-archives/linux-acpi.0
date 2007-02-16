From: Len Brown <lenb@kernel.org>
Subject: Re: Help with fan on fujitsu siemens
Date: Fri, 16 Feb 2007 12:02:43 -0500
Message-ID: <200702161202.43455.lenb@kernel.org>
References: <a21d779b0702152346l35b83cadw2d2b4e9f3939da7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55986 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964989AbXBPREC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Feb 2007 12:04:02 -0500
In-Reply-To: <a21d779b0702152346l35b83cadw2d2b4e9f3939da7e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andras Lorincz <andras.lorincz@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Friday 16 February 2007 02:46, Andras Lorincz wrote:

> and the output of cat /proc/acpi/thermal_zone/*/* is:
> 
> cooling mode:   active
> polling frequency:       30 seconds
> state:                   ok
> temperature:             49 C
> critical (S5):           105 C
> passive:                 79 C: tc1=3 tc2=1 tsp=80
> devices=0xf7e9c720
> active[0]:               65 C: devices=0xc17e4d9c
> active[1]:               55 C: devices=0xc17e4d38
> 
> Some remarks:
> 
>  - the polling frequency is not set by default so I
> run a script on startup which sets the polling
> frequency to 30 secs

if you don't set polling frequency it is 0?
Does anything not work in that case?

That is the ideal case -- as polling frequency 0
means that the system is event-driven.

If you need to enable polling b/c something isn't working,
3 seconds may be more prudent than 30 seconds.

>  - the state reported by
> /proc/acpi/thermal_zone/THRM/state changes correctly
> according to changing temperatures but it is not in
> accordance with the real state of the cooler.

Do you have /proc/acpi/fan/*/* files?
What do they say?

-Len
