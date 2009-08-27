From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 8] PM: Allow user space to change the power.async_suspend flag of devices
Date: Fri, 28 Aug 2009 00:24:06 +0200
Message-ID: <200908280024.06082.rjw@sisk.pl>
References: <200908262217.19609.rjw@sisk.pl> <200908272120.56021.rjw@sisk.pl> <20090827203634.372EC526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753389AbZH0WXJ@vger.kernel.org>
In-Reply-To: <20090827203634.372EC526EC9@mailhub.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday 27 August 2009, Dmitry Torokhov wrote:
> Hi Rafael,
> 
> On Thu, Aug 27, 2009 at 09:20:55PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Add sysfs attribute power/async for every device allowing the user
> > space to access the device's power.async_suspend flag and modify it,
> > if necessary.
> > 
> 
> I don't think we should let users meddle with individual devices;
> one global flag should be enough to work around "broken-at-the-moment"
> issues.

Well, this patch is handy for testing if anyone is interested, so I posted it.

It isn't exactly safe, though, you're right.

Thanks,
Rafael
