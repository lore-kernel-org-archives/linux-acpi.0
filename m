From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Caching the results of acpi_get_handle() in a driver: is it valid?
Date: Wed, 7 Feb 2007 12:35:09 -0800
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A401DB0624@orsmsx415.amr.corp.intel.com>
References: <20070207194352.GB4515@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23554 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161439AbXBGUfM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 15:35:12 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20070207194352.GB4515@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net

Handles from a DSDT are in fact permanent.

Once a SSDT is unloaded, however, those handles are invalid.

We are considering making these handles "real" handles instead of simply
pointers to catch the use of an invalid handle.


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Henrique de Moraes Holschuh
> Sent: Wednesday, February 07, 2007 11:44 AM
> To: linux-acpi@vger.kernel.org
> Cc: ibm-acpi-devel@lists.sourceforge.net
> Subject: Caching the results of acpi_get_handle() in a driver: is it
> valid?
> 
> The code I inherited in ibm-acpi does heavy caching of
acpi_get_handle()
> results.  It stores the results of acpi_get_handle() for a number of
nodes
> at module init, and uses the stored results during its lifetime.
> 
> Is that a valid use of the handles returned by acpi_get_handle()?  In
> particular, what happens to handlers when a SSDT gets loaded or
unloaded
> at
> runtime?  Do handles that came from the DSDT change?  What if the
handler
> was to a node in the SSDT being unloaded?  What if the handler is
> overriden
> by a new loaded SSDT?
> 
> While the vast majority of the handlers ibm-acpi caches are in the
DSDT
> and
> very unlikely to change through a SSDT load, I'd still like to make
sure
> the
> driver is doing the right thing...
> 
> PS: not caching the results is always possible, but that will mean
various
> calls to acpi_get_handle() per second.
> 
> --
>   "One disk to rule them all, One disk to find them. One disk to bring
>   them all and in the darkness grind them. In the Land of Redmond
>   where the shadows lie." -- The Silicon Valley Tarot
>   Henrique Holschuh
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
