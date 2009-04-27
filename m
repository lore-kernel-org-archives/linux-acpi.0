From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: s2ram on Lenovo X300 is broken
Date: Tue, 28 Apr 2009 00:07:57 +0200
Message-ID: <200904280007.58150.rjw@sisk.pl>
References: <6D80BDFB1A1FA74DA476417C24C452A102495C8361@scl-exch2k7.phoenix.com> <200904272232.25666.rjw@sisk.pl> <6D80BDFB1A1FA74DA476417C24C452A102495C8555@scl-exch2k7.phoenix.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53476 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755553AbZD0WIk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Apr 2009 18:08:40 -0400
In-Reply-To: <6D80BDFB1A1FA74DA476417C24C452A102495C8555@scl-exch2k7.phoenix.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kaushik Barde <Kaushik_Barde@phoenix.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>

On Monday 27 April 2009, Kaushik Barde wrote:
> I will try it, is there something different about suspend ordering/hotplug in 2.6.30-rc3?

Yes, there is.  Non-boot CPUs are now disabled after the late suspend of
devices and they are enabled before the early suspend of devices.

Thanks,
Rafael

 
> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@sisk.pl] 
> Sent: Monday, April 27, 2009 1:32 PM
> To: Kaushik Barde
> Cc: linux-acpi@vger.kernel.org
> Subject: Re: s2ram on Lenovo X300 is broken
> 
> On Monday 27 April 2009, Kaushik Barde wrote:
> > I tried with both stable 2.6.28.9 and 2.6.29.1, and yes, issue is reproducible.
> 
> I thought of 2.6.30-rc3 (or later).
