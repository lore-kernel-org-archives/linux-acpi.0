From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: EC: Fall back to DSDT scan if ECDT is broken
Date: Thu, 23 Aug 2007 23:37:57 -0400
Message-ID: <200708232337.57454.lenb@kernel.org>
References: <46CAE65E.3000703@suse.de> <46CAE733.1010109@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56634 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934362AbXHXDiJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Aug 2007 23:38:09 -0400
In-Reply-To: <46CAE733.1010109@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tuesday 21 August 2007 09:22, Alexey Starikovskiy wrote:
> + =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR PREFIX "ECDT is broken\n");

I think this is
1. guaranteed to happen
2. guaranteed to alarm users and be viewed as a regression.

   They have no clue what an ECDT is, and this warning
   doesn't tell them what to do about it, if anything.

-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
