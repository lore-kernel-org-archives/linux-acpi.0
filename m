From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the
	hcd
Date: Tue, 10 Nov 2009 14:12:59 +0000
Message-ID: <20091110141259.GA19792@srcf.ucam.org>
References: <1257806610-6570-1-git-send-email-mjg@redhat.com> <200911100920.03361.oliver@neukum.org> <20091110124109.GA18631@srcf.ucam.org> <200911101408.01867.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200911101408.01867.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2009 at 02:08:01PM +0100, Oliver Neukum wrote:

> I was wondering because a tester has reported a race in ehci that
> can lead to a loss of wakeup events. Alan posted a patch to fix it.
> Does it cooperate with your patch?

Hm. I'll look into that.

> And secondly what happens if you suspend to RAM a system
> with suspended controllers?

I believe that this currently results in them being woken up and then 
whatever would normally happen, but would need to check to be sure. 
Rafael?

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
