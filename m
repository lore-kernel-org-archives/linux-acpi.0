From: Vitalie Lazu <vitalie@webng.md>
Subject: Re: Kernel 2.6.38-1-amd64 can not reboot my iMac
Date: Thu, 16 Jun 2011 17:22:24 +0300
Message-ID: <201106161722.24962.vitalie@webng.md>
References: <201104061255.00189.vitalie@webng.md> <201106161531.52949.vitalie@webng.md> <20110616141348.GA15242@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kirsan.md ([93.116.255.97]:38631 "EHLO mail.kirsan.md"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758106Ab1FPOWB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Jun 2011 10:22:01 -0400
In-Reply-To: <20110616141348.GA15242@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Joi 16 Iunie 2011, Matthew Garrett wrote:
> On Thu, Jun 16, 2011 at 03:31:52PM +0300, Vitalie Lazu wrote:
> > On Joi 16 Iunie 2011, Matthew Garrett wrote:
> > > Should be included. How does it fail?
> > 
> > It hangs on shutdown: with last message: The system will halt...
> 
> Oh, shutdown? You said reboot doesn't work.
Ops, sorry, on reboot, but I will check today at home again.

Can you provide some info how I can debug this?

With debian kernel 2.6.39 it reboots sometimes when you issue shutdown from 
console with:

shutdown -h now

This thing confused me.

-- 
Best regards,
Vitalie
WWW: http://vitalie.webng.md
