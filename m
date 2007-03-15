From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: lid switch hangs notebook
Date: Thu, 15 Mar 2007 11:06:06 -0800
Message-ID: <20070315110606.741c2dc4.akpm@linux-foundation.org>
References: <a790ea7a0703120753i232ace2bg7272fa479b821e32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:36594 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbXCOTGJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 15:06:09 -0400
In-Reply-To: <a790ea7a0703120753i232ace2bg7272fa479b821e32@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Antonio Mignolli <antoniomignolli@gmail.com>
Cc: linux-acpi@vger.kernel.org

> On Mon, 12 Mar 2007 15:53:18 +0100 "Antonio Mignolli" <antoniomignolli@gmail.com> wrote:
> Hi,
> I'm running a slackware 10.2 on a HP/Compaq nx5000.
> 
> With kernels <= 2.6.17.3 I didn't have problems.
> Starting from 2.6.19 if I close the notebook's video,
> or if I press the lid switch,
> after a couple of time, or after a few seconds, the o.s. hangs
> completely. The only thing to do is a brute power off
> by pressing for 5 seconds the power button
> (If I press for few it should do a clean shutdown -h).
> I've tried 2.6.19, 2.6.19.1, 2.6.19.2, 2.6.20, 2.6.20.1, 2.6.20.2,
> and all of them seem to give problems.
> 
> I don't have KERNEL_DEBUG set, so I haven't any debug informations,
> I will be happy to activate it and provide more info if someone suggests
> me which debug parameters I should set.
> There's nothing in /var/log/messages and /var/log/syslog,
> except for the message "LID switch" added by me
> with a logger command in /etc/acpi/acpi_handler.sh.
> I've put it after noticing the problem, in order to be sure the event was
> detected, and it was.

I guess this is an ACPI think, although not necessarily.

Len & co: do you think we should ask Antonio to raise a report
against ACPI at bugzilla.kernel.org?
