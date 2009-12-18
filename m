From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] dell-wmi - do not keep driver loaded on unsupported
	boxes
Date: Fri, 18 Dec 2009 14:28:22 +0000
Message-ID: <20091218142822.GB25150@srcf.ucam.org>
References: <20091218061941.GD21231@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53453 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133AbZLRO2e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2009 09:28:34 -0500
Content-Disposition: inline
In-Reply-To: <20091218061941.GD21231@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Thu, Dec 17, 2009 at 10:19:42PM -0800, Dmitry Torokhov wrote:
> There is no point in having the driver loaded in memory if we fail
> to locate particular WMI GUID.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
