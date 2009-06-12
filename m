From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG][2.6.30] Niced processes do not raise CPU frequency with ondemand
Date: Fri, 12 Jun 2009 20:05:02 +0200
Message-ID: <200906122005.02965.elendil@planet.nl>
References: <200906121844.02004.elendil@planet.nl> <200906121925.38693.elendil@planet.nl> <1244828508.4534.1404.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpm-eml102.kpnxchange.com ([195.121.3.6]:64603 "EHLO
	CPSMTPM-EML102.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758844AbZFLSFC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Jun 2009 14:05:02 -0400
In-Reply-To: <1244828508.4534.1404.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday 12 June 2009, Pallipadi, Venkatesh wrote:
> On Fri, 2009-06-12 at 10:25 -0700, Frans Pop wrote:
> > On Friday 12 June 2009, Pallipadi, Venkatesh wrote:
> > > What does ignore_nice under cpufreq/ondemand say?
> >
> > Right, that's 1 (was not aware that existed :-P)
> > And changing it to 0 solves the problem.
>
> OK. Good to know that there are no kernel bugs with honoring
> ignore_nice_load setting. :)
>
> > Next question is: how and why does it get set?
> > As userland has not changed (AFAIK), my first suspect remains the
> > kernel.
>
> Kernel never sets this. It is initialized to 0 and provides a /sys
> interface to user. I think it is set by some user app
> (gnome-power-manager or some other app like that). That explains why it
> is 0 initially after boot and gets changed later.
>
> The support for ignore_nice_load=1 was broken in kernel for a short
> while (arounf 2.6.28, IIRC). That may be the reason why this behavior
> was not noticed earlier.

Thanks for the info. I'll see if I can figure out what's responsible.
At least I know where to look now.

Cheers,
FJP
