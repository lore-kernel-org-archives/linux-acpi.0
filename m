From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Flag use of ACPI and ACPI idioms for power supplies to regulator API
Date: Tue, 28 Jan 2014 01:06:45 +0100
Message-ID: <15814871.c5vzFttNXX@vostro.rjw.lan>
References: <1390782734-10131-1-git-send-email-broonie@kernel.org> <3051988.Sav3BEhI94@vostro.rjw.lan> <20140127132106.GY11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50346 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753818AbaA0Xw2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jan 2014 18:52:28 -0500
In-Reply-To: <20140127132106.GY11727@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linaro-kernel@lists.linaro.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>

On Monday, January 27, 2014 01:21:06 PM Mark Brown wrote:
> 
> --fzoBs0edN2XpEQF6
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Mon, Jan 27, 2014 at 01:54:48PM +0100, Rafael J. Wysocki wrote:
> > On Monday, January 27, 2014 12:44:34 AM Mark Brown wrote:
> 
> > > > That's going to be called earlier than it use to be in 3.13 and before.
> 
> > > > No problems with that?
> 
> > > All that function does is to set a flag - so long as we can assign to a
> > > static variable it should be OK.
> 
> > OK, do you want me to take it?
> 
> I'd like someone to take it :) .  I'd expected the default thing would
> be for it to go via the ACPI tree but I can apply it to the regulator
> tree if you'd prefer, either way is fine by me.

I've queued it up for my next pull request, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
