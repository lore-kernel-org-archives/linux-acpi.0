From: liang tang <liang.tang@oracle.com>
Subject: Re: [PATCH 3/5] EFI: add efi driver for Xen efi
Date: Fri, 10 Feb 2012 15:24:18 +0800
Message-ID: <4F34C622.3060905@oracle.com>
References: <1328758250-23989-1-git-send-email-liang.tang@oracle.com> <1328758401-24258-1-git-send-email-liang.tang@oracle.com> <20120209194723.GA8622@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:51409 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab2BJHY1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2012 02:24:27 -0500
In-Reply-To: <20120209194723.GA8622@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, konrad.wilk@oracle.com

Hi,Matthew
the xen efi call need to use hypercall. that is different from the 
generic efi code. do you any idea about that. thanks!


On 2012-2-10 3:47, Matthew Garrett wrote:
> Hm. Is there absolutely no way to do this by replacing efi_call_*? It'd
> really be nice to avoid yet another set of duplicate functions here -
> the ia64/x86 situation is already bad enough. Ideally this would be
> sufficiently generic that arm can also plug into it.
>
