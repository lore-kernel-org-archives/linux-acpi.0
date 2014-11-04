From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v6 04/12] misc: at25: Make use of device property API
Date: Tue, 4 Nov 2014 18:07:35 +0200
Message-ID: <20141104160735.GO1618@lahna.fi.intel.com>
References: <13750506.S2yVlRRDa2@vostro.rjw.lan>
 <20141104143801.GM1618@lahna.fi.intel.com>
 <CACxGe6u5ppSjHc-Wa7K_NWQ9YEZ_V3ys9fdsECss_bPabUTN+g@mail.gmail.com>
 <4645043.WOkgNMSUuO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4645043.WOkgNMSUuO-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Darren Hart <darren.hart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 04, 2014 at 05:19:02PM +0100, Rafael J. Wysocki wrote:
> > > I think np->name is "at25" in this case? The binding file
> > > Documentation/devicetree/bindings/misc/at25.txt also has the same name.
> > >
> > > Are you OK, if we add something like below to the changelog?
> > >
> > >  In addition we hard-code the name of the chip to be "at25" for the
> > >  reason that there is no common mechanism to fetch name of the firmware
> > >  node. The only existing user (arch/arm/boot/dts/phy3250.dts) uses the
> > >  same name so it should continue to work.
> > 
> > Yes. If somebody complains, then we can reinstate the previous
> > behaviour, but assume it isn't necessary for now.
> 
> OK, done in my tree. 

Thanks Rafael!
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
