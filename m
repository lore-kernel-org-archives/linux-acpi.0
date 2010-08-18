From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 3/8] ideapad: make sure we bind on the correct device
Date: Wed, 18 Aug 2010 14:27:22 +0100
Message-ID: <20100818132722.GA12709@srcf.ucam.org>
References: <1282120564-11324-1-git-send-email-ike.pan@canonical.com> <1282120653-11434-1-git-send-email-ike.pan@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60829 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab0HRN1g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Aug 2010 09:27:36 -0400
Content-Disposition: inline
In-Reply-To: <1282120653-11434-1-git-send-email-ike.pan@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Corentin Chary <corentincj@iksaif.net>, David Woodhouse <David.Woodhouse@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>

On Wed, Aug 18, 2010 at 04:37:33PM +0800, Ike Panhc wrote:
> By reading from method _STA and _CFG to make sure we bind on the correct
> VPC2004 device.

I know some other drivers check _STA themselves, but it's unnecessary - 
if _STA didn't evaluate appropriately, the bus driver won't create the 
pnp object and there won't be anything for you to bind to in the first 
place.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
