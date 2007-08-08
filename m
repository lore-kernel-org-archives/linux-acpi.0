From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 01/12] ACPI: add "acpi_no_auto_ssdt" bootparam
Date: Wed, 8 Aug 2007 12:38:51 -0400
Message-ID: <200708081238.51945.lenb@kernel.org>
References: <11861804251625-git-send-email-len.brown@intel.com> <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com> <1186560694.8780.114.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59494 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762076AbXHHRmo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Aug 2007 13:42:44 -0400
In-Reply-To: <1186560694.8780.114.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <aystarik@gmail.com>

On Wednesday 08 August 2007 04:11, Thomas Renninger wrote:
> On Fri, 2007-08-03 at 18:33 -0400, Len Brown wrote:
> > "acpi_no_auto_ssdt" prevents Linux from automatically loading
> > all the SSDTs listed in the RSDT/XSDT.
> > 
> > This is needed for debugging.  In particular,
> > it allows a DSDT override to optionally be a DSDT+SSDT override.
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=3774
> 
> I don't understand why this is needed.
> Shouldn't it work like that:
>   - Modified tables are loaded before original, BIOS provided ones
>   - If later tables have the same unique table id they
>     are ignored. I can remember that this check was added more
>     than a year ago, not sure whether it still exists,
>     it should...

There _are_ no modified SSDTs -- only a modified DSDT.

The default case is that the modified DSDT gets loaded
instead of the BIOS version, and then it gets augmented
by any BIOS SSDTs.

However, that doesn't handle the case where we want
to load a modified DSDT and _not_ load the BIOS SSDTs.
This may be because we wanted to override the SSDTs
and we've sucked that code into the modified DSDT
and changed it, or we may simply not want the code
that the  BIOS provides in the SSDT mucking with
our modified DSDT.

-Len
