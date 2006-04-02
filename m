From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 16/26] acpi_os_acquire_object (GFP_KERNEL) called with IRQs disabled through suspend-resume
Date: Sun, 2 Apr 2006 00:22:06 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6123DEC@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24961 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751279AbWDBFWK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Apr 2006 00:22:10 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, davi.arnaut@gmail.com, pavel@ucw.cz


> void *acpi_os_acquire_object(acpi_cache_t * cache)
> {
>-	void *object = kmem_cache_alloc(cache, GFP_KERNEL);
>+	void *object;
>+
>+	if (acpi_in_resume)
>+		object = kmem_cache_alloc(cache, GFP_ATOMIC);
>+	else
>+		object = kmem_cache_alloc(cache, GFP_KERNEL);
> 	WARN_ON(!object);
> 	return object;
>

I want to delete acpi_in_resume -- replacing it with
use of a system state.

But this patch makes things incrementally better for
the moment until than can be done, so I've applied it.

thanks,
-Len
