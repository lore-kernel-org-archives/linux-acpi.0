From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] acpi: Don't send KEY_UNKNOWN for random video
 notifications
Date: Fri, 02 Apr 2010 09:05:40 +0800
Message-ID: <1270170340.24064.4503.camel@rzhang1-desktop>
References: <1260571246-24582-1-git-send-email-mjg@redhat.com>
	 <alpine.LFD.2.00.1003312057140.5062@localhost.localdomain>
	 <1270105073.24064.4488.camel@rzhang1-desktop>
	 <20100401123227.GA4312@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37479 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754266Ab0DBBEi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Apr 2010 21:04:38 -0400
In-Reply-To: <20100401123227.GA4312@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2010-04-01 at 20:32 +0800, Matthew Garrett wrote:
> On Thu, Apr 01, 2010 at 02:57:53PM +0800, Zhang Rui wrote:
> 
> > can you attach the acpidump of your laptop please?
> 
> Afraid not - it's prototype hardware.
> 
that's okay. The patch looks good.
I just want to see why notification 0xD1 is sent out.

Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui


