From: "Jeff Trull" <linmodemstudent@gmail.com>
Subject: Re: no self-refresh during S3 - any debug hints?
Date: Thu, 19 Jun 2008 12:26:46 -0700
Message-ID: <685450530806191226y7319a92au40afd85111573a40@mail.gmail.com>
References: <685450530805311215lf463875g8eed40da630b4f96@mail.gmail.com>
	 <alpine.LFD.1.10.0806191437580.3040@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:36286 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbYFST0s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jun 2008 15:26:48 -0400
Received: by fk-out-0910.google.com with SMTP id 18so902552fkq.5
        for <linux-acpi@vger.kernel.org>; Thu, 19 Jun 2008 12:26:46 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806191437580.3040@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>

On Thu, Jun 19, 2008 at 12:02 PM, Len Brown <lenb@kernel.org> wrote:

>> I'm running kernel 2.6.20 on a laptop with an ATI IGP 320M Northbridge
>> and an Athlon XP.  DSDT has a _PTS but no _GTS.  I'm comfortable
>> recompiling the kernel.  Any suggestions as to how to proceed,
>> experiments to run, etc.?
>
> Start by running the upstrteam kernel -- now 2.6.26, just out of
> principle.
>
> Then, see Documentation/power/basic-pm-debugging.txt
>
> and try the options in /sys/power/pm_test

Thanks for the tips, Len.

I previously recompiled my kernel to implement a variant of Rafael's
patch from last November and was able to use it to determine that only
the actual S3 state enter/exit (i.e., the writes to the PM1*_CONTROL
in acpi_enter_sleep_state()) mattered - or, as you said, all the tests
worked.  I'd like to try 2.6.26 soon, but FWIW I did attempt 2.6.24
with the same results.

-Jeff
