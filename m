From: "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Subject: Re: hints an infos to start debuging on hp-wmi
Date: Mon, 11 May 2009 08:48:55 -0400
Message-ID: <20090511124855.GA2721@tuxdriver.com>
References: <gu4g0g$s1e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <gu4g0g$s1e$1@ger.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: feldmaus <feldmann_markus-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, May 09, 2009 at 07:55:13PM +0200, feldmaus wrote:

> i had many trouble with the wlan card of my girl friends HP zv5265ea
> Laptop. It is a BCM4303 Wlan Card. The Problem i think is the
> hp-wmi driver, so i want to debug it.

Is the problem related to RF-Kill?  If not, then hp-wmi is probably
not the best place to start...

> It would be nice if someody gives me a start point how to ?
> I currently using the 2.6.29-rc7 kernel sources.
> Which sources or header files do i have to modify ?

./drivers/platform/x86/hp-wmi.c

> Are there any developers documentation for the hp-wmi ?

No idea...

Good luck!

John
-- 
John W. Linville		Someday the world will need a hero, and you
linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org			might be all we have.  Be ready.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
