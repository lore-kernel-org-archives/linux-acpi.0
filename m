From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 7 updated] PM: Add a switch for disabling/enabling asynchronous suspend/resume
Date: Fri, 28 Aug 2009 21:42:05 +0200
Message-ID: <200908282142.05812.rjw@sisk.pl>
References: <200908262217.19609.rjw@sisk.pl> <200908280022.40522.rjw@sisk.pl> <20090828055520.E561A526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090828055520.E561A526EC9@mailhub.coreip.homeip.net>
Sender: linux-pci-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 28 August 2009, Dmitry Torokhov wrote:
> On Fri, Aug 28, 2009 at 12:22:40AM +0200, Rafael J. Wysocki wrote:
> > +/* kernel/power/main.c */
> > +extern int pm_async_enabled;
> >  
> 
> Sorry, forgot about this in the first mail - why don't we make it a
> bool?

I didn't do that because of the

sprintf(buf, "%d\n", pm_async_enabled)

in pm_async_show(), where it clearly is treated as an int.

Thanks,
Rafael
