From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: HP laptop: fan off until CPU temp near 105 degrees C
Date: Mon, 1 Oct 2012 14:33:17 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926322D9A3@SHSMSX101.ccr.corp.intel.com>
References: <CALHKqSU44q6LakKrBKeNFFu7=xbipAog4URMLT0i5Yturo6w9w@mail.gmail.com>
 <4D68720C2E767A4AA6A8796D42C8EB591C9D47@BGSMSX102.gar.corp.intel.com>
 <CALHKqSXFhf7zoQWMrPDzgS0EGXN5xVxOHLu2j8Ysdtexk5prww@mail.gmail.com>
 <4D68720C2E767A4AA6A8796D42C8EB591C9E51@BGSMSX102.gar.corp.intel.com>
 <CALHKqSXtD_TbGYTxJv+fhXhjqO2=UoDUoeF8dFkEeuuvN36PwQ@mail.gmail.com>
 <CALHKqSWoGMQ9sEP34zWjRxoxOPXAWOjyKd1SC-asW7qypvAPng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:49296 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332Ab2JAOdV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Oct 2012 10:33:21 -0400
In-Reply-To: <CALHKqSWoGMQ9sEP34zWjRxoxOPXAWOjyKd1SC-asW7qypvAPng@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jack Kelly <jack-list@xlk.org.uk>, "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Can you attach the acpidump output of this machine?
Can you attach the output of "grep . /sys/class/thermal/*/*" both when the system is cool and overheat?

> -----Original Message-----
> From: jack.kelly.productions@googlemail.com
> [mailto:jack.kelly.productions@googlemail.com] On Behalf Of Jack Kelly
> Sent: Monday, October 01, 2012 4:51 PM
> To: R, Durgadoss
> Cc: linux-acpi@vger.kernel.org; Zhang, Rui
> Subject: Re: HP laptop: fan off until CPU temp near 105 degrees C
> Importance: High
> 
> Dear ACPI list, Rui and Durga,
> 
> I'm just wondering if you have any further thoughts or suggestions
> regarding the issue whereby my laptop fan turns off when Linux boots?
> 
> If not then are there any other avenues I should pursue?  e.g. should I
> try writing to HP support to let them know that something odd happens
> with the firmware?
> 
> If all else fails then I'll get my soldering iron out and permanently
> send power to the CPU fan.
> 
> Thanks,
> Jack
> 
> 
> 
> On 24 September 2012 18:04, Jack Kelly <jack-list@xlk.org.uk> wrote:
> >
> > On 24 September 2012 17:47, R, Durgadoss <durgadoss.r@intel.com>
> wrote:
> > > IMO, this crit_alarm should become 1 when your CPU temperature
> > > reaches
> > > 105 C. Does this happen ?
> >
> > No, crit_alarm stays set to 0 even when CPU temp hits 105.
> >
> > > Okay, That explains a bit of it. You have CPU cores and LCD
> > > registered as cooling devices. But I believe throttling these
> things
> > > would require some intelligence/information from ACPI tables.. Not
> > > sure whether your BIOS has them.. May be Rui can help us here..
> >
> > My CPU definitely throttles.  When idling the CPU freq is 1.2GHz;
> when
> > fully loaded it's 2.4GHz (according to /proc/cpuinfo)
> >
> > > AFAIK, The coretemp driver does not do/handle any hysteresis like
> this.
> > > My best guess is again the BIOS has something configured to do like
> this.
> >
> > Oh yes, I should mention: the BIOS setup has an option "Fan Always on
> > while on AC Power".  I've tried booting with this option on and with
> > it off but it appears to make no difference to Linux.
> >
> > Thanks again,
> > Jack
