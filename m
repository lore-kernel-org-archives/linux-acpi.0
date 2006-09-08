From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.18-rc4-mm3 -- ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
Date: Fri, 8 Sep 2006 10:10:57 -0600
Message-ID: <200609081010.58186.bjorn.helgaas@hp.com>
References: <a44ae5cd0608262356j29c0234cl198fb207bcad383d@mail.gmail.com> <a44ae5cd0608270927w62216a00i70966f1e8a190878@mail.gmail.com> <a44ae5cd0609072025i136f9a04ib01ba9c01f332b29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:51143 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1750767AbWIHQLI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Sep 2006 12:11:08 -0400
In-Reply-To: <a44ae5cd0609072025i136f9a04ib01ba9c01f332b29@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>

On Thursday 07 September 2006 21:25, Miles Lane wrote:
> Ping...
> 
> I just reproduced this ACPI error with 2.6.18-rc5-mm1 + all hotfixes +
> a crypto patch from Herbert + two nodemgr patched from Stefan + a max
> trace depth patch from Ingo.
> 
> Any additional debug information needed?  Any progress?

We identified the patch that causes the ACPI unknown exception,
and I think Andrew will be removing it from the next -mm release.

If you want to try reverting it yourself, here's the patch:

http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/hot-add-mem-x86_64-acpi-motherboard-fix.patch
