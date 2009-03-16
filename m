From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.29 acpi regression: acpi_ex_extract_from_field -- div by
 zero
Date: Mon, 16 Mar 2009 17:31:34 +0100
Message-ID: <49BE7EE6.3070107@gmail.com>
References: <49BCDCAA.8040309@gmail.com>	 <d3f22a0903152046m891dc0aq6ca01eed32a9eb32@mail.gmail.com> <1237174943.4193.37.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f175.google.com ([209.85.218.175]:54813 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbZCPQbj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 12:31:39 -0400
In-Reply-To: <1237174943.4193.37.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: robert.moore@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel <linux-kernel@vger.kernel.org>, torvalds@linux-foundation.org

On 16.3.2009 04:42, Lin Ming wrote:
>> sometimes, when booting up/resuming from disk, I get an oops[1].
>>
>> obj_desc->common_field.access_bit_width is zero, but even after the
>> loop. Division before the loop is apparently OK.
>
> Would please try below debug patch to see which region filed is
> accessed?

Yes, except the fact, we wouldn't see anything :) -- I'll add inside the 
if a return statement or something to disallow the oops to flood screen.

Also, it doesn't happen regularly. Mostly several first tries after cold 
start. I hope this is a regression and not a HW problem, but it emerged 
after switching to 2.6.29-*, I will keep you informed.

Thanks.
