From: yhlu <yhlu.kernel@gmail.com>
Subject: Re: amd64 brightness has lowest value after boot
Date: Fri, 30 Jun 2006 23:59:28 -0700
Message-ID: <86802c440606302359t406b7dd3g39a6fec2943799a7@mail.gmail.com>
References: <449FBAC8.1060509@web.de> <44A39A07.20408@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:64602 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751333AbWGAG7a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 1 Jul 2006 02:59:30 -0400
Received: by nf-out-0910.google.com with SMTP id k26so59144nfc
        for <linux-acpi@vger.kernel.org>; Fri, 30 Jun 2006 23:59:28 -0700 (PDT)
In-Reply-To: <44A39A07.20408@web.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rathgeb Markus <maggu2810@web.de>
Cc: linux-acpi@vger.kernel.org

You may try to dump the dsdt and modify it and put one compiled
modified dsdt in your initrd.

YH

On 6/29/06, Rathgeb Markus <maggu2810@web.de> wrote:
> Hi!
> I find out (via acpi debug) that this are the execution methods:
> decrease brightness: \_SB_.PCI0.EC__._Q12
> increase brightness: \_SB_.PCI0.EC__._Q13
>
> Can i execute this methods from hand? whitout press the keys?
>
> Rathgeb Markus wrote:
> > Hi!
> > I have read the mailinglist for over a year and never heard about a
> > similar problem till last month. But there was no answer given.
> > If i use a 32 BIT linux the problem DO NOT occur, but for a few month I
> > have changed again to a 64 bit linux system (I used 64 bit a year before
> > and there was the same problem).
> > Everytime after the message "Booting the Kernel" (all versions I
> > prepared till 2.6.16) the displays brightness changes to the
> > lowest value, so I have to press the hotkeys till the brightness has an
> > acceptable value. (this also happens by an ordinary boot without resume.
> > I notice that because in the attached email the person writes "My
> > problem is that after resume".)
> >>From time to time the hotkeys "are confused" (or do not work), too. I
> > press the key to
> > increase the value and it go hell, dark, hell, hell, dark etc. (it does
> > what it want *g*).
> > Please help me ;-)
> > and excuse my english.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
