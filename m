From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 13145] New: Processor does not go below C2 if
  mouse (uhci) is plugged in.
Date: Wed, 22 Apr 2009 12:39:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0904221202090.3405-100000@iolanthe.rowland.org>
References: <d7131a800904220809ha96c0e5rd366abfcbae4d1c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d7131a800904220809ha96c0e5rd366abfcbae4d1c2-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Smoczyk <daniel.smoczyk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, imrehg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 22 Apr 2009, Daniel Smoczyk wrote:

> On Wed, Apr 22, 2009 at 4:51 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLsd9G2dDO2Ms@public.gmane.org=
u> wrote:
>=20
> > In fact the bug report says that 2.6.27 worked okay.
>=20
> Not true, didn't tested 2.6.27 - there wasn't such one in debian repo=
s.

I'm going by the data in

	http://bugzilla.kernel.org/attachment.cgi?id=3D19780

which is attached to bug #12391.

> > However the changes to uhci-hcd between 2.6.27 and 2.6.28 are quite
> > minimal. =A0I can't see how any of them could have had this effect.=
 =A0It
> > must be due to a change somewhere else in the kernel.
>=20
> Could You please check 26 <-> 27? In my opinion uhci-hcd was able to
> autosuspend while mouse wasn't used in 2.6.26 and it isn't able to do
> autosuspend now ( C3 works ok after "rmmod uhci-hcd")

There was essentially no change to uhci-hcd between 2.6.26 and 2.6.27
(a static array definition got an added "const", that's all).

uhci-hcd has been able to autosuspend all along, provided no active
devices (like a mouse) are attached.  If you unplug the mouse and any
other USB devices attached to the UHCI controller under 2.6.28, it=20
should autosuspend.

But that's not what you were concerned about.  Your original bug=20
description said that the CPU wasn't going into C3 when the mouse _was_=
=20
attached.

> This situation is very similar to using usb memory stick non-stop,
> when watching move for eg. then processor also never goes below C2.

Whenever a USB device is attached and not suspended, the host=20
controller has to do DMA.  Older processors are not able to enter C3=20
while DMA is active.  So it would be good to verify whether your CPU is=
=20
actually capable of doing it.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
