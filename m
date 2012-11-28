From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ZPODD ACPI _PRW method support
Date: Wed, 28 Nov 2012 19:37:26 +0100
Message-ID: <3057085.h8ioivdxgG@vostro.rjw.lan>
References: <CANh5a1wN-vsYSAtWXWR2P5C=4kVeVj94UZPPbMGGXxHMJyzDew@mail.gmail.com> <1804754.cgLN50ubYg@vostro.rjw.lan> <CANh5a1xKFp57VQfufUzs3maxt8wHZCVv6gTpyvQr8FzNCJG=0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:35338 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755783Ab2K1Scl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Nov 2012 13:32:41 -0500
In-Reply-To: <CANh5a1xKFp57VQfufUzs3maxt8wHZCVv6gTpyvQr8FzNCJG=0A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Jeff.Wu" <chping@gmail.com>
Cc: linux-acpi@vger.kernel.org, Lin Ming <minggr@gmail.com>, Aaron Lu <aaron.lwe@gmail.com>

On Thursday, November 29, 2012 12:11:47 AM Jeff.Wu wrote:
> Hi Rafael
> 
> Thanks,
> 
> I  am testing ZPODD function ,for Linux ZPODD kernel,

This is not a mainline code, however, is it?

> if _PRW method is removed at  BIOS ACPI DSDT codes, ZPODD work normally.
> but, if _PRW method is added at BIOS ACPI DSDT codes,ZPODD can't be
> wakeup when ZPODD state is suspend.
> I'am not sure that Linux ZPODD whether is using _PRW to send wakeup events.

If you're testing Aaron's patches, please talk to Aaron.

Thanks,
Rafael


> 2012/11/28 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Wednesday, November 28, 2012 04:52:17 PM Jeff.Wu wrote:
> >> Hi aaron,ming,linux-acpi
> >>
> >>  Is it  whether need support ACPI _PRW method for ZPODD device ?
> >
> > Yes, it is.
> >
> >>  If BIOS had implemented _PRW method for ZPODD ,
> >> but Linux kernel doesn't support  ZPODD _PRW method,ZPODD will can't
> >> run into suspend state.
> >
> > I'm not sure what you mean.
> >
> > If we don't use _PRW, the device won't be able to signal wakeup events.
> >
> >> Is there any stories for ZPODD Linux _PRW method ?
> >
> > All threads related to ZPODD are about that indirectly.
> >
> > Thanks,
> > Rafael
> >
> >
> > --
> > I speak only for myself.
> > Rafael J. Wysocki, Intel Open Source Technology Center.
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
