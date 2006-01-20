From: "Brown, Len" <len.brown@intel.com>
Subject: RE: High pitched sound with 2.6.15-ck1 --  Need your help
Date: Fri, 20 Jan 2006 04:36:14 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CF07@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr14.intel.com ([192.55.52.68]:37037 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750711AbWATJgl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2006 04:36:41 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vasileios Gkanis <gkanis@cems.umn.edu>
Cc: linux-acpi@vger.kernel.org

>I did try to change HZ to value lower than 1000, 
>i.e. 250, but the sound was still audible.

try 100

>By comparing the outputs from the 
>two kernels, I hear the sound because on the 2.6.15 kernel the 
>system enters 
>the C4 state, which means lower consumption (I think so).

Right, C4 saves more power than C3, which saves more than C2 etc.
However, there is diminishing returns the deeper you go.
idle=poll vs C1 is a big difference, but the difference
between C3 and C4 is quite small.

you can run on battery and watch the drain rate in /proc/acpi/battery
if you want to get a rought idea...

note, however, that these states are only entered
when the system is idle.

>When my system is 
>in the C2 state I do not hear this sound (2.6.13 kernel). 
>Another thing that I found out is that on the 2.6.15 kernel 
>the system changes 
>from one state to the other depending on the CPU overload (I 
>believe so).

the current algorithm is that the system promotes idle
to a deeper C-state if it doesn't get kicked out of idle
too frequently.

>
>Now, if I change the value of  
>/sys/module/processor/parameters/max_cstate to 
>3, will the system stay at this C-state for ever or will it 
>dynamically 
>switch from one state to another?

it will still be dynamic.  in this case it will get to C3
but will not attempt to enter C4.

>Regarding the "look at the rate between a couple of timed snapshots 
>of /proc/interrupts to see what you're getting in practice.", 
>what rates 
>should I be looking at?

irq0

cheers,
-len
