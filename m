From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 04/15] ACPI: Document ACPI device specific properties
Date: Fri, 03 Oct 2014 04:03:51 +0200
Message-ID: <26673925.fa6Qhdm5sV@vostro.rjw.lan>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <15893883.nvuW3ndylz@wuerfel> <20141002133654.GP1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64331 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752602AbaJCBnw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Oct 2014 21:43:52 -0400
In-Reply-To: <20141002133654.GP1786@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>

On Thursday, October 02, 2014 04:36:54 PM Mika Westerberg wrote:
> On Thu, Oct 02, 2014 at 02:46:30PM +0200, Arnd Bergmann wrote:
> > On Thursday 02 October 2014 15:15:08 Mika Westerberg wrote:

[cut]

> 
> Putting everything to a single package results this:
> 
> 		Package () { "pwms", Package () {"led-red", ^PWM0, 0, 10, "led-green", ^PWM0, 1, 10 }}
> 
> But I think the below looks better:

I agree.

> 		Package () { "pwms", Package () {^PWM0, 0, 10, ^PWM0, 1, 10 }}
> 		Package () { "pwm-names", Package () {"led-red", "led-green"}}
> 
> and it is trivial to match with the corresponding DT fragment.
> 
> > 	}
> > 
> > vs.
> > 
> > 	pwm-slave {
> > 		pwms = <&pwm0 0 10>, <&pwm1 1 20>;
> > 		pwm-names = "led-red", "led-green";
> > 	};
> > 
> 
> I don't have strong feelings which way it should be. The current
> implementation limits references so that you can have only integer
> arguments, like {ref0, int, int, ref1, int} but if people think it is
> better to allow strings there as well, it can be changed.
> 
> I would like to get comments from Darren and Rafael about this, though.

In my opinion there needs to be a "canonical" representation of the
binding that people always can expect to work.  It seems reasonable to
use the one exactly matching the DT representation for that.

In addition to that we can add other representations that the code will
also parse correctly as alternatives.  In the future.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
