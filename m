From: Alan Jenkins <aj504@cs.york.ac.uk>
Subject: Re: [Bug #10724] ACPI: EC: GPE storm detected, disabling EC GPE
Date: Sat, 19 Jul 2008 05:22:18 -0700 (PDT)
Message-ID: <50b515e4-6cd1-4b18-93e3-ecfab5925f02@34g2000hsf.googlegroups.com>
References: <aPfh5-7kW-5@gated-at.bofh.it> <aPfhe-7kW-31@gated-at.bofh.it>
	<aQUio-2qG-25@gated-at.bofh.it> <aR0nM-6kd-15@gated-at.bofh.it>
	<aR3vi-3MV-15@gated-at.bofh.it> <aR4Ur-6c7-27@gated-at.bofh.it>
	<aReqy-5vm-1@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2122.google.com ([74.125.46.26]:8274 "EHLO
	yw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbYGSMWT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jul 2008 08:22:19 -0400
Received: by yw-out-2122.google.com with SMTP id 1so628653ywp.1
        for <linux-acpi@vger.kernel.org>; Sat, 19 Jul 2008 05:22:18 -0700 (PDT)
In-Reply-To: <aReqy-5vm-1@gated-at.bofh.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Fabio Comolli wrote:
> Hi Alex.
> Well, I read the bug report but still can't understand why in any
> kernels < 2.6.26 I don't have any problems with battery reports and in
> 2.6.26 as soon as the message appears g-p-m starts to behave
> incorrectly.
>
> Anyway, I got back to 25.11 for now, if you have any other workarounds
> for me to test please let me know.

Hi Fabio.

I wrote some GPE fixes for my Asus laptop and they need some wider
testing :-).  I think I found why we get GPE storms and how to deal
with them.

I posted them on the lists a series of three patches, but I neglected
to CC any potential testers.  For convenience I squished them into a
single patch and posted them in Bugzilla.

My bug: <http://bugzilla.kernel.org/show_bug.cgi?id=11089>
Patch: <http://bugzilla.kernel.org/attachment.cgi?
id=16886&action=view>

The risky part of the fixes removes the GPE interrupt storm check and
the GPE polling mode. So you won't see the "disabling EC GPE" message,
and I'm hoping this will stop g-p-m  misbehaving for you.

I'm not sure what could happen if it's broken somehow :-).  If you
have ACPI hotkeys (i.e. running acpi_listen shows events when you
press hotkeys), please check they still work.  If not, you should have
at least one button that generates an ACPI event - the power button.
So it would be great if you could check the power button still works
as normal.  (On my computer, g-p-m handles the power button and pops
up a logout/shutdown prompt).

Thanks
Alan
