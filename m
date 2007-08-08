From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 01/12] ACPI: add "acpi_no_auto_ssdt" bootparam
Date: Wed, 08 Aug 2007 10:11:34 +0200
Message-ID: <1186560694.8780.114.camel@queen.suse.de>
References: <11861804251625-git-send-email-len.brown@intel.com>
	 <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:33644 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbXHHILh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Aug 2007 04:11:37 -0400
In-Reply-To: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <aystarik@gmail.com>

On Fri, 2007-08-03 at 18:33 -0400, Len Brown wrote:
> "acpi_no_auto_ssdt" prevents Linux from automatically loading
> all the SSDTs listed in the RSDT/XSDT.
> 
> This is needed for debugging.  In particular,
> it allows a DSDT override to optionally be a DSDT+SSDT override.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=3774

I don't understand why this is needed.
Shouldn't it work like that:
  - Modified tables are loaded before original, BIOS provided ones
  - If later tables have the same unique table id they
    are ignored. I can remember that this check was added more
    than a year ago, not sure whether it still exists,
    it should...

Thanks,

   Thomas


