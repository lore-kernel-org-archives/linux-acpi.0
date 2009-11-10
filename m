From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the hcd
Date: Tue, 10 Nov 2009 14:08:01 +0100
Message-ID: <200911101408.01867.oliver@neukum.org>
References: <1257806610-6570-1-git-send-email-mjg@redhat.com> <200911100920.03361.oliver@neukum.org> <20091110124109.GA18631@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091110124109.GA18631-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Dienstag, 10. November 2009 13:41:09 schrieben Sie:
> On Tue, Nov 10, 2009 at 09:20:03AM +0100, Oliver Neukum wrote:
> > Extremely cool. However it makes me wonder about remote wakeup.
> > Do you know whether that works?
> 
> It certainly seems to on Intel hardware. I haven't tested anything else
> yet.

I was wondering because a tester has reported a race in ehci that
can lead to a loss of wakeup events. Alan posted a patch to fix it.
Does it cooperate with your patch?
And secondly what happens if you suspend to RAM a system
with suspended controllers?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
