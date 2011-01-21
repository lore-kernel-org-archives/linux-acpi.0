From: Thomas Renninger <trenn@suse.de>
Subject: Re: thermal: Avoid CONFIG_NET compile dependency
Date: Fri, 21 Jan 2011 13:12:16 +0100
Message-ID: <201101211312.16929.trenn@suse.de>
References: <D6D887BA8C9DFF48B5233887EF046541094482F511@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53277 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754403Ab1AUMMT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Jan 2011 07:12:19 -0500
In-Reply-To: <D6D887BA8C9DFF48B5233887EF046541094482F511@bgsmsx502.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday, January 21, 2011 11:52:39 AM R, Durgadoss wrote:
> Hi Len,
> 
> This patch from Thomas fixes the compile dependency.
> Looks fine as far as I have tested.
> 
> Could you please apply it on top of the old patch ?
I tried to not export thermal_netlink_event in #ifndef CONFIG_NET
case, but as it uses an enum which should only exist in CONFIG_NET
case it doesn't work out that easy...

Therefore please apply this one as it is.

Thanks,

   Thomas
