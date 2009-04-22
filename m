From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 13145] New: Processor does not go below C2 if
 mouse (uhci) is plugged in.
Date: Wed, 22 Apr 2009 14:35:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904221431330.6187@localhost.localdomain>
References: <bug-13145-10286@http.bugzilla.kernel.org/>
 <200904220022.18232.oliver@neukum.org> <20090421164910.43d94457@infradead.org>
 <200904221048.35180.oliver@neukum.org>
 <20090422091247.GA28309@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20090422091247.GA28309-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Zhang, Rui" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Zhao, Yakui" <yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org" <bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org>, "bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org" <bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "daniel.smoczyk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <daniel.smoczyk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "imrehg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <imrehg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


> IIRC, C2-popup is supported since core architecture. The system (a T41)
> is unlikely support this.

The T41 is an ICH4M, Pentium M system.
C2 popup was not supported until ICH6M.

Thus, when USB is active, this system should detect bus master 
activity (as displayed in /proc/acpi/processor/CPU/power)
and should not enter C3 when such activity is (recently) present.

Len Brown, Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
