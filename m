From: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: Re: [Bug #10724] ACPI: EC: GPE storm detected, disabling EC GPE
Date: Sun, 20 Jul 2008 09:26:18 +0200
Message-ID: <b637ec0b0807200026j3a2694acw7c964e1c23a7b57c@mail.gmail.com>
References: <aPfh5-7kW-5@gated-at.bofh.it> <aPfhe-7kW-31@gated-at.bofh.it>
	 <aQUio-2qG-25@gated-at.bofh.it> <aR0nM-6kd-15@gated-at.bofh.it>
	 <aR3vi-3MV-15@gated-at.bofh.it> <aR4Ur-6c7-27@gated-at.bofh.it>
	 <aReqy-5vm-1@gated-at.bofh.it>
	 <50b515e4-6cd1-4b18-93e3-ecfab5925f02@34g2000hsf.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:39816 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbYGTH0T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Jul 2008 03:26:19 -0400
Received: by yw-out-2324.google.com with SMTP id 9so326508ywe.1
        for <linux-acpi@vger.kernel.org>; Sun, 20 Jul 2008 00:26:18 -0700 (PDT)
In-Reply-To: <50b515e4-6cd1-4b18-93e3-ecfab5925f02@34g2000hsf.googlegroups.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <aj504@cs.york.ac.uk>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Well, I read in another thread that there are some issues with this
patches. Anyway, I'm now running .26 with your patch since yesterday,
tried 3 suspend/resume cycles and 2 hibernate/resume cycles and
everything seems to be fine.

It looks that it's really solving the problem for me.

Thanks for your work. Cheers,
Fabio




On Sat, Jul 19, 2008 at 2:22 PM, Alan Jenkins <aj504@cs.york.ac.uk> wrote:
> Fabio Comolli wrote:
>> Hi Alex.
>> Well, I read the bug report but still can't understand why in any
>> kernels < 2.6.26 I don't have any problems with battery reports and in
>> 2.6.26 as soon as the message appears g-p-m starts to behave
>> incorrectly.
>>
>> Anyway, I got back to 25.11 for now, if you have any other workarounds
>> for me to test please let me know.
>
> Hi Fabio.
>
> I wrote some GPE fixes for my Asus laptop and they need some wider
> testing :-).  I think I found why we get GPE storms and how to deal
> with them.
>
> I posted them on the lists a series of three patches, but I neglected
> to CC any potential testers.  For convenience I squished them into a
> single patch and posted them in Bugzilla.
>
> My bug: <http://bugzilla.kernel.org/show_bug.cgi?id=11089>
> Patch: <http://bugzilla.kernel.org/attachment.cgi?
> id=16886&action=view>
>
> The risky part of the fixes removes the GPE interrupt storm check and
> the GPE polling mode. So you won't see the "disabling EC GPE" message,
> and I'm hoping this will stop g-p-m  misbehaving for you.
>
> I'm not sure what could happen if it's broken somehow :-).  If you
> have ACPI hotkeys (i.e. running acpi_listen shows events when you
> press hotkeys), please check they still work.  If not, you should have
> at least one button that generates an ACPI event - the power button.
> So it would be great if you could check the power button still works
> as normal.  (On my computer, g-p-m handles the power button and pops
> up a logout/shutdown prompt).
>
> Thanks
> Alan
>
