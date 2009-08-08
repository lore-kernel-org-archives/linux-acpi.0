From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 0/4] introduce device async actions mechanism
Date: Sat, 8 Aug 2009 14:53:34 +0200
Message-ID: <200908081453.34718.rjw@sisk.pl>
References: <1248404514.2670.107.camel@rzhang-dt> <200908080222.03172.rjw@sisk.pl> <20090808005922.110A3526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934155AbZHHMxR@vger.kernel.org>
In-Reply-To: <20090808005922.110A3526EA5@mailhub.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Saturday 08 August 2009, Dmitry Torokhov wrote:
> On Friday 07 August 2009 17:22:03 Rafael J. Wysocki wrote:
> > +       device_enable_async_pm(&i8042_platform_device->dev, true);
> > +
> 
> Please don't do that, at least not right now. i8042 being the fine
> piece of {soft,hard}ware as it is will not like when you start banging
> on all its ports at the same time.

Don't worry, this patch is only a prototype.

Best,
Rafael
