From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: HP nx8220 psmouse vs ACPI at boot up
Date: Thu, 19 Apr 2007 09:18:54 -0600
Message-ID: <200704190918.54467.bjorn.helgaas@hp.com>
References: <1176986698.1231.390.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:60437 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1766812AbXDSPTI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Apr 2007 11:19:08 -0400
In-Reply-To: <1176986698.1231.390.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, kssingvo@suse.de

On Thursday 19 April 2007 06:44, Thomas Renninger wrote:
> I first thought it's the "unload psmouse" or "cleanup psmouse ports"
> at shutdown problem again.
> 
> I think this time EC gets confused at boot time.
> Compiling psmouse as module helps again.
> 
> Symptom:
> AC adapter status is wrong if booted with AC unplugged.
> Replugging helps.
> This sounds like a minor bug, but ACPI errors at other places
> with AE_TIME errors also happen and theoretically all kind of
> ACPI breakage could happen...

Is there a more complete bug report for this, with the whole dmesg
log?  Is this related to suspend/resume, or does it happen on all
shutdown and restart?  Any chance you could collect the DSDT?

Bjorn
