From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 13145] New: Processor does not go below C2 if
 mouse (uhci) is plugged in.
Date: Tue, 21 Apr 2009 14:27:51 -0700
Message-ID: <20090421142751.b030cba7.akpm@linux-foundation.org>
References: <bug-13145-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bug-13145-10286-V0hAGp6uBxO456/isadD/XN4h3HLQggn@public.gmane.org/>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.smoczyk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, imrehg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

It looks like we need to revisit this - 2.6.26 worked OK, so why can't
2.6.28?

Thanks.


On Tue, 21 Apr 2009 19:53:13 GMT
bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=13145
> 
>            Summary: Processor does not go below C2 if mouse (uhci) is
>                     plugged in.
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.29
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: USB
>         AssignedTo: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
>         ReportedBy: daniel.smoczyk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>         Regression: Yes
> 
> 
> Created an attachment (id=21071)
>  --> (http://bugzilla.kernel.org/attachment.cgi?id=21071)
> lsusb -v
> 
> Latest working kernel version:
> 2.6.26-13
> 
> Earliest failing kernel version:
> 2.6.28
> 
> Distribution:
> Debian Sid
> 
> Hardware Environment:
> IBM Thinkpad T41 Pentium M
> 
> Problem Description:
> In 2.6.28(29) kernel, when I plug in usb logitech mouse, regression in uhci (I
> assume it's usb uhci driver) forces processor to operate in C2 state (reported
> by powertop 1.11). When I plug it off, everything back to normal - 100% C3 in
> idle. In 2.6.26 kernel processor normally goes down to C3 when mouse is plugged
> in.
> 
> I think this problem was already reported in this bug [1] and closed without
> proper investigation. Arjan van de Ven stated that "When USB is used C3 cannot
> be entered" argument isn't correct [2].
> 
> I'll provide any additional debug data if needed.
> 
> [1] http://bugzilla.kernel.org/show_bug.cgi?id=12391
> [2] http://www.bughost.org/pipermail/power/2009-March/001617.html
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
