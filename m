From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/6] PM: Allow serio input devices to suspend/resume asynchronously
Date: Thu, 27 Aug 2009 22:58:35 +0200
Message-ID: <200908272258.35861.rjw@sisk.pl>
References: <200908262217.19609.rjw@sisk.pl> <200908262224.19110.rjw@sisk.pl> <20090827204106.1132B526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41278 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714AbZH0U6G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Aug 2009 16:58:06 -0400
In-Reply-To: <20090827204106.1132B526EC9@mailhub.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Linux PCI <linux-pci@vger.kernel.org>

On Thursday 27 August 2009, Dmitry Torokhov wrote:
> On Wed, Aug 26, 2009 at 10:24:19PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Set async_suspend for all serio input devices, so that they can be
> > suspended and resumed asynchronously with other devices they don't
> > depend on in a known way (i.e. devices which are not their parents
> > or children and to which they are not connected via struct pm_link
> > objects).
> > 
> 
> As I mentioned not yet, please - i8042 may be unhappy if you pound
> all its ports at once. I should have a solution for it though.

OK, I'll drop this patch.

Thanks,
Rafael
