From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 6/8] ACPI: video - properly handle errors when registering proc elements
Date: Wed, 14 Nov 2007 12:22:45 -0500
Message-ID: <200711141222.45408.lenb@kernel.org>
References: <20071105164328.982283020@anvil.corenet.prv> <20071114133617.GA12655@khazad-dum.debian.net> <d120d5000711140706m4a311175i89081c36fb439a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51836 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756883AbXKNRoX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 12:44:23 -0500
In-Reply-To: <d120d5000711140706m4a311175i89081c36fb439a5@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Wednesday 14 November 2007 10:06, Dmitry Torokhov wrote:
> On 11/14/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> > On Wed, 14 Nov 2007, Zhang Rui wrote:
> > > On Tue, 2007-11-06 at 00:43 +0800, Dmitry Torokhov wrote:
> > > > ACPI: video - properly handle errors when registering proc elements
> > > >
> > > > Have acpi_video_device_add_fs() and acpi_video_bus_add_fs()
> > > > properly unwind proc creation after error.
> > > Hi, Dmitry,
> > >
> > > The patch is good.
> > > But I'm afraid we don't need this patch while we are trying to remove
> > > the proc I/F for all ACPI device drivers.
> >
> > IMHO, until procfs is gone for good, it is best to make sure it works
> > perfectly.
> >
> 
> That is my position as well. The removal is scheduled for July 2008
> which is 9 months out.

Agreed.
While we don't want to add (and support) any new /proc features,
unwinding from errors properly with the existing features
seems like a good idea.

thanks,
-Len

