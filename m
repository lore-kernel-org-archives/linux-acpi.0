From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Resend PATCH V2 3/7] usb: Set device removable state based on
 ACPI USB data
Date: Mon, 7 May 2012 09:57:44 -0700
Message-ID: <20120507165744.GA28045@kroah.com>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com>
 <1336100803-28353-4-git-send-email-tianyu.lan@intel.com>
 <201205040824.17010.oneukum@suse.de>
 <4FA72787.5000106@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35090 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757383Ab2EGQ5u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 May 2012 12:57:50 -0400
Received: by pbbrp8 with SMTP id rp8so6901191pbb.19
        for <linux-acpi@vger.kernel.org>; Mon, 07 May 2012 09:57:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FA72787.5000106@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Oliver Neukum <oneukum@suse.de>, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com, Matthew Garrett <mjg@redhat.com>

On Mon, May 07, 2012 at 09:38:15AM +0800, Lan Tianyu wrote:
> On 2012=E5=B9=B405=E6=9C=8804=E6=97=A5 14:24, Oliver Neukum wrote:
> >Am Freitag, 4. Mai 2012, 05:06:39 schrieb Lan Tianyu:
> >>
> >>From: Matthew Garrett<mjg@redhat.com>
> >>
> >>ACPI offers two methods that allow us to infer whether or not a USB=
 port
> >>is removable. The _PLD method gives us information on whether the p=
ort is
> >>"user visible" or not. If that's not present then we can fall back =
to the
> >>_UPC method which tells us whether or not a port is connectable.
> >
> >How does this act on bluetooth devices that are (dis)connected by sw=
itches
> >on laptops?
> This depends on the bios. From my opinion, the bluetooth is device on=
 the
> motherboard so it belongs to hard-wired type.

That's nice, but it's not what is happening in lots of different laptop=
s
out there today.

Oliver is right, how does this handle bluetooth USB controllers that ar=
e
turned on/off from magic function-key presses?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
