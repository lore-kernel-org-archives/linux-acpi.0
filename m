From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.29 acpi regression: acpi_ex_extract_from_field -- div by
 zero
Date: Wed, 18 Mar 2009 09:08:51 +0100
Message-ID: <49C0AC13.7040107@gmail.com>
References: <49BCDCAA.8040309@gmail.com>	 <d3f22a0903152046m891dc0aq6ca01eed32a9eb32@mail.gmail.com> <1237174943.4193.37.camel@minggr.sh.intel.com> <49BE7EE6.3070107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754477AbZCRIJR@vger.kernel.org>
In-Reply-To: <49BE7EE6.3070107@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: robert.moore@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel <linux-kernel@vger.kernel.org>, torvalds@linux-foundation.org
List-Id: linux-acpi@vger.kernel.org

On 16.3.2009 17:31, Jiri Slaby wrote:
> On 16.3.2009 04:42, Lin Ming wrote:
>>> sometimes, when booting up/resuming from disk, I get an oops[1].
>>>
>>> obj_desc->common_field.access_bit_width is zero, but even after the
>>> loop. Division before the loop is apparently OK.
>>
>> Would please try below debug patch to see which region filed is
>> accessed?
>
> Yes, except the fact, we wouldn't see anything :) -- I'll add inside the
> if a return statement or something to disallow the oops to flood screen.
>
> Also, it doesn't happen regularly. Mostly several first tries after cold
> start. I hope this is a regression and not a HW problem, but it emerged
> after switching to 2.6.29-*, I will keep you informed.

Hmm, I didn't see it with rc8 and this patch applied so far (no 'ACPI 
Debug' in dmesg). Also I don't see anything changed within drivers/acpi/ 
et al. between rc7 and rc8. Maybe the timing changed somewhere else... 
I'm confused, but keep trying.
