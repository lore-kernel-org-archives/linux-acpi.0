From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI ERROR SMBus or IPMI write requires Buff of len 66, found
 32...???? linux-3.0.0
Date: Tue, 1 Nov 2011 14:43:12 +0000
Message-ID: <20111101144312.GA25790@srcf.ucam.org>
References: <4EAF1021.2090004@tlinx.org>
 <CAErSpo4GaQfoBWs2iPk1ppx69Ccnz3dZvt31vSp8R7zka8a6=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42425 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754989Ab1KAOnR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Nov 2011 10:43:17 -0400
Content-Disposition: inline
In-Reply-To: <CAErSpo4GaQfoBWs2iPk1ppx69Ccnz3dZvt31vSp8R7zka8a6=g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linda Walsh <lkml@tlinx.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Tue, Nov 01, 2011 at 08:05:49AM -0600, Bjorn Helgaas wrote:
> [+cc linux-acpi]
> 
> On Mon, Oct 31, 2011 at 3:16 PM, Linda Walsh <lkml@tlinx.org> wrote:
> >
> >
> > Was looking through boot log messages, and this one seemed 'new'...
> 
> Can you confirm that this error did not occur on a previous version?
> What is the most recent version where it did not occur?

ACPI IPMI support was only added recently, so it's not surprising that 
it didn't show up previously. The spec is quite clear that IPMI message 
buffers should be 66 bytes, but a lot of firmware seems to disagree. Not 
sure what the best thing to do here is.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
