From: Dan Williams <dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Fuijtsu Lifebook RFKILL support
Date: Mon, 15 Dec 2008 10:19:08 -0500
Message-ID: <1229354348.12163.20.camel@localhost.localdomain>
References: <1228957506.4045.11.camel@localhost>
	 <20081211165247.GA4844@khazad-dum.debian.net>
	 <1229016827.6446.6.camel@localhost>
	 <20081211194734.GA18132@khazad-dum.debian.net>
	 <1229046602.4030.13.camel@localhost>
	 <20081212195331.GA12679@khazad-dum.debian.net>
	 <alpine.LFD.2.00.0812121532580.4064@localhost.localdomain>
	 <1229172465.4010.11.camel@localhost>
	 <20081213132857.GA11428@khazad-dum.debian.net>
	 <1229274343.6775.15.camel@localhost.localdomain>
	 <20081215115336.GD17648@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081215115336.GD17648-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Tony Vroon <tony-MIcqEarIBAk@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ivo van Doorn <ivdoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jwoithe-JAjqph6Yjy+wq2+NMbbSVdf8k/1jCSAM@public.gmane.org, Peter Gruber <nokos-hi6Y0CQ0nG0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2008-12-15 at 09:53 -0200, Henrique de Moraes Holschuh wrote:
> On Sun, 14 Dec 2008, Dan Williams wrote:
> > On Sat, 2008-12-13 at 11:28 -0200, Henrique de Moraes Holschuh wrote:
> > > On Sat, 13 Dec 2008, Tony Vroon wrote:
> > > > > What is the WLAN driver involved? Is it rfkill-aware?
> > > > 
> > > > The driver is iwlagn, which does indeed notice that it is killed.
> > > > This information does not reach NetworkManager. Relevant log
> > > > entries: Dec 12 00:59:01 amalthea iwlagn: Radio Frequency Kill
> > > > Switch is On: Dec 12 00:59:01 amalthea Kill switch must be turned
> > > > off for wireless networking to work.
> > > 
> > > Then, it is just a matter of time for it to be working correctly.  In
> > > fact, it might already be if you use wireless-testing and latest
> > > network manager.
> > 
> > If HAL's killswitch support doesn't know about the kernel killswitch
> > device, or it cannot get the state of the killswitch, then certainly
> > NetworkManager isn't going to know about it.
> 
> I see.  I have added "up-to-date HAL also required" to my mental list of
> stuff needed in userspace.

I plan to beat the shit out of the hal killswitch support pretty soon.
AFAIK it still doesn't know about softblock, which is part of the whole
reason for the rfkill rewrite in 2.6.26 anyway.  It also doesn't yet
(AFAIK) support uevents from killswitches either, which sucks.

Dan


--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
