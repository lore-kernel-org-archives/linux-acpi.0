From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the
	hcd
Date: Tue, 10 Nov 2009 12:41:09 +0000
Message-ID: <20091110124109.GA18631@srcf.ucam.org>
References: <1257806610-6570-1-git-send-email-mjg@redhat.com> <200911100920.03361.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200911100920.03361.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2009 at 09:20:03AM +0100, Oliver Neukum wrote:

> Extremely cool. However it makes me wonder about remote wakeup.
> Do you know whether that works?

It certainly seems to on Intel hardware. I haven't tested anything else 
yet.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
