From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/8] ACPI, APEI, CPER: Cleanup CPER memory error output
 format
Date: Tue, 15 Oct 2013 17:11:59 +0530
Message-ID: <525D2A07.6080201@linux.vnet.ibm.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com> <1381473166-29303-8-git-send-email-gong.chen@linux.intel.com> <20131011160208.GL5925@pd.tnic>	<20131014045500.GC12189@gchen.bj.intel.com> <20131014103616.GE4009@pd.tnic> <CA+8MBbJ9P1GVf3SCh7LMY_LH+pxQg3GWkxKMzni1b1Wyx1o8NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:37872 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088Ab3JOLmR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2013 07:42:17 -0400
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Tue, 15 Oct 2013 17:12:14 +0530
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

If so, how will disabling dmesg output and switching to a trace event 
help? The user-space program will still break unless they add support 
for that trace event, right?

I'm not sure if we actually provide guarantees w.r.t kernel log 
messages. The issue in this specific scenario is the sheer verbosity of 
the log messages. I personally feel that it will be good if we can 
simplify the log output.

Thanks,
Naveen

