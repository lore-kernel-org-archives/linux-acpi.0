From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [PATCH] dell-laptop: Fix rfkill state queries
Date: Fri, 31 Jul 2009 14:36:33 +0100
Message-ID: <20090731133633.GA3342@srcf.ucam.org>
References: <1249007138-27354-1-git-send-email-mjg@redhat.com> <4A72EF60.1090501@tpi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A72EF60.1090501-l6nL5VImRDY@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Gardner <timg-l6nL5VImRDY@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 31, 2009 at 07:19:28AM -0600, Tim Gardner wrote:

> This works on an Inspiron 1420 and XPS1330 as far as I was able to test.
> The physical rfkill switch sets 'Hard blocked: yes' for 'phy0: Wireless
> LAN', and everything returns to normal 'blocked: no' when the switch is
> disabled. I was not able to figure out how to get BIT(16) cleared. Is
> that a keyboard function? Anyways,

Might be Fn+F2.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
