From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 3/5] EFI: add efi driver for Xen efi
Date: Fri, 10 Feb 2012 13:45:26 +0000
Message-ID: <20120210134525.GA29662@srcf.ucam.org>
References: <1328758250-23989-1-git-send-email-liang.tang@oracle.com>
 <1328758401-24258-1-git-send-email-liang.tang@oracle.com>
 <20120209194723.GA8622@srcf.ucam.org>
 <4F34C622.3060905@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45808 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675Ab2BJNpa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2012 08:45:30 -0500
Content-Disposition: inline
In-Reply-To: <4F34C622.3060905@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: liang tang <liang.tang@oracle.com>
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, konrad.wilk@oracle.com

On Fri, Feb 10, 2012 at 03:24:18PM +0800, liang tang wrote:
> Hi,Matthew
> the xen efi call need to use hypercall. that is different from the
> generic efi code. do you any idea about that. thanks!

Right, but 32-bit EFI needs to make different calls to 64-bit EFI 
anyway. It would be good if the abstraction could be done at this level 
instead of duplicating the code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
