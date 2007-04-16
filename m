From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: suspend kills serial wacom tablet
Date: Mon, 16 Apr 2007 17:18:42 -0400
Message-ID: <d120d5000704161418w7603e760wb34b90d8e3974537@mail.gmail.com>
References: <pan.2007.02.20.13.52.07.111117@metm.org>
	 <d120d5000704131420n65dd47d1r97442785d8617977@mail.gmail.com>
	 <4623D585.5010005@metm.org> <200704161510.18246.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:37327 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030976AbXDPVTL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Apr 2007 17:19:11 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1639414wra
        for <linux-acpi@vger.kernel.org>; Mon, 16 Apr 2007 14:19:09 -0700 (PDT)
In-Reply-To: <200704161510.18246.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: marco <marco@metm.org>, linux-acpi@vger.kernel.org

On 4/16/07, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Monday 16 April 2007 13:59, marco wrote:
> > ...  It is still a problem which renders the
> > pen unusable after a suspend.
> > I am happy to run any tests you need.
> > Attatched are a dmesg right after a reboot when the pen is working
> > dmesg.wpen and another dmesg after I suspend the laptop and the pen no
> > longer works.
>
> Here's your trackpoint device:
>
>  [17179584.620000] IBM TrackPoint firmware: 0x0e, buttons: 3/3
>  [17179584.640000] input: TPPS/2 IBM TrackPoint as /class/input/input2
>

This is trackpoint (small rubber-head stick in the middle of laptop
keyboard) that has nothing to do with Wacom tablet.

> After resume, it looks like it's associated with a different input device:
>
>  [17179770.968000] IBM TrackPoint firmware: 0x0e, buttons: 3/3
>  [17179770.984000] input: TPPS/2 IBM TrackPoint as /class/input/input4
>
> I'm sure that alone would be enough to confuse X.

No, it should be fine as long as /dev/input/mice is used.

>  It seems a bit
> strange that the device is associated differently after resume, but
> I don't know enough about input drivers to know whether that's by
> design or not.
>

It should not change input devices, I would like to see output of boot
and suspend/resume cycle with "i8042.debug log_buf_len=131072" kernel
boot options.

> And I can't figure out what device that really is.  For some reason, I
> thought it was ttyS0, but you seem to be using drivers/input/mouse/trackpoint.c,
> which looks like PS/2 stuff, not serial.  And the wiki you referenced
> mentions /dev/wacom.  I have no idea how that's wrapped up with this,
> although drivers/usb/input/wacom* is all USB stuff, and I assume your
> trackpoint is not a USB device (or is it?)
>

As far as I understand Marco has a serial Wacom table. There is no
in-kernel driver for serial wacoms, they are handled entirely in
userspace (X).

-- 
Dmitry
