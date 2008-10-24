From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] Subject: Prevent acpi_run_osc from using NULL objects (was: Re: Oops in ACPI with git latest)
Date: Fri, 24 Oct 2008 13:49:42 +0200
Message-ID: <200810241349.43166.rjw@sisk.pl>
References: <1224791103.3330.37.camel@localhost.localdomain> <1224811642.3330.57.camel@localhost.localdomain> <200810240857.18190.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43996 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179AbYJXLo6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Oct 2008 07:44:58 -0400
In-Reply-To: <200810240857.18190.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Friday, 24 of October 2008, Rafael J. Wysocki wrote:
> On Friday, 24 of October 2008, James Bottomley wrote:
> > On Thu, 2008-10-23 at 15:34 -0700, Moore, Robert wrote:
> > > +	if (!output.pointer)
> > > +		return AE_NULL_OBJECT;
> > > +
> > > 
> > > This probably won't work. acpi_evaluate_object currently doesn't touch the pointer parameter if there is no return value, it only sets the length to zero.
> > 
> > Actually, it does.
> 
> Well, this was the only candidate for a NULL pointer dereference, so I'd be
> surprised if it didn't. :-)
> 
> > > So, you might try this:
> > > 
> > > +	if (!output.length)
> > > +		return AE_NULL_OBJECT;
> > > +
> 
> Still, I'd expect the AML interpreter to return error code in this case.
> 
> > This also works.
> 
> Why don't we make it extra safe, then. ;-)
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: Prevent acpi_osc_run from using NULL objects

Ah, mistake in the subject.

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: Prevent acpi_run_osc from using NULL objects

Check if the object returned by acpi_evaluate_object() in
acpi_run_osc() is not NULL before using it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -83,6 +83,9 @@ static acpi_status acpi_run_osc(acpi_han
 	if (ACPI_FAILURE(status))
 		return status;
 
+	if (!output.pointer || !output.length)
+		return AE_NULL_OBJECT;
+
 	out_obj = output.pointer;
 	if (out_obj->type != ACPI_TYPE_BUFFER) {
 		printk(KERN_DEBUG "Evaluate _OSC returns wrong type\n");
