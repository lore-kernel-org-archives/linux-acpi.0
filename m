From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/8] ACPI, APEI, CPER: Cleanup CPER memory error output
 format
Date: Tue, 15 Oct 2013 16:58:45 +0530
Message-ID: <525D26ED.9040602@linux.vnet.ibm.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com> <1381473166-29303-8-git-send-email-gong.chen@linux.intel.com> <20131011160208.GL5925@pd.tnic>	<20131014045500.GC12189@gchen.bj.intel.com> <20131014103616.GE4009@pd.tnic> <CA+8MBbJ9P1GVf3SCh7LMY_LH+pxQg3GWkxKMzni1b1Wyx1o8NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:48939 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757558Ab3JOL3C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2013 07:29:02 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Tue, 15 Oct 2013 16:59:00 +0530
In-Reply-To: <CA+8MBbJ9P1GVf3SCh7LMY_LH+pxQg3GWkxKMzni1b1Wyx1o8NQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>, Borislav Petkov <bp@alien8.de>
Cc: Chen Gong <gong.chen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Lance Ortiz <lance.ortiz@hp.com>

On 10/14/2013 10:42 PM, Tony Luck wrote:
> On Mon, Oct 14, 2013 at 3:36 AM, Borislav Petkov <bp@alien8.de> wrote:
>> On Mon, Oct 14, 2013 at 12:55:00AM -0400, Chen Gong wrote:
>>> Because most of data in CPER are empty or unimportant.
>>
>> It is not about whether it is important or not - the question is whether
>> changing existing functionality which someone might rely upon is a
>> problem here? Someone might be expecting exactly those messages to
>> appear in dmesg.
>
> Pulling in a couple more people who have been touching error reporting
> code in the last year or so (Hi Lance, Naveen ... feel free to drag more
> people to look at this thread).
>
> I prodded Chen Gong in to make this change because our console messages
> are way to verbose (and scary) for simple corrected errors.  There are 18
> fields in the memory error section (as of UEFI 2.4 ... more are likely to be
> added because there are issues that some of the 16-bit wide fields are too
> small to handle increased internal values in modern DIMMs).  Whether you
> print that one item per line, or a few very long lines - it is way
> more information
> than the average user will ever want or need to see.

I completely agree and I am all for bringing down the verbosity of GHES 
logs. In my testing, a corrected error event reported through GHES takes 
upwards of 10 lines, which is far too much. Perhaps a single line per 
GHES event with only a few important fields would be better?


Thanks,
Naveen

