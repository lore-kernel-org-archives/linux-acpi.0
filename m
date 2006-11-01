From: Len Brown <len.brown@intel.com>
Subject: Re: udev broken by recent ACPI git commits
Date: Wed, 1 Nov 2006 03:35:01 -0500
Message-ID: <200611010335.02948.len.brown@intel.com>
References: <200611010004.28483.rjw@sisk.pl> <200611010016.25103.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54949 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1423648AbWKAIcq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Nov 2006 03:32:46 -0500
In-Reply-To: <200611010016.25103.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Andrew Morton <akpm@osdl.org>

> > One of the following commits out of the git-acpi tree breaks udev on my box
> > (HPC nx6325 w/ 64-bit SUSE 10.1):

I've removed the acpica branch from the acpi test tree for now
so it doesn't block testing of unrelated patches.

Rafael,
Please confirm that linus + the new acpi test tree works:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test
here's a plain patch:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.19/acpi-test-20060707-2.6.19-rc3.diff.gz

Please confirm that linus + just the acpica branch fails:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git acpica
here's a plain patch:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.19/acpi-acpica-20061011-2.6.19-rc3.diff.gz

Yes, except for a few small changes, this is the moral equivalent of the bisect that you just did.
But as Andrew has bounced git-acpi.patch out of -mm, it seems prudent to
do this check before asking him to pull it in again.

thanks,
-Len
