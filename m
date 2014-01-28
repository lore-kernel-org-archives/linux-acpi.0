From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Flag use of ACPI and ACPI idioms for power supplies to regulator API
Date: Tue, 28 Jan 2014 22:55:25 +0100
Message-ID: <1872826.bbnxCFNbYC@vostro.rjw.lan>
References: <1390782734-10131-1-git-send-email-broonie@kernel.org> <15814871.c5vzFttNXX@vostro.rjw.lan> <20140128122106.GA11949@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63691 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754923AbaA1VlI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jan 2014 16:41:08 -0500
In-Reply-To: <20140128122106.GA11949@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linaro-kernel@lists.linaro.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>

On Tuesday, January 28, 2014 12:21:06 PM Mark Brown wrote:
> 
> --XsQoSWH+UP9D9v3l
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Tue, Jan 28, 2014 at 01:06:45AM +0100, Rafael J. Wysocki wrote:
> > On Monday, January 27, 2014 01:21:06 PM Mark Brown wrote:
> 
> > > I'd like someone to take it :) .  I'd expected the default thing would
> > > be for it to go via the ACPI tree but I can apply it to the regulator
> > > tree if you'd prefer, either way is fine by me.
> 
> > I've queued it up for my next pull request, thanks!
> 
> Excellent, thanks!  Could you tag it for stable please as Jean
> requested?  In v3.13 it fixes regressions in lm90 on PCs if the
> regulator API is enabled (which unfortunately Ubuntu did so it's
> a real scenario) and it should be safe in older kernels though I'm
> not aware of any actual systems that are affected.

Done, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
