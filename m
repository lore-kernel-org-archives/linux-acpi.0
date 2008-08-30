From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend to RAM in an Asus P1-AH2
Date: Sat, 30 Aug 2008 22:04:18 +0200
Message-ID: <200808302204.19338.rjw@sisk.pl>
References: <617be8890808270739gdba5c46q6cae8c33668d6bba@mail.gmail.com> <200808272215.15035.rjw@sisk.pl> <617be8890808290321s6a9ec689r5a71c78f1fea86cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57725 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552AbYH3UAZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 Aug 2008 16:00:25 -0400
In-Reply-To: <617be8890808290321s6a9ec689r5a71c78f1fea86cb@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eduard Huguet <eduardhc@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Friday, 29 of August 2008, Eduard Huguet wrote:
> Hi,
>     I've tested the current git-sources-2.6.27-rc4 on Gentoo with the
> suggested ACPI setting at kernel boot. Although the results are not
> exactly satisfactory, at least they are different: now, when using
> hibernate-ram the machine seems to effectively hibernate (entering S3
> state), as I can hear how the hard disk is parked and the CPU fan
> stops (which was not happening before...). Brief, the machine would
> look simply "powered off" if weren't by the power led, that keeps
> blinking at 1 Hz. I guess this is how S3 state should look like in
> this machine, shouldn't it...?
> 
> However, pressing again the power button doesn't seem to resume from
> RAM, instead the machine simply boots up normally (using previous
> kernels, pushing power button did nothing, as the machine was dead - I
> had to power it off manually and boot).
> 
> Am I missing something...?

Do you have CONFIG_FTRACE set, by chance?  If you do, please unset it and
retest.

Thanks,
Rafael
