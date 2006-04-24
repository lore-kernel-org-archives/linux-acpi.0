From: Thomas Renninger <trenn@suse.de>
Subject: Re: LG-81 kernel fault in ACPI when over-temperature
Date: Mon, 24 Apr 2006 13:01:15 +0200
Message-ID: <1145876475.3797.20.camel@queen.suse.de>
References: <20060423162841.A3B3512ED4@bluewhale.planbit.co.uk>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:63120 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750727AbWDXLBO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Apr 2006 07:01:14 -0400
In-Reply-To: <20060423162841.A3B3512ED4@bluewhale.planbit.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roger Lucas <roger@planbit.co.uk>
Cc: linux-acpi@vger.kernel.org

On Sun, 2006-04-23 at 17:28 +0100, Roger Lucas wrote:
> All,
> 
> I am setting up an Abit LG-81 motherboard with a 2.8GHz Inter Celeron CPU.
> The motherboard uses the W83627EHG sensors chip for fan, voltage and thermal
> monitoring.
> 
> I have download, compiled and installed the latest 2.6.16.9 kernel from
> kernel.org and all seemed to be OK.  I could read the sensors information
> from the W83627EHG chip using the lm-sensors system with its W83627EHF
> driver (which is compatible, the 'EHG is just a lead-free variant) and the
> "sensors" utility.
> 
> The current temperatures on the board are:
> 	SYS	31C
> 	CPU	48C
> 	PSU	43C
> 
> All seems fine.  I then tweaked the sensors.conf file to change the fan
> limts and temperature limits to check the alarms would get set correctly.
> When I artifically created a CPU over-temperature condition by setting the
> CPU high temperature threshold at just 40C, two things happended.  Firstly,
> I got a kernel dump for one of the ACPI processes.  Secondly, the machine
> ran unbelievably slowly until I changed the CPU high temperature limit back
> to a more reasonable 65C.
> 
> Can anyone shed any light on what is happening here ?
> 
You might want to have a look at that one:
http://bugzilla.kernel.org/show_bug.cgi?id=6315

       Thomas


