From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_find_bmc() and acpi_get_table()
Date: Sun, 11 Feb 2007 00:28:07 -0500
Message-ID: <200702110028.08052.lenb@kernel.org>
References: <200702102327.28312.lenb@kernel.org> <45CEA157.8050207@acm.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36827 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743AbXBKF3f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Feb 2007 00:29:35 -0500
In-Reply-To: <45CEA157.8050207@acm.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: minyard@mvista.com, linux-acpi@vger.kernel.org

On Saturday 10 February 2007 23:53, Corey Minyard wrote:
> ...the IPMI spec states that in the case 
> of multiple interfaces, a unique SPMI table should be provided for each 
> of those interfaces.  So the IPMI spec seems to require support more 
> than one.

okay, good to know.
If you have the dmesg or acpidump output from a box with multiple interfaces,
we should then see multiple SPMI entries in the RSDT.

thanks,
-Len

