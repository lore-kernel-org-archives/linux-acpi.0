From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] check that acpi_wakeup_address is below 1MB v2
Date: Fri, 11 Apr 2008 17:12:23 +0200
Message-ID: <200804111712.24233.rjw@sisk.pl>
References: <47FE87B0.7080709@free.fr> <1207907709.9448.19.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55683 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760314AbYDKPMS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Apr 2008 11:12:18 -0400
In-Reply-To: <1207907709.9448.19.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: matthieu castet <castet.matthieu@free.fr>, linux-acpi@vger.kernel.org

On Friday, 11 of April 2008, Zhao Yakui wrote:
> On Thu, 2008-04-10 at 23:33 +0200, matthieu castet wrote:
> > Hi,
> > 
> > this patch add a check that the memory allocated for s3 wakeup is in the 
> > first 1MB as required by acpi spec.
> > 
> Have you found whether some systems are afflicted by this ?
> 
> In fact that OS allacates the acpi_wake_address follows the below two
> functions:
> reserve_bootmem(0, PAGE_SIZE, BOOTMEM_DEFAULT);
> reserve_bootmem(PAGE_SIZE, PAGE_SIZE, BOOTMEM_DEFAULT);
> 
> The above mechanism can insure that the acpi_wake_address is in memroy
> below 1M. (It is unncessary to apply the patch. IMO)

Agreed.
 
> Of course the addressing check will be more strict after this patch is
> applied.

Matthieu, can you please explain why you consider the patch as necessary?

Thanks,
Rafael
