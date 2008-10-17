From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] Fix possible null ptr dereference
Date: Fri, 17 Oct 2008 11:02:39 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858032E0245@orsmsx503.amr.corp.intel.com>
References: <200810171449.m9HEnoHM018514@los-vmm.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10147 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756060AbYJQSCl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Oct 2008 14:02:41 -0400
In-Reply-To: <200810171449.m9HEnoHM018514@los-vmm.sc.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Dugger, Donald D" <donald.d.dugger@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "astarikovskiy@suse.de" <astarikovskiy@suse.de>, "lenb@kernel.org" <lenb@kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>

In general, the internal ACPICA functions do not perform nearly as much parameter validation as the external functions. The Host OS should not be calling any of the ACPICA internal functions for this and a few other good reasons -- such as the fact that internal functions can disappear, be renamed, or have the parameters changed without warning at any time.

It would probably be a good idea to audit Linux for the use of internal ACPICA functions and fix these bugs.

Bob



>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of donald.d.dugger@intel.com
>Sent: Friday, October 17, 2008 7:50 AM
>To: linux-acpi@vger.kernel.org
>Cc: bjorn.helgaas@hp.com; akpm@linux-foundation.org; astarikovskiy@suse.de;
>lenb@kernel.org
>Subject: [PATCH] Fix possible null ptr dereference
>
>Code in `pci_link.c' is calling the internal routine
>`acpi_ut_evaluate_object'
>which is dangerous given that it is passing a NULL pointer when it should
>be passing a pointer to a real object.  The patch corrects the issue by
>having the code call the external routine `acpi_evaluate_object', which
>correctly handles a NULL pointer.
>
>Signed-off-by: Don Dugger <donald.d.dugger@intel.com>
>
>
>----- cut here for patch.d/acpi_null-1017.patch -----
>diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>index cf47805..65bf4fa 100644
>--- a/drivers/acpi/pci_link.c
>+++ b/drivers/acpi/pci_link.c
>@@ -709,7 +709,7 @@ int acpi_pci_link_free_irq(acpi_handle handle)
>                          acpi_device_bid(link->device)));
>
>        if (link->refcnt == 0) {
>-               acpi_ut_evaluate_object(link->device->handle, "_DIS", 0,
>NULL);
>+               acpi_evaluate_object(link->device->handle, "_DIS", NULL,
>NULL);
>        }
>        mutex_unlock(&acpi_link_lock);
>        return (link->irq.active);
>@@ -773,7 +773,7 @@ static int acpi_pci_link_add(struct acpi_device
>*device)
>
>       end:
>        /* disable all links -- to be activated on use */
>-       acpi_ut_evaluate_object(device->handle, "_DIS", 0, NULL);
>+       acpi_evaluate_object(device->handle, "_DIS", NULL, NULL);
>        mutex_unlock(&acpi_link_lock);
>
>        if (result)
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
