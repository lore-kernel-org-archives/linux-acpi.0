From: Len Brown <lenb@kernel.org>
Subject: Re: Fwd: [patch] ACPI: fix cpufreq regression
Date: Wed, 24 Jan 2007 00:07:56 -0500
Message-ID: <200701240007.56413.lenb@kernel.org>
References: <200701162213.14875.lenb@kernel.org> <20070117142522.GA6245@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52887 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965527AbXAXFJV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Jan 2007 00:09:21 -0500
In-Reply-To: <20070117142522.GA6245@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, linux-thinkpad@linux-thinkpad.org

On Wednesday 17 January 2007 09:25, you wrote:
> On Tue, 16 Jan 2007, Len Brown wrote:
> > nobody else with a T60 noticed this since November?
> 
> It might be a good idea to Cc linux-thinkpad@linux-thinkpad.org 

okay, added to cc:-)

> OTOH, there are reports that the new BIOSes have removed functionality from
> the DSDT that allowed multiple cores to work in different clock speeds, so
> people may have overlooked the bug Ingo worked around...

Intel's dual core products (used in Thinkpads) don't allow the cores to
run at different speeds anyway.  They use hardware coordination
to set the package to the MAX of the requested frequencies.

The reason is that there is a single voltage to the package,
so if you have to keep it high to run one core fast -- you
might as well run the other core fast also.

Now there is some fine print to this...

There is a bit the BIOS can set to disable HW coordination.
But if it does so, then it needs to provide  some ACPI info
telling the kernel to coordination speeds in software.
(ie. the last request from either core will set the P-state of
the entire package -- so you want to do a MAX of the requests
in software and then do a single request to either core to
implement a change).

So if HW coordination is erroneously disabled and the BIOS
neglects to tell us, then the entire package P-state will flip around
depending on the last request from either core.
One example of a failure would be if core0 requests fast,
and then core1 requests slow, then core0 runs slow when
it wanted to run fast.

I'm not aware of thinkpads having this bug -- but IIR a Sossaman
server board from Intel actually had it -- so who knows who else may...

cheers,
-Len
