From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Linux 2.6.25 (coretemp reads high temperatures)
Date: Wed, 23 Apr 2008 11:43:10 +0300
Message-ID: <200804231143.10875.maximlevitsky@gmail.com>
References: <e85b9d30804180837y39c52e26i588e4b67c87a5e9d@mail.gmail.com> <200804182151.49021.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:21132 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbYDWInQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Apr 2008 04:43:16 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2537314fgb.17
        for <linux-acpi@vger.kernel.org>; Wed, 23 Apr 2008 01:43:15 -0700 (PDT)
In-Reply-To: <200804182151.49021.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew <jackdachef@gmail.com>, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org

On Saturday, 19 April 2008 04:51:48 Len Brown wrote:
> On Friday 18 April 2008, Matthew wrote:
> > Hi everyone, hi Linus,
> >=20
> > congratulations on this new great kernel-release :)
> >=20
> > I've another "regression" to report for 2.6.25:
> >=20
> > it's concerning much higher temperatures being read out by the
> > "coretemp" kernel-module in comparison to 2.6.24* series
> >=20
> > e.g. where temperatures were around 40-47=B0C they are now constant=
ly
> > jumping around 55-70=B0C (even in idle !)

I just updated from 2.6.24 to 2.6.25
(I usually follow whole development cycle, but I was very busy, so I sk=
ipped 2.6.25 cycle)

I confirm this.
I *know* that temperatures reported now are wrong.

The reason is that bios did report same temperatures as coretemp in 2.6=
=2E24,
moreover some time ago I have run a cpu tool (don't remember its name) =
on windows
which similar to coretemp reads from each core directly, sensor data ,=20
and I noticed that temperature that bios reports is exactly the average=
=20
temperature of both cores
(I had to run this on windows - intel haven't released=20
drivers for their QST for temperature monitoring from bios - very sad)

And the driver did say in kernel log that TJMAX is 85C

Lets at least make a kernel option to override tjmax?

Best regards,
	Maxim Levitsky
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
