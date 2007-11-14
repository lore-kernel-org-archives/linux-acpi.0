From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] pci hotplug: fix rpaphp directory naming
Date: Tue, 13 Nov 2007 19:26:07 -0800
Message-ID: <20071114032607.GA22438@kroah.com>
References: <20071114003455.GD8509@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:34640 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbXKND0A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Nov 2007 22:26:00 -0500
Content-Disposition: inline
In-Reply-To: <20071114003455.GD8509@austin.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: gregkh@suse.de, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, strosake@us.ibm.com, Alex Chiang <achiang@hp.com>, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, lenb@kernel.org, rick.jones2@hp.com, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org, linuxppc-dev@ozlabs.org

On Tue, Nov 13, 2007 at 06:34:55PM -0600, Linas Vepstas wrote:
> 
> 
> Fix presentation of the slot number in the /sys/bus/pci/slots
> directory to match that used in the majority of other drivers.

We need a signed-off-by: to be able to apply this...

thanks,

greg k-h
