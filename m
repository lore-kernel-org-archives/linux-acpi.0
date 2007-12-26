From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/4] ACPI: WMI: Add ACPI-WMI mapping driver
Date: Wed, 26 Dec 2007 21:17:18 +0000
Message-ID: <20071226211718.GA31564@srcf.ucam.org>
References: <20071218235137.12838.75397.stgit@localhost> <20071218235143.12838.33679.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:39400 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbXLZVRa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Dec 2007 16:17:30 -0500
Content-Disposition: inline
In-Reply-To: <20071218235143.12838.33679.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>

+acpi_status wmi_install_notify_handler(wmi_notify_handler handler, void 
*data)
+{
+       if (!handler)
+               return AE_BAD_PARAMETER;
+
+       if (!wmi_external_handler)
+               return AE_ALREADY_ACQUIRED;

Are you sure the negation on the second if is correct? I'm also a bit 
unhappy about only being able to register one notification handler, if 
we consider the case where vendors add and remove WMI interfaces over 
time - it might make sense to have individual small drivers rather than 
one big one, which would mean a notification handler per GUID. Any 
thoughts?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
