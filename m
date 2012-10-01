From: Jack Kelly <jack-list@xlk.org.uk>
Subject: Re: HP laptop: fan off until CPU temp near 105 degrees C
Date: Mon, 1 Oct 2012 09:51:24 +0100
Message-ID: <CALHKqSWoGMQ9sEP34zWjRxoxOPXAWOjyKd1SC-asW7qypvAPng@mail.gmail.com>
References: <CALHKqSU44q6LakKrBKeNFFu7=xbipAog4URMLT0i5Yturo6w9w@mail.gmail.com>
 <4D68720C2E767A4AA6A8796D42C8EB591C9D47@BGSMSX102.gar.corp.intel.com>
 <CALHKqSXFhf7zoQWMrPDzgS0EGXN5xVxOHLu2j8Ysdtexk5prww@mail.gmail.com>
 <4D68720C2E767A4AA6A8796D42C8EB591C9E51@BGSMSX102.gar.corp.intel.com> <CALHKqSXtD_TbGYTxJv+fhXhjqO2=UoDUoeF8dFkEeuuvN36PwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64034 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab2JAIvp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Oct 2012 04:51:45 -0400
Received: by vbbff1 with SMTP id ff1so5053540vbb.19
        for <linux-acpi@vger.kernel.org>; Mon, 01 Oct 2012 01:51:44 -0700 (PDT)
In-Reply-To: <CALHKqSXtD_TbGYTxJv+fhXhjqO2=UoDUoeF8dFkEeuuvN36PwQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Dear ACPI list, Rui and Durga,

I'm just wondering if you have any further thoughts or suggestions
regarding the issue whereby my laptop fan turns off when Linux boots?

If not then are there any other avenues I should pursue?  e.g. should
I try writing to HP support to let them know that something odd
happens with the firmware?

If all else fails then I'll get my soldering iron out and permanently
send power to the CPU fan.

Thanks,
Jack



On 24 September 2012 18:04, Jack Kelly <jack-list@xlk.org.uk> wrote:
>
> On 24 September 2012 17:47, R, Durgadoss <durgadoss.r@intel.com> wrote:
> > IMO, this crit_alarm should become 1 when your CPU temperature reaches
> > 105 C. Does this happen ?
>
> No, crit_alarm stays set to 0 even when CPU temp hits 105.
>
> > Okay, That explains a bit of it. You have CPU cores and LCD registered as
> > cooling devices. But I believe throttling these things would require some
> > intelligence/information from ACPI tables.. Not sure whether your
> > BIOS has them.. May be Rui can help us here..
>
> My CPU definitely throttles.  When idling the CPU freq is 1.2GHz; when
> fully loaded it's 2.4GHz (according to /proc/cpuinfo)
>
> > AFAIK, The coretemp driver does not do/handle any hysteresis like this.
> > My best guess is again the BIOS has something configured to do like this.
>
> Oh yes, I should mention: the BIOS setup has an option "Fan Always on
> while on AC Power".  I've tried booting with this option on and with
> it off but it appears to make no difference to Linux.
>
> Thanks again,
> Jack
