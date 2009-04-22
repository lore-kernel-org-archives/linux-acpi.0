From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 13145] New: Processor does not go below C2 if
 mouse (uhci) is plugged in.
Date: Wed, 22 Apr 2009 10:51:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0904221050110.3405-100000@iolanthe.rowland.org>
References: <20090421142751.b030cba7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090421142751.b030cba7.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.smoczyk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, imrehg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 21 Apr 2009, Andrew Morton wrote:

> It looks like we need to revisit this - 2.6.26 worked OK, so why can't
> 2.6.28?

In fact the bug report says that 2.6.27 worked okay.

However the changes to uhci-hcd between 2.6.27 and 2.6.28 are quite 
minimal.  I can't see how any of them could have had this effect.  It 
must be due to a change somewhere else in the kernel.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
