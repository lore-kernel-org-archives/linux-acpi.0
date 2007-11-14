From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 6/8] ACPI: video - properly handle errors when registering proc elements
Date: Wed, 14 Nov 2007 10:06:53 -0500
Message-ID: <d120d5000711140706m4a311175i89081c36fb439a5@mail.gmail.com>
References: <20071105164328.982283020@anvil.corenet.prv>
	 <20071105165012.564676221@anvil.corenet.prv>
	 <1195024684.1262.47.camel@acpi-hp.sh.intel.com>
	 <20071114133617.GA12655@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:41720 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312AbXKNPG4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Nov 2007 10:06:56 -0500
Received: by nf-out-0910.google.com with SMTP id g13so181557nfb
        for <linux-acpi@vger.kernel.org>; Wed, 14 Nov 2007 07:06:54 -0800 (PST)
In-Reply-To: <20071114133617.GA12655@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhang Rui <rui.zhang@intel.com>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On 11/14/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> On Wed, 14 Nov 2007, Zhang Rui wrote:
> > On Tue, 2007-11-06 at 00:43 +0800, Dmitry Torokhov wrote:
> > > ACPI: video - properly handle errors when registering proc elements
> > >
> > > Have acpi_video_device_add_fs() and acpi_video_bus_add_fs()
> > > properly unwind proc creation after error.
> > Hi, Dmitry,
> >
> > The patch is good.
> > But I'm afraid we don't need this patch while we are trying to remove
> > the proc I/F for all ACPI device drivers.
>
> IMHO, until procfs is gone for good, it is best to make sure it works
> perfectly.
>

That is my position as well. The removal is scheduled for July 2008
which is 9 months out.

-- 
Dmitry
