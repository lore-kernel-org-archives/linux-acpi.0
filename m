From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [patch 6/8] ACPI: video - properly handle errors when
	registering proc elements
Date: Wed, 14 Nov 2007 11:36:17 -0200
Message-ID: <20071114133617.GA12655@khazad-dum.debian.net>
References: <20071105164328.982283020@anvil.corenet.prv> <20071105165012.564676221@anvil.corenet.prv> <1195024684.1262.47.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44880 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754477AbXKNNgW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 08:36:22 -0500
Content-Disposition: inline
In-Reply-To: <1195024684.1262.47.camel@acpi-hp.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Wed, 14 Nov 2007, Zhang Rui wrote:
> On Tue, 2007-11-06 at 00:43 +0800, Dmitry Torokhov wrote:
> > ACPI: video - properly handle errors when registering proc elements
> > 
> > Have acpi_video_device_add_fs() and acpi_video_bus_add_fs()
> > properly unwind proc creation after error.
> Hi, Dmitry,
> 
> The patch is good.
> But I'm afraid we don't need this patch while we are trying to remove
> the proc I/F for all ACPI device drivers.

IMHO, until procfs is gone for good, it is best to make sure it works
perfectly.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
