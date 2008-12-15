From: Dan Williams <dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Fuijtsu Lifebook RFKILL support
Date: Mon, 15 Dec 2008 12:59:44 -0500
Message-ID: <1229363984.12163.114.camel@localhost.localdomain>
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
	 <1229354348.12163.20.camel@localhost.localdomain>
	 <1229361241.13400.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1229361241.13400.1.camel@localhost>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-MIcqEarIBAk@public.gmane.org
Cc: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ivo van Doorn <ivdoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jwoithe-JAjqph6Yjy+wq2+NMbbSVdf8k/1jCSAM@public.gmane.org, Peter Gruber <nokos-hi6Y0CQ0nG0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2008-12-15 at 17:14 +0000, Tony Vroon wrote:
> On Mon, 2008-12-15 at 10:19 -0500, Dan Williams wrote:
> > I plan to beat the shit out of the hal killswitch support pretty soon.
> > AFAIK it still doesn't know about softblock, which is part of the whole
> > reason for the rfkill rewrite in 2.6.26 anyway.  It also doesn't yet
> > (AFAIK) support uevents from killswitches either, which sucks.
> 
> Thanks Dan.
> Could you let me know when you've committed this code so I have another
> shot at implementing rfkill reporting in fujitsu-laptop?

Yeah, though the HAL support will be coded to the kernel rfkill devices,
so if the platform or the wifi driver supports the kernel rfkill
interface, the HAL bits should work.

> P.S. Did you get my e-mail about the Sierra Wireless MC8790?

Yes; it's hal-info commit 8912ec2b5d0a221a74156c047b18a26b2d916e13.

Dan


--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
