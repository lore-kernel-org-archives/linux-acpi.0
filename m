From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 0/5] Detect hwmon and i2c bus drivers interfering with
 ACPI Operation Region resources
Date: Tue, 30 Oct 2007 19:43:07 +0100
Message-ID: <20071030194307.0f8e8ddc@hyperion.delvare>
References: <1193236319.4590.225.camel@queen.suse.de>
	<200710250906.23003.bjorn.helgaas@hp.com>
	<20071027150947.GA1568@srcf.ucam.org>
	<200710282050.34166.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:3243 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753156AbXJ3SnL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Oct 2007 14:43:11 -0400
In-Reply-To: <200710282050.34166.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>

On Sun, 28 Oct 2007 20:50:33 -0600, Bjorn Helgaas wrote:
> On Saturday 27 October 2007 9:09:47 am Matthew Garrett wrote:
> > On Thu, Oct 25, 2007 at 09:06:22AM -0600, Bjorn Helgaas wrote:
> > > But we really *should* reserve things used by opregions, shouldn't
> > > we?  After all, the whole point of resource reservation is to prevent
> > > conflicts.
> >
> > Only if you're happy to lose functionality like IDE, sadly.
> 
> That's a simplistic answer to a complex problem.  I don't think
> we should just ignore the whole problem, cross our fingers, and
> hope that firmware stays out of our way.

I agree that something must be done, but the problem underlined by
Matthew explains the approach Thomas and myself are pursuing at the
moment. Rather than plain requesting the resources at ACPI level and
see everything else break, we rely on cooperation by individual drivers
(or actually families of drivers) and try to fix the problems seen with
these specific drivers. This is more realistic.

-- 
Jean Delvare
