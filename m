From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] ACPI: Fix resource_lock dead lock in acpi_power_on_device
Date: Fri, 14 Sep 2012 21:02:45 +0200
Message-ID: <201209142102.45814.rjw@sisk.pl>
References: <1347440853-12540-1-git-send-email-aaron.lu@intel.com> <50528516.2020002@intel.com> <50528695.2090602@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:54900 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756940Ab2INS4V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Sep 2012 14:56:21 -0400
In-Reply-To: <50528695.2090602@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Leb Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On Friday, September 14, 2012, Aaron Lu wrote:
> On 09/14/2012 09:15 AM, Aaron Lu wrote:
> >>
> >> Good catch, thanks.
> >>
> >> I hope Len won't mind if I take it for v3.6.
> >>
> > 
> > Yes, that would be good.
> > And the commit enters v3.4, so a stable tag may need be added.
> > 
> 
> On another thought, it may not be needed for pre v3.6 kernel as the only
> code that uses this interface appeared in v3.6-rc1.

I've added the -stable tag already.  It may be useful for backports and the
bug is real.

Thanks,
Rafael
