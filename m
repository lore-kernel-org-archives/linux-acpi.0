From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: ACPI in Windows Vista
Date: Tue, 24 Apr 2007 11:39:26 +0800
Message-ID: <1177385966.4635.5.camel@sli10-conroe.sh.intel.com>
References: <200704231458.31767.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1574 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161556AbXDXDmx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Apr 2007 23:42:53 -0400
In-Reply-To: <200704231458.31767.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Tue, 2007-04-24 at 02:58 +0800, Len Brown wrote:
> It is useful to see what Microsoft is doing with ACPI in Vista --
> as that shapes many of the BIOS implementations that Linux will
> encounter:
> 
> http://download.microsoft.com/download/5/b/9/5b97017b-e28a-4bae-ba48-174cf47d23cd/CPA002_WH06.ppt
vista disable MSI per fadt.iapc_boot_arch flags, looks we should do the
same. This means we don't need MSI quirk too.

I'm curious why firmware shouldn't change low 1M memory between sleep,
considering some ranges are reserved.

Thanks,
Shaohua
