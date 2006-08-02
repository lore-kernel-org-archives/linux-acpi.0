From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: [ltp] Re: Generic battery interface
Date: Thu, 3 Aug 2006 00:59:00 +0300
Message-ID: <41840b750608021458h2c7238d6xe1d412cfae1d5569@mail.gmail.com>
References: <20060728074202.GA4757@suse.cz> <20060728202359.GB5313@suse.cz>
	 <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
	 <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
	 <41840b750607301137t1e10fe88o3a1c73e7a4b4bf44@mail.gmail.com>
	 <20060731113735.GA22081@creature.apm.etc.tu-bs.de>
	 <41840b750607310818j7ab2dcddpcb7a14b9a8f10871@mail.gmail.com>
	 <20060731183719.GB22081@creature.apm.etc.tu-bs.de>
	 <41840b750607311545h72cd5b1dq730c35b084c43db7@mail.gmail.com>
	 <20060801114303.GA13000@creature.apm.etc.tu-bs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:11988 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932258AbWHBV7C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Aug 2006 17:59:02 -0400
Received: by ug-out-1314.google.com with SMTP id m3so480894ugc
        for <linux-acpi@vger.kernel.org>; Wed, 02 Aug 2006 14:59:00 -0700 (PDT)
In-Reply-To: <20060801114303.GA13000@creature.apm.etc.tu-bs.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Olbrich <michael.olbrich@gmx.net>
Cc: linux-thinkpad@linux-thinkpad.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>

Hi Micael,

I ask again: please do a Reply to All. This discussion is CCed on
several mailing lists, not just link-thinkpad.

On 8/1/06, Michael Olbrich <michael.olbrich@gmx.net> wrote:
> On Tue, Aug 01, 2006 at 01:45:27AM +0300, Shem Multinymous wrote:
> >>And keeping the latest readout for each app isn't that heavy. After all
> >>we already have to keep track of the timeouts for each app.
> >
> >The timeouts bookkeeping will normally be done by some infrastructure,
> >and can often be (in principle) be optimized to less than on value per
> >app. Also, it's just one timestamp. By contrast, what you're asking
> >for requires explicit handling by every driver, and the attribute
> >value may take significant amount of storage -- per app.
>
> If you are that concerned about storage why the complex timeout model?
> That can easily handled in userspace with just the blocking and
> nonblocking reads.

Please explain how this can be done  in a way that (a) works
transparently with both event-driven and query-based drivers, (b)
handles multiple clients efficiently, (c) minimizes hardware queries
in the case of query-based drivers, and (d) doesn't cause unnecessary
timer interrupts on tickless kernels.


> > The app can do this itself by polling and checking the value, with a
> > (not too) small value of dupeq.min_wait. In the case of a
> > polling-based data source, the resulting hardware queries and timer
> > interrupts are exactly the same as an in-kernel implementation which
> > does the polling and comparions itself. If the data source is
> > event-based then the comparison in userspace does have a drawback: the
> > comparions are done just dupeq.min_wait apart even if the event rate
> > happens to be higher. Can you think of a case where this matters?
>
> The problem I see is the overhead. Visual feedback that feels
> instantaneous would require dupeq.min_wait<50ms. And as far as I can
> tell each read requires to switch from userspace to kernelspace and
> back. When I look at the available variables I can easily imagine
> applications that would read >10 variables. That's not something I would
> want to do that often.

This is relevant only to query-based drivers, not event-based. How
expensive is a context switch compared to a typical hwmon hardware
query?

  Shem
