From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 13145] New: Processor does not go below C2 if mouse (uhci) is plugged in.
Date: Wed, 22 Apr 2009 19:36:34 +0200
Message-ID: <200904221936.38942.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0904221050110.3405-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.0904221050110.3405-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.smoczyk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, imrehg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Mittwoch 22 April 2009 16:51:38 schrieb Alan Stern:
> On Tue, 21 Apr 2009, Andrew Morton wrote:
> > It looks like we need to revisit this - 2.6.26 worked OK, so why can't
> > 2.6.28?
>
> In fact the bug report says that 2.6.27 worked okay.

We don't know that. It is possible that USB always worked as expected
but ACPI's reporting of C states was broken and later fixed.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
