From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
Subject: Re: 2.6.20rc5 k8/acpi regression ( 2.6.17.13 works fine ).
Date: Thu, 25 Jan 2007 23:11:46 +0100
Message-ID: <200701252311.46858.pluto@agmk.net>
References: <200701242346.44673.pluto@agmk.net> <20070124225238.GT17836@stusta.de> <200701242350.45276.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agmk.net ([87.236.194.20]:4289 "EHLO mail.agmk.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965403AbXAYWMO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jan 2007 17:12:14 -0500
In-Reply-To: <200701242350.45276.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk

On Thursday 25 of January 2007 05:50:45 Len Brown wrote:
> On Wednesday 24 January 2007 17:52, Adrian Bunk wrote:
> > On Wed, Jan 24, 2007 at 11:46:44PM +0100, Pawe=C5=82 Sikora wrote:
> > > for 2.6.20rc5 i get an acpi related oops during x86-64 boot:
> > > http://minus.ds14.agh.edu.pl/~pluto/2.6.20rc5-acpi-oops.jpg
> > > disabling the "amd-k8 cool'n'quiet" option in bios helps.
> > > moreover, it works fine for 2.6.17.13, so it looks like
> > > a recent regression. i can provide more details if you need.
> >
> > thanks for your report.
> >
> > Can you narrow down a bit when it started?
> > Is 2.6.19 OK?
> > Is 2.6.18 OK?
>
> Is the stack trace always the same?  It doesn't make much sense to me=
=2E

with debug options enabled oops looks better:
http://minus.ds14.agh.edu.pl/~pluto/2.6.20rc5-oops-01.jpg
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
