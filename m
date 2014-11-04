From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v6 04/12] misc: at25: Make use of device property API
Date: Tue, 4 Nov 2014 16:38:01 +0200
Message-ID: <20141104143801.GM1618@lahna.fi.intel.com>
References: <13750506.S2yVlRRDa2@vostro.rjw.lan>
 <5019278.RtDq7RlWqt@vostro.rjw.lan>
 <20141104141826.36F8AC408F6@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141104141826.36F8AC408F6-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Darren Hart <darren.hart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 04, 2014 at 02:18:26PM +0000, Grant Likely wrote:
> > -	strncpy(chip->name, np->name, sizeof(chip->name));
> > +	strncpy(chip->name, "at25", sizeof(chip->name));
> 
> This line changes behaviour of the driver. It's possibly not a problem,
> but it should be commented on and whether any due diligance has been
> done to make sure it there isn't anything that depends on it.

I found only one user for "atmel,at25" in any of the DT sample files.

arch/arm/boot/dts/phy3250.dts:

	eeprom: at25@0 {
		...
		at25,byte-len = <0x8000>;
		at25,addr-mode = <2>;
		at25,page-size = <64>;

		compatible = "atmel,at25";
		reg = <0>;
		spi-max-frequency = <5000000>;
	};

I think np->name is "at25" in this case? The binding file
Documentation/devicetree/bindings/misc/at25.txt also has the same name.

Are you OK, if we add something like below to the changelog?

 In addition we hard-code the name of the chip to be "at25" for the
 reason that there is no common mechanism to fetch name of the firmware
 node. The only existing user (arch/arm/boot/dts/phy3250.dts) uses the
 same name so it should continue to work.

> Otherwise:
> Acked-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
