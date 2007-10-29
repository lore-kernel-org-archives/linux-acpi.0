From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/5] Detect hwmon and i2c bus drivers interfering with ACPI Operation Region resources
Date: Sun, 28 Oct 2007 20:50:33 -0600
Message-ID: <200710282050.34166.bjorn.helgaas@hp.com>
References: <1193236319.4590.225.camel@queen.suse.de> <200710250906.23003.bjorn.helgaas@hp.com> <20071027150947.GA1568@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:48223 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbXJ2Cww (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 Oct 2007 22:52:52 -0400
In-Reply-To: <20071027150947.GA1568@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, Jean Delvare <khali@linux-fr.org>

On Saturday 27 October 2007 9:09:47 am Matthew Garrett wrote:
> On Thu, Oct 25, 2007 at 09:06:22AM -0600, Bjorn Helgaas wrote:
> > But we really *should* reserve things used by opregions, shouldn't
> > we?  After all, the whole point of resource reservation is to prevent
> > conflicts.
>
> Only if you're happy to lose functionality like IDE, sadly.

That's a simplistic answer to a complex problem.  I don't think
we should just ignore the whole problem, cross our fingers, and
hope that firmware stays out of our way.

Bjorn
