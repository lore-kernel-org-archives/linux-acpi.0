From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: 2.6.25 regression: powertop says 120K wakeups/sec
Date: Fri, 28 Mar 2008 16:51:57 -0700
Message-ID: <924EFEDD5F540B4284297C4DC59F3DEEC83EF5@orsmsx423.amr.corp.intel.com>
References: <20080322202454.9D69DCC0EF@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <200803281509.23107.david-b@pacbell.net> <20080328225604.GA7136@linux-os.sc.intel.com> <200803281636.04029.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16634 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756330AbYC1X4b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Mar 2008 19:56:31 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200803281636.04029.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

 

>-----Original Message-----
>From: David Brownell [mailto:david-b@pacbell.net] 
>Sent: Friday, March 28, 2008 4:36 PM
>To: Pallipadi, Venkatesh
>Cc: Andrew Morton; linux-kernel@vger.kernel.org; Rafael J. 
>Wysocki; linux-acpi@vger.kernel.org; Len Brown
>Subject: Re: 2.6.25 regression: powertop says 120K wakeups/sec
>
>On Friday 28 March 2008, Venki Pallipadi wrote:
>
>> I think I figured out the bug...
>> 
>> Can you try the below patch and confirm that it works (over 
>upstream - ignore
>> the earlier revert patch I sent to you).
>
>That seems to do the job ... thanks!  One more regression
>fixed, it feels like RC7 is almost done. :)
>
>It still says odd things about C0 vs C1 though:  powertop
>says 100% of the time is in C0, but this patch would seem
>to be irrelevant if that were true.
>

Great!

100% C0 is not real reading. The problem behind that is there is no wat
to measure exact C1 idle time with halt based C1s. So, we always used to
report 0 time in acpi and that's what is reported by powertop.
This should be fixed in future, as we now export approx time (even
though not exact) in cpuidle and powertop is about to start using it.

Thanks,
Venki
