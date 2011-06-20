From: Vitalie Lazu <vitalie@webng.md>
Subject: Re: Kernel 2.6.38-1-amd64 can not reboot my iMac
Date: Mon, 20 Jun 2011 17:46:28 +0300
Message-ID: <201106201746.28322.vitalie@webng.md>
References: <201104061255.00189.vitalie@webng.md> <201106161531.52949.vitalie@webng.md> <20110616141348.GA15242@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.webng.md ([212.56.195.206]:55226 "EHLO mail.webng.md"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248Ab1FTOxE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Jun 2011 10:53:04 -0400
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

I downloaded linux source 3.0.0 rc3 and it still does not work:

Last output:

Will reboot system...
[tttt.ttttt] Restart system.

Then it hangs and I have to force power it down.

I have to reboot it because of this bug: 
Can not connect to external networks.
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=619364


-- 
Best regards,
Vitalie
WWW: http://vitalie.webng.md
