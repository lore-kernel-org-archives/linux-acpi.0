From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD][PATCH 2/7] PM / QoS: Introduce request and constraint data types for PM QoS flags
Date: Sat, 29 Sep 2012 23:36:22 +0200
Message-ID: <201209292336.22960.rjw@sisk.pl>
References: <201209282351.10663.rjw@sisk.pl> <201209282352.49615.rjw@sisk.pl> <50668F01.7030406@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:51715 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577Ab2I2V3p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Sep 2012 17:29:45 -0400
In-Reply-To: <50668F01.7030406@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Huang Ying <ying.huang@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Jean Pihet <j-pihet@ti.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mark gross <markgross@thegnar.org>

On Saturday, September 29, 2012, Lan Tianyu wrote:
> On 2012/9/29 5:52, Rafael J. Wysocki wrote:
> > Index: linux/kernel/power/qos.c
> > ===================================================================
> > --- linux.orig/kernel/power/qos.c
> > +++ linux/kernel/power/qos.c
> > @@ -213,6 +213,69 @@ int pm_qos_update_target(struct pm_qos_c
> >   }
> >
> >   /**
> > + * pm_qos_flags_remove_req - Remove device PM QoS flags request.
> > + * @f: Device PM QoS flags set to remove the request from.
> -------^
> A typo     	
> > + * @req: Request to remove from the set.
> > + */

Yes, thanks!

Rafael
