From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH]: add parameter "struct bin_attribute *" in
	.read/.write methods for sysfs binary attributes
Date: Thu, 14 Jun 2007 01:38:43 -0700
Message-ID: <20070614083843.GA7794@kroah.com>
References: <1181208695.5317.2.camel@localhost.localdomain> <20070608145237.GA6560@kroah.com> <1181368642.6587.0.camel@localhost.localdomain> <200706132135.44949.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:34776 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbXFNIhH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jun 2007 04:37:07 -0400
Content-Disposition: inline
In-Reply-To: <200706132135.44949.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Wed, Jun 13, 2007 at 09:35:44PM -0400, Len Brown wrote:
> I've applied this to acpi-test with an Acked-by: gregkh -- as we need it
> for the acpi table patch.
> 
> Greg, unless I hear from you, I'll assume that this is okay for 2.6.23.

It's fine with me, you can add a real:
	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

to it too.

thanks,

greg k-h
