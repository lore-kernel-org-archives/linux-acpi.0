From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC][PATCH 0/3] ACPI / PM: Export power resources information
 to user space
Date: Sun, 20 Jan 2013 15:37:35 -0800
Message-ID: <20130120233735.GA7449@kroah.com>
References: <3307415.pdOY6ovZLa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:41819 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab3ATXhj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Jan 2013 18:37:39 -0500
Received: by mail-pb0-f53.google.com with SMTP id un1so2311882pbc.26
        for <linux-acpi@vger.kernel.org>; Sun, 20 Jan 2013 15:37:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3307415.pdOY6ovZLa@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Kristen C. Accardi" <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>

On Sun, Jan 20, 2013 at 03:51:40PM +0100, Rafael J. Wysocki wrote:
> Hi Greg,
> 
> The following patch series is about exporting ACPI power resources to user
> space that will be necessary for PM diagnostics on new platforms (powertop is
> the target).  Still, existing systems can also benefit from that, like my
> oldish HP nx6325 on which the patches have been tested.
> 
> Patch [1/3] shouldn't be really controverisal, as it only makes it possible
> to read power resources' reference counters from user space in a quite
> straightforward way.

You need to add a Documentation/ABI/ entry for the new file you created
here.  Same thing for 3/3, which will help me understand exactly what
you are trying to do here with sysfs.  Care to update that so I can try
to figure out if the sysfs code is correct?

thanks,

greg k-h
