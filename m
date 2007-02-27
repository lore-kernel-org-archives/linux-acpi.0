From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [lm-sensors] RFC: conversion of ibm-acpi to hwmon sysfs
Date: Tue, 27 Feb 2007 12:41:18 -0300
Message-ID: <20070227154118.GA1980@khazad-dum.debian.net>
References: <20070224182024.GA23865@khazad-dum.debian.net> <20070226172716.b2e956b7.khali@linux-fr.org> <20070226180635.GG2909@khazad-dum.debian.net> <20070227100129.fa962c81.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:52646 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751638AbXB0PlY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Feb 2007 10:41:24 -0500
Content-Disposition: inline
In-Reply-To: <20070227100129.fa962c81.khali@linux-fr.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org

On Tue, 27 Feb 2007, Jean Delvare wrote:
> I don't really have time for such long reads, sorry. If there's
> anything in particular you think I should know, just tell me.

Just that the stale value is indeed useful on one particular case.

> > > pwm#_enable = 0 means fan# at full speed, _not_ fan# stopped. Fan# stopped
> > > is pwm#_enable = 1 and pwm# = 0.
> > 
> > The hwmon sysfs interface documentation is not clear on that.  Turning PWM
> > off might lock the hardware into 0% duty or 100% duty depending on how it
> > was designed.
> 
> Feel free to submit a patch improving the documentation.

Ok.

> > BTW, ibm-acpi implements a "fan watchdog", to help fan-control userspace
> > applications.  It resets the fan to a safe "on" mode if nothing tries any
> > control operation on the fans in a given time period.
> > 
> > Is there any interest in trying for a fan-watchdog generic interface, or
> > should I just implement that in sysfs as I see fit for ibm-acpi?
> 
> We don't have anything like that in the other drivers. I guess it only
> applies to manual mode? The idea is interesting, I have to admit. I
> don't have a particular opinion on how to implement that (specific vs
> standard), do as you wish.

The fan watchdog is a driver thing, it could be implemented by any driver
for any chip that has a manual mode (it doesn't make sense if the chip is
always in auto mode).  I will implement it in a suitable-to-be-generic way
and propose a patch for the sysfs hwmon docs.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
