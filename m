From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] ACPI Video: Ignore devices that aren't present in hardware
Date: Fri, 4 Jul 2008 11:18:06 +0100
Message-ID: <20080704101806.GA9676@srcf.ucam.org>
References: <200807031805.52883.trenn@suse.de> <200807031815.13291.trenn@suse.de> <20080703161643.GB29110@srcf.ucam.org> <200807041208.04466.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33064 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbYGDKSL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jul 2008 06:18:11 -0400
Content-Disposition: inline
In-Reply-To: <200807041208.04466.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Julia Jomantaite <julia.jomantaite@gmail.com>, marcus@better.se, dannybaumann@web.de, corsac@debian.org

On Fri, Jul 04, 2008 at 12:08:02PM +0200, Thomas Renninger wrote:

> Hmm, there might be IGD devices that could just work with the default 
> backlight functions...
> Your hint in the other mail to check for tche flag is  a good one..

There are IGD devices that just work with the default functions. I'm 
using one.

> As soon as your parts are finished we can easily remove the
> ACPI_VIDEO_IGD
> and add these graphics devices to the one which should be served by your 
> modifications.

As I said, your patches (in their current form) *will* break systems 
that currently work, and a quick check seems to indicate that that 
includes my machine. 

> Please explain me again why this should not go in before/with your patches.
> If we agree that this one (or a similar solution) makes sense I am going to 
> post a 2nd version soon and then I can help a bit with the 750 ms issue...

The first patch should go in with the opregion code. The second patch 
should go in without the IGD code. Can we please just fix this the right 
way?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
