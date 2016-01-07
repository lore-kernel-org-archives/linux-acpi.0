From: Vishal Verma <vishal@kernel.org>
Subject: Re: [PATCH] nfit: add a module parameter to ignore ars errors
Date: Wed, 06 Jan 2016 20:01:57 -0700
Message-ID: <1452135717.23678.2.camel@kernel.org>
References: <1451946883-28092-1-git-send-email-vishal.l.verma@intel.com>
	 <568D4AE6.5020601@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52090 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbcAGDCB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Jan 2016 22:02:01 -0500
In-Reply-To: <568D4AE6.5020601@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linda Knippers <linda.knippers@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>, linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org

On Wed, 2016-01-06 at 12:12 -0500, Linda Knippers wrote:
> On 1/4/2016 5:34 PM, Vishal Verma wrote:
> > Normally, if a platform does not advertise support for Address
> > Range
> > Scrub (ARS), we skip it. But if ARS is advertised, it is expected
> > to
> > always succeed. If it fails, we normally fail initialization at
> > that
> > point.
> > 
> > Add a module parameter to nfit that lets it ignore ARS failures and
> > continue with initialization for debugging.
> 
> Could ARS be so broken that you might want to just ignore it
> altogether
> and not even make the requests?
> 

That is a possibility, and I considered it, but I thought it might be
better to see how it fails and then just ignore the errors..
It boils down to how much we trust the firmware, and hopefully if it
advertises ARS as implemented, it should not be completely broken..

Dan, thoughts?

