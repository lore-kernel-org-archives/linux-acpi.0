From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: suspend kills serial wacom tablet
Date: Fri, 13 Apr 2007 17:20:51 -0400
Message-ID: <d120d5000704131420n65dd47d1r97442785d8617977@mail.gmail.com>
References: <pan.2007.02.20.13.52.07.111117@metm.org>
	 <200704131249.23640.bjorn.helgaas@hp.com>
	 <d120d5000704131216h7ccabc12uf0e649105fd7b6b0@mail.gmail.com>
	 <200704131510.26565.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:21960 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030456AbXDMVUw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Apr 2007 17:20:52 -0400
Received: by nz-out-0506.google.com with SMTP id s1so849538nze
        for <linux-acpi@vger.kernel.org>; Fri, 13 Apr 2007 14:20:52 -0700 (PDT)
In-Reply-To: <200704131510.26565.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: marco <marco@metm.org>, linux-acpi@vger.kernel.org

On 4/13/07, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Friday 13 April 2007 13:16, Dmitry Torokhov wrote:
> > On 4/13/07, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > > On Tuesday 20 February 2007 06:52, marco wrote:
> > > > I have a thinkpad X41-tablet which uses the linuxwacom serial drivers.
> > > > The tablet works perfectly when the laptop first boots, but does not work
> > > > at all after resuming from sleep.  I posted to the linuxwacom list but
> > > > think that the problem might be more general in how acpi resumes the
> > > > serial ports.
> > > >
> > > > As suggested here:
> > > > http://www.thinkwiki.org/wiki/Installing_Ubuntu_6.10_on_a_ThinkPad_X41_Tablet
> > > > I have added a script to resume.d which calls the setserial command:
> > > >   /bin/setserial /dev/ttyS0 port 0x0200 irq 5 autoconfig
> > >
> > > Using setserial to change port or IRQ usage is a good clue that the
> > > kernel is doing something wrong.  Usually it's "we KNOW that ttyS0
> > > lives at 0x3f8 and IRQ 4, so we'll ignore what ACPI is telling us."
> > > But it sounds like this is a tangent and not related to your current
> > > problem.
> > >
> > > Can you post the dmesg log from a boot where the tablet works
> > > correctly?  That will tell us exactly what kernel you're running
> > > and how the kernel detected the serial port.  There've been some
> > > serial port resume changes in the not-too-distant past, and I
> > > don't know whether they're in the Ubuntu kernel yet.
> >
> > It has nothing to do with changes to serial. Wacom driver for tablets
> > connected to serial ports lives completely in userspace (X) and is
> > completelyunaware that the box is coming out of sleep and that
> > conncted device needs to be reinitialized.
>
> OK, that sounds good, because if it's an X issue, it's Someone Else's
> Problem :-)
>

Exactly ;)

> I'm a little concerned because Marco said that after a resume,
> "cat /dev/ttyS0" caused his system to hang, and not even Ctrl-Alt-Del
> worked.  Can we blame that all on X?
>

No, I don't think we can. The device connected to the port is simply
not re-initialized and mey either transmit garbage or not transmit
data at all. However accessing the port should not hang kernel.

> Would stopping the X server before suspend and restarting
> it after resume be a workaround?
>

I do not think it is feasible.  If you have to shut down X you might
as well shut down entire box.

-- 
Dmitry
