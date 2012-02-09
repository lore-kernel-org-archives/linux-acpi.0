From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 3/5] EFI: add efi driver for Xen efi
Date: Thu, 9 Feb 2012 19:47:23 +0000
Message-ID: <20120209194723.GA8622@srcf.ucam.org>
References: <1328758250-23989-1-git-send-email-liang.tang@oracle.com>
 <1328758401-24258-1-git-send-email-liang.tang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42737 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758515Ab2BITr2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2012 14:47:28 -0500
Content-Disposition: inline
In-Reply-To: <1328758401-24258-1-git-send-email-liang.tang@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Liang <liang.tang@oracle.com>
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, konrad.wilk@oracle.com

Hm. Is there absolutely no way to do this by replacing efi_call_*? It'd 
really be nice to avoid yet another set of duplicate functions here - 
the ia64/x86 situation is already bad enough. Ideally this would be 
sufficiently generic that arm can also plug into it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
