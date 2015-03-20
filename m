From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: Help with debugging intermittent crash on resume from
 hibernation
Date: Fri, 20 Mar 2015 04:57:01 +0100
Message-ID: <1426823821.3150.4.camel@gmail.com>
References: <8761a3s1vq.fsf@vostro.rath.org>
	 <87vbhwwdzz.fsf@vostro.rath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34200 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbbCTD5E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2015 23:57:04 -0400
In-Reply-To: <87vbhwwdzz.fsf@vostro.rath.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nikolaus Rath <Nikolaus@rath.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>

(+CC)

On Thu, 2015-03-19 at 20:21 -0700, Nikolaus Rath wrote:
> On Mar 13 2015, Nikolaus Rath <Nikolaus@rath.org> wrote:
> > Hello,
> >
> > In about one out of 10 resumes from hibernation, my system resets after
> > the hibernation image has been loaded. I am hibernating using
> >
> > # echo platform > /sys/power/disk
> > # echo disk > /sys/power/state
> >
> > When testing hibernation using
> >
> > # echo core > /sys/power/pm_test
> > # echo platform > /sys/power/disk
> > # echo disk > /sys/power/state
> >
> > I was not able to produce the same failure.
> >
> > I then tried attaching a serial console and booted with
> > console=ttyS0,115200n8 no_console_suspend. For the failed attempt, the
> > last messages before the reset are:
> [...]
> 
> I reproduced the same problem with 4.0.0-rc3. Is there anything I can do
> to get more debugging information?
> 
> Thanks,
> -Nikolaus
> 


