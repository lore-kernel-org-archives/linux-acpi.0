From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] ACPI: Fix up _PLD methods
Date: Mon, 12 Mar 2012 13:17:35 -0700
Message-ID: <20120312201735.GB24904@kroah.com>
References: <1331596735-3690-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65444 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188Ab2CLURk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Mar 2012 16:17:40 -0400
Received: by iagz16 with SMTP id z16so7319735iag.19
        for <linux-acpi@vger.kernel.org>; Mon, 12 Mar 2012 13:17:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1331596735-3690-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, lenb@kernel.org

On Mon, Mar 12, 2012 at 07:58:52PM -0400, Matthew Garrett wrote:
> _PLD is defined as returning a package of buffers, but many implementations
> simply return a buffer. Fix this up.
> 
> (Original patch by Bob Moore <robert.moore@intel.com>)
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/acpi/acpica/nsrepair.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

I think this series depends on your previous USB core patch, right?  If
so, I'd be glad to take all of these through the USB tree if I get an
ack from Len for the acpi portions.

Otherwise, feel free to take them through the acpi tree, they look good
to me:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


