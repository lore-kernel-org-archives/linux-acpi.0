From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 13145] New: Processor does not go below C2 if
	mouse (uhci) is plugged in.
Date: Wed, 22 Apr 2009 17:12:47 +0800
Message-ID: <20090422091247.GA28309@sli10-desk.sh.intel.com>
References: <bug-13145-10286@http.bugzilla.kernel.org/> <200904220022.18232.oliver@neukum.org> <20090421164910.43d94457@infradead.org> <200904221048.35180.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200904221048.35180.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Zhang, Rui" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Zhao, Yakui" <yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org" <bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org>, "bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org" <bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "daniel.smoczyk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <daniel.smoczyk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "imrehg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <imrehg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 22, 2009 at 04:48:30PM +0800, Oliver Neukum wrote:
> Am Mittwoch 22 April 2009 01:49:10 schrieb Arjan van de Ven:
> > On Wed, 22 Apr 2009 00:22:14 +0200
> >
> > Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org> wrote:
> > > Am Dienstag 21 April 2009 23:27:51 schrieb Andrew Morton:
> > > > (switched to email.  Please respond via emailed reply-to-all, not
> > > > via the bugzilla web interface).
> > > >
> > > > It looks like we need to revisit this - 2.6.26 worked OK, so why
> > > > can't 2.6.28?
> > >
> > > Not going into C3 without autosuspend is really expected.
> >
> > this is not correct; if the CPU supports "C2-popup", going to C3 is
> > expected.
> 
> Yes, that's possible. Does the system in question?
IIRC, C2-popup is supported since core architecture. The system (a T41)
is unlikely support this.

Thanks,
Shaohua
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
