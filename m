From: Thomas Lindroth <thomas.lindroth@gmail.com>
Subject: Re: Problem: ACPI related soft lockup on Fujitsu-Siemens AMILO Si
 2636
Date: Thu, 09 Oct 2008 09:46:40 +0200
Message-ID: <48EDB6E0.8000609@gmail.com>
References: <48E9F51A.4080107@gmail.com> <48EC5F4B.8020009@gmail.com> <alpine.LFD.1.10.0810082144370.3041@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:1538 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbYJIHqr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 03:46:47 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1756883nfc.21
        for <linux-acpi@vger.kernel.org>; Thu, 09 Oct 2008 00:46:45 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0810082144370.3041@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Len Brown wrote:
> 
> On Wed, 8 Oct 2008, Thomas Lindroth wrote:
> 
>> I've done some debugging of this problem myself and reached some conclusions.
>>
>> I tried activating the ACPI_LV_INFO ACPI debug mode and observed what happens
>> when the system is under load. I saved one trace and put it in the file
>> acpi_debug_log at http://www.cyd.liu.se/~tholi945/acpi-bug-2008-10-06/
>>
>> When the temp goes over the ACPI passive trip point the processor gets
>> throttled. It usually never goes over T4 before the temp falls below the
>> passive temp but sometimes it reaches the highest T7. If it reach T7 the
>> next call to _TMP or _L18 never returns. I've confirmed this by running
>> echo T7 > /proc/acpi/processor/CPU*/throttling and then tried to read
>> from /proc/acpi/thermal_zone/TZ00/temperature and it fails in the same way.
>>
>> I've tried activating the ACPI_LV_PARSE ACPI debug mode, enter T7 and read
>> from temp. I put the result of that in the trace_debug file at the same adress.
>>
>> The AML call chain looks like this _TMP -> PMRD -> RCMD -> WIBF
>> WIBF always returns 1 causing the interpreter to get stuck in the while
>> loop in PMRD.
>>
>> While (RCMD (0x80, Local0))
>> {
>>     Noop
>>     Noop
>>     Store (PMUC, Local5)
>>     If (And (Local5, One, Local2))
>>     {
>>         Store (PMUD, Local5)
>>     }
>> }
>>
>> I don't really understand how AML code works so I can't get much further than
>> this.
>>
>> I did not experience complete lockups in Windows but I did notice some minor
>> stalls. Maybe the Windows AML parser can break infinite loops or maybe the
>> stalls is a normal part of the Windows experience. I tried to boot with the
>> acpi_osi=Linux option active but it didn't make any difference.
> 
> please send the output from
> 
> grep . /proc/acpi/thermal_zone/*/*

/proc/acpi/thermal_zone/TZ00/cooling_mode:<setting not supported>
/proc/acpi/thermal_zone/TZ00/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/TZ00/state:state:                   ok
/proc/acpi/thermal_zone/TZ00/temperature:temperature:             53 C
/proc/acpi/thermal_zone/TZ00/trip_points:critical (S5):           94 C
/proc/acpi/thermal_zone/TZ00/trip_points:passive:                 86 C: tc1=0 tc2=10 tsp=50 devices=CPU0 CPU1
/proc/acpi/thermal_zone/TZ01/cooling_mode:0 - Active; 1 - Passive
/proc/acpi/thermal_zone/TZ01/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/TZ01/state:state:                   ok
/proc/acpi/thermal_zone/TZ01/temperature:temperature:             27 C
/proc/acpi/thermal_zone/TZ01/trip_points:critical (S5):           94 C
/proc/acpi/thermal_zone/TZ01/trip_points:passive:                 78 C: tc1=0 tc2=10 tsp=2 devices=CPU0 CPU1
/proc/acpi/thermal_zone/TZ01/trip_points:active[0]:               80 C: devices=FAN1
/proc/acpi/thermal_zone/TZ01/trip_points:active[1]:               67 C: devices=FAN0
/proc/acpi/thermal_zone/TZ01/trip_points:active[2]:               55 C: devices=FAN2

I'm not sure why there are two TZ for the CPUs.

> from the log, it looks like your _PSV returns 3520, or 352.0K or 78C
> and that is reasonable,  but note that one option you have to
> workaround is to either disable or that trip point via

TZ00._PSV returns 3520 or 3590 depending on if the temp is above or below
the previous _PSV value.

> thermal.psv=-1
> or
> thermal.psv=100
> for example.
> 
> But the bigger question is why the temperature is hitting 78 --
> which is quite hot.
> Grep above will tell us if there is ACPI fan control, but I don't
> see any in the logs.  Can you hear the fans spinning?
> Do they go faster when the system heats up?
> do they work better after you blow the dust our of the fan?

The fans work and spin up under load. TZ01 got fan control but I never
see anything about TZ01 in the logs so I guess the fans are controlled by
the BIOS. The computer is new and not dusty.


/Thomas Lindroth
