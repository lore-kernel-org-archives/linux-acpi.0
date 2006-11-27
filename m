From: Len Brown <len.brown@intel.com>
Subject: Re: contents of the acpica branch
Date: Sun, 26 Nov 2006 21:12:35 -0500
Message-ID: <200611262112.35683.len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <200611242133.00136.rjw@sisk.pl> <200611242325.49160.rjw@sisk.pl>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:1511 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1756120AbWK0CKA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Nov 2006 21:10:00 -0500
In-Reply-To: <200611242325.49160.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>

On Friday 24 November 2006 17:25, Rafael J. Wysocki wrote:
> On Friday, 24 November 2006 21:32, Rafael J. Wysocki wrote:
> > On Friday, 24 November 2006 08:18, Len Brown wrote:
> > > 
> > > The following patches are on the "acpica" branch of the ACPI git tree.
> > 
> > #11 seems to be missing, or is it just me who hasn't received it?
> 
> I think it is missing.

Yep, it got filtered by vger.kernel.org due to size.
Here's a copy:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/acpica/
0011-ACPICA-Implement-simplified-Table-Manager.txt

While we're trying hard to break up the ACPICA updates into individual patches,
with a single well contained logical change  per each, in that case we
did not succeed.

> Moreover, the one available at
> 
> http://kernel.org/git/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commitdiff;h=7b3b58eb8bcf2605a809010ad084dab9fa7f58ad
> 
> seems to suffer from a mismerge in acpi_status acpi_reallocate_root_table().

I don't see a mis-merge there.
Note that the unused acpi_load_table got deleted,
and acpi_reallocate_root_table got added in that place in the file.
Diff isn't very smart about displaying this case --
or did I mis-understand what you are referring to?

note that the acpica branch will be re-checked in to fix some minor issues.
so if you pulled it and you pull it again and get conflicts, throw away the previous version.
This is the price we pay for being required to supply "clean" history to upsteam.

thanks,
-Len

