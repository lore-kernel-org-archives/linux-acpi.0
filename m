From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 13145] New: Processor does not go below C2 if
 mouse (uhci) is plugged in.
Date: Wed, 22 Apr 2009 18:54:06 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904221848380.21119@localhost.localdomain>
References: <Pine.LNX.4.44L0.0904221050110.3405-100000@iolanthe.rowland.org>
 <200904221936.38942.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <200904221936.38942.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.smoczyk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, imrehg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is not a re-gression, it is a pro-gression:-)

In the CONFIG_CPU_IDLE=y case, there was a bug where we
would enter C3 even in the presence of bus master activity.
That bug was fixed by commit fc2e4009300088813c3be2de80b01ddc2399999e
"cpuidle: update the last_state acpi cpuidle reflecting actual state entered"

which shipped in 2.6.27

I've reproduced this issue on my t41, and when i revert the the
patch above from 2.6.27, we erroneously attempt to enter C3
in the face of bus master activity, just like we did in 2.6.25 and 2.6.26.

Note that the CONFIG_CPU_IDLE=n case never had this bug,
so you'd not see C3 with USB in that case even in older kernels.

Note also that /proc/acpi/processor/CPU/power does not
display any bus master activity for the CONFIG_CPU_IDLE=y
case, even when such activity is present.  Now that
CONFIG_CPU_IDLE=y for ACPI always, I think we should
simply delete that misleading field.

thanks,
Len Brown, Intel Open Source Technology Center

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
