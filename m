From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Inconsistent processor throttling behaviour on Clevo
	M720R/Intel T8100
Date: Mon, 04 May 2009 09:15:50 +0800
Message-ID: <1241399750.15284.33.camel@rzhang-dt>
References: <1241192597.2554.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48390 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbZEDBPg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 May 2009 21:15:36 -0400
In-Reply-To: <1241192597.2554.12.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: The Holy ettlz <theholyettlz@googlemail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2009-05-01 at 23:43 +0800, The Holy ettlz wrote:
> Hello,
> 
> I'm encountering a problem on my notebook (Clevo M720R) with an Intel
> T8100 processor whereby Core 0 is always in the T3 throttling state
> following a reboot. There is no thermal reason why this should be so,
> and it is quite annoying having to force all computationally-intensive
> tasks onto Core 1 (which is unthrottled). This is reflected in the
> benchmarks: Core 0 takes around 21s to do what Core 1 does in 12s.
> 
> In the /proc tree, 
> 
> 
> $ cat /proc/acpi/processor/CPU0/throttling 
> state count:             8
> active state:            T3
> state available: T3 to T7
> states:
>     T0:                  100%
>     T1:                  88%
>     T2:                  75%
>    *T3:                  63%
>     T4:                  50%
>     T5:                  38%
>     T6:                  25%
>     T7:                  13%
> 

please attach the output of "grep . /proc/acpi/processor/CPU*/*".
please attach the acpidump output.

> $ cat /proc/acpi/processor/CPU1/throttling 
> state count:             8
> active state:            T0
> state available: T0 to T7
> states:
>    *T0:                  100%
>     T1:                  88%
>     T2:                  75%
>     T3:                  63%
>     T4:                  50%
>     T5:                  38%
>     T6:                  25%
>     T7:                  13%  
> 
> 
> If I boot with acpi=off, there is no problem and I get full performance
> from both cores. Now, if I suspend and resume, the situation changes.
> The active state is outside the reported range:
> 

hmmm, I'll attach a debug patch after the acpidump file is available. :)

> 
> $ cat /proc/acpi/processor/CPU0/throttling 
> state count:             8
> active state:            T8
> state available: T3 to T7
> states:
>     T0:                  100%
>     T1:                  88%
>     T2:                  75%
>     T3:                  63%
>     T4:                  50%
>     T5:                  38%
>     T6:                  25%
>     T7:                  13%
> 
> $ cat /proc/acpi/processor/CPU1/throttling 
> state count:             8
> active state:            T8
> state available: T0 to T7
> states:
>     T0:                  100%
>     T1:                  88%
>     T2:                  75%
>     T3:                  63%
>     T4:                  50%
>     T5:                  38%
>     T6:                  25%
>     T7:                  13%
> 
> 
> I get full performance from both cores in this case.
> 
> Any suggestions, and what additional info would be useful? In the
> meantime, is there any way to disable throttling without taking out the
> rest of ACPI and thermal so that I can get my notebook's full
> performance from the outset?
> 
the answer is "no" so far.
But I think it's a good idea.
patch will be attached later.

thanks,
rui

