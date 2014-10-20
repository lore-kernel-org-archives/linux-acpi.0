From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 03/12] ACPI: Allow drivers to match using Device Tree compatible property
Date: Tue, 21 Oct 2014 00:19:17 +0200
Message-ID: <23193541.xRyL2PmlA9@vostro.rjw.lan>
References: <2660541.BycO7TFnA2@vostro.rjw.lan> <3167500.xrhugPHshV@vostro.rjw.lan> <20141020140501.D10A5C40982@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64940 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752456AbaJTV6x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Oct 2014 17:58:53 -0400
In-Reply-To: <20141020140501.D10A5C40982@trevor.secretlab.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>

On Monday, October 20, 2014 04:05:01 PM Grant Likely wrote:
> On Fri, 17 Oct 2014 14:05:59 +0200
> , "Rafael J. Wysocki" <rjw@rjwysocki.net>
>  wrote:
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > We have lots of existing Device Tree enabled drivers and allocating
> > separate _HID for each is not feasible. Instead we allocate special _HID
> > "PRP0001" that means that the match should be done using Device Tree
> > compatible property using driver's .of_match_table instead if the driver
> > is missing .acpi_match_table.
> 
> (Not a critique of this patch, but merely a helpful comment; my previous
> ack remains intact) :-)
> 
> It would be useful for the code to point at some document that describes
> the semantics of the PRP0001 binding.

Well, we need to create that document in the first place. :-)

I'd prefer to wait with that until the thing settles, however.

Rafael

