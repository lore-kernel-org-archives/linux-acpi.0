From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.29 acpi regression: acpi_ex_extract_from_field -- div by
 zero
Date: Thu, 19 Mar 2009 17:06:41 +0100
Message-ID: <49C26D91.3010904@gmail.com>
References: <49BCDCAA.8040309@gmail.com>	 <d3f22a0903152046m891dc0aq6ca01eed32a9eb32@mail.gmail.com> <1237174943.4193.37.camel@minggr.sh.intel.com> <49BE7EE6.3070107@gmail.com> <49C0AC13.7040107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:47823 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZCSQGq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2009 12:06:46 -0400
In-Reply-To: <49C0AC13.7040107@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: robert.moore@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel <linux-kernel@vger.kernel.org>, torvalds@linux-foundation.org

On 18.3.2009 09:08, Jiri Slaby wrote:
> On 16.3.2009 17:31, Jiri Slaby wrote:
>> On 16.3.2009 04:42, Lin Ming wrote:
>>>> sometimes, when booting up/resuming from disk, I get an oops[1].
>>>>
>>>> obj_desc->common_field.access_bit_width is zero, but even after the
>>>> loop. Division before the loop is apparently OK.
>>>
>>> Would please try below debug patch to see which region filed is
>>> accessed?
>
> I'm confused, but keep trying.

Got it again. obj_desc->common_field.node is martian too (0x4000000), so 
the added acpi_get_name dies:
http://www.fi.muni.cz/~xslaby/sklad/panics/acpi_oops1.png

Whole common_field seems to be mangled. Ideas?
