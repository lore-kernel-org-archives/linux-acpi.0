From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Subject: Re: [patch 9/9] acpi: fix NULL bug for HID/UID string
Date: Thu, 13 Aug 2009 17:46:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0908131724370.8831@sister.anvils>
References: <200908062257.n76MvuCr024266@imap1.linux-foundation.org>
 <Pine.LNX.4.64.0908070012490.11170@sister.anvils> <200908130955.03393.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mk-filter-1-a-1.mail.uk.tiscali.com ([212.74.100.52]:24232 "EHLO
	mk-filter-1-a-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753918AbZHMQqp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Aug 2009 12:46:45 -0400
In-Reply-To: <200908130955.03393.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: akpm@linux-foundation.org, lenb@kernel.org, linux-acpi@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Valdis.Kletnieks@vt.edu, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Thu, 13 Aug 2009, Bjorn Helgaas wrote:
> On Thursday 06 August 2009 05:18:12 pm Hugh Dickins wrote:
> > It's up to Len to choose, but I thought we preferred...
> > 
> > From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
> > 
> > acpi_device->pnp.hardware_id and unique_id are now allocated pointers,
> > replacing the previous arrays.  acpi_device_install_notify_handler()
> > oopsed on the NULL hid when probing the video device, 
> 
> I'm sorry I wasn't aware of the acpi_device_install_notify_handler()
> issue until just now, since I added the code that oopses (46ec8598fd).

Sorry for not Cc'ing you: but you can hardly be blamed for
not foreseeing future changes which might affect your code.

> 
> I recently posted patches that removed the dependency on the HID
> in this path:
> 
>   http://marc.info/?l=linux-acpi&m=124907623701270&w=2
> 
> I thought Len said they had been applied to acpi-test, but I don't
> see them there.
> 
> But I don't object to Hugh's patch, since it might be useful for other
> paths.

My original patch, when I hit the bug, was just to
acpi_device_install_notify_handler(): I have never seen a
problem anywhere else, and your patch would deal with that.

But Lin Ming believes there might be issues elsewhere (I have no idea),
posting a more general patch; then my patch here was a retort to that.

What I'm saying is: so far as I know, your patch is more appropriate
than mine; but probably Lin Ming knows better, and mine needed too.

Hugh
