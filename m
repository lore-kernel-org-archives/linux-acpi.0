From: "Eduard Huguet" <eduardhc@gmail.com>
Subject: Re: Suspend to RAM in an Asus P1-AH2
Date: Tue, 2 Sep 2008 14:49:13 +0200
Message-ID: <617be8890809020549o5edc2cfbvc6fbb0326eb53af6@mail.gmail.com>
References: <617be8890808270739gdba5c46q6cae8c33668d6bba@mail.gmail.com>
	 <200808272215.15035.rjw@sisk.pl>
	 <617be8890808290321s6a9ec689r5a71c78f1fea86cb@mail.gmail.com>
	 <200808302204.19338.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:32310 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYIBMtO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2008 08:49:14 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1320377yxm.1
        for <linux-acpi@vger.kernel.org>; Tue, 02 Sep 2008 05:49:13 -0700 (PDT)
In-Reply-To: <200808302204.19338.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

Hi,
   I retried after checking CONFIG_FTRACE through menuconfig (I double
checked it was set in .config). Same results. Can I do any other test
now that this setting is on (I guess is something related to kernel
function tracing)?

Best regards,
  Eduard Huguet



2008/8/30 Rafael J. Wysocki <rjw@sisk.pl>
>
> On Friday, 29 of August 2008, Eduard Huguet wrote:
> > Hi,
> >     I've tested the current git-sources-2.6.27-rc4 on Gentoo with the
> > suggested ACPI setting at kernel boot. Although the results are not
> > exactly satisfactory, at least they are different: now, when using
> > hibernate-ram the machine seems to effectively hibernate (entering S3
> > state), as I can hear how the hard disk is parked and the CPU fan
> > stops (which was not happening before...). Brief, the machine would
> > look simply "powered off" if weren't by the power led, that keeps
> > blinking at 1 Hz. I guess this is how S3 state should look like in
> > this machine, shouldn't it...?
> >
> > However, pressing again the power button doesn't seem to resume from
> > RAM, instead the machine simply boots up normally (using previous
> > kernels, pushing power button did nothing, as the machine was dead - I
> > had to power it off manually and boot).
> >
> > Am I missing something...?
>
> Do you have CONFIG_FTRACE set, by chance?  If you do, please unset it and
> retest.
>
> Thanks,
> Rafael
