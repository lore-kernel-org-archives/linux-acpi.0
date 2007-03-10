From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 10/20] ACPI: ec: fix race in status register access
Date: Sat, 10 Mar 2007 02:34:32 -0500
Message-ID: <200703100234.33144.lenb@kernel.org>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985863491-git-send-email-len.brown@intel.com> <45F25E40.3040908@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43943 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933521AbXCJHfw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Mar 2007 02:35:52 -0500
In-Reply-To: <45F25E40.3040908@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

On Saturday 10 March 2007 02:29, Alexey Starikovskiy wrote:
> Len Brown wrote:
> > @@ -807,6 +812,7 @@ acpi_fake_ecdt_callback(acpi_handle handle,
> >  	acpi_status status;
> >  
> >  	mutex_init(&ec_ecdt->lock);
> > +	atomic_set(&ec->event_count, 1);
> >  	if (acpi_ec_mode == EC_INTR) {
> >  		init_waitqueue_head(&ec_ecdt->wait);
> >  	}
> >   
> here it should be ec_ecdt, not ec to make it compile...

yes, I found that out and re-checked it in, and modified
the ec-series above it to expect it.

thanks,
-Len
