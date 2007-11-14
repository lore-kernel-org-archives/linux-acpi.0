From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 6/8] ACPI: video - properly handle errors when registering proc elements
Date: Wed, 14 Nov 2007 12:38:45 -0500
Message-ID: <200711141238.46006.lenb@kernel.org>
References: <20071105164328.982283020@anvil.corenet.prv> <20071105165012.564676221@anvil.corenet.prv> <1195024684.1262.47.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51857 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758173AbXKNRog (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 12:44:36 -0500
In-Reply-To: <1195024684.1262.47.camel@acpi-hp.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org

On Wednesday 14 November 2007 02:18, Zhang Rui wrote:
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

applied to test branch & queued for 2.6.25.  I'm okay with fixing it, but
it doesn't seem trivial enough and urgent enough for post 24-rc2.

thanks,
-len
