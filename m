From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: Fuijtsu Lifebook RFKILL support
Date: Sat, 13 Dec 2008 11:28:57 -0200
Message-ID: <20081213132857.GA11428@khazad-dum.debian.net>
References: <1228957506.4045.11.camel@localhost> <20081211165247.GA4844@khazad-dum.debian.net> <1229016827.6446.6.camel@localhost> <20081211194734.GA18132@khazad-dum.debian.net> <1229046602.4030.13.camel@localhost> <20081212195331.GA12679@khazad-dum.debian.net> <alpine.LFD.2.00.0812121532580.4064@localhost.localdomain> <1229172465.4010.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1229172465.4010.11.camel@localhost>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Vroon <tony-MIcqEarIBAk@public.gmane.org>
Cc: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ivo van Doorn <ivdoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jwoithe-JAjqph6Yjy+wq2+NMbbSVdf8k/1jCSAM@public.gmane.org, Peter Gruber <nokos-hi6Y0CQ0nG0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 13 Dec 2008, Tony Vroon wrote:
> > What is the WLAN driver involved? Is it rfkill-aware?
> 
> The driver is iwlagn, which does indeed notice that it is killed.
> This information does not reach NetworkManager. Relevant log
> entries: Dec 12 00:59:01 amalthea iwlagn: Radio Frequency Kill
> Switch is On: Dec 12 00:59:01 amalthea Kill switch must be turned
> off for wireless networking to work.

Then, it is just a matter of time for it to be working correctly.  In
fact, it might already be if you use wireless-testing and latest
network manager.

Best not to mess with it, any workarounds one adds would just get in
the way in the future.

> [cutting relevant pieces of text together]
> > > 1. rfkill actualy is/looks like a hotplug/hotunplug operation
> > >   1b. You cannot do it at will
> > >       Attaching it to the rfkill core simply is not supported
> 
> Okay, both Bluetooth & WWAN are USB devices following this terminology.
> So the rfkill framework is not an appropriate tool for this job,
> understood.
> 
> Len, I would still like to export the 3 values learned about in this
> event to userspace. Is it alright for me to create 3 read-only files on
> the platform device? (docked, lid, radios)
> It would if anything simplify the code.

FWIW, I think this is also the way to go.  It is much easier for
userspace to deal with sysfs attributes.  HAL can deal with more
complex stuff, but shell script writers often don't know how to, nor
care to, deal with HAL.

BTW, this also means that it is helpful to shell script writers if you
also export through read-only sysfs attributes the state of any input
devices generating EV_SW.  The input layer makes it possible to query
the switch state easily... through IOCTL after you find out the
correct input device(s) to query.  Which ain't easy for shell script,
and nobody wrote a "inputdev" helper in a proper language that can do
it, for shell script writers to call.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
