From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: 2.6.0-test2: Lost USB mouse after resuming from S3
Date: Wed, 6 Aug 2003 14:39:41 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030806213941.GA7618@kroah.com>
References: <200308070037.31630.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200308070037.31630.mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
To: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 07, 2003 at 12:37:31AM +0800, Michael Frank wrote:
> Causes are that usb-host controller does no handle S3 yet _plus_
> possibly (depending on your hardware) loss of PCI interrupt links as
> current ACPI does not resume those.

Known issue, please unload the usb modules before suspending them.

The upcoming suspend patches will allow us to fix this "properly",
please give us a few weeks :)

thanks,

greg k-h
