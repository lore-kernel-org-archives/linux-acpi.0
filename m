From: Len Brown <len.brown@intel.com>
Subject: Re: udev broken by recent ACPI git commits
Date: Wed, 1 Nov 2006 00:16:24 -0500
Message-ID: <200611010016.25103.len.brown@intel.com>
References: <200611010004.28483.rjw@sisk.pl>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41114 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1946063AbWKAFOI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Nov 2006 00:14:08 -0500
In-Reply-To: <200611010004.28483.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Andrew Morton <akpm@osdl.org>

On Tuesday 31 October 2006 18:04, Rafael J. Wysocki wrote:

> One of the following commits out of the git-acpi tree breaks udev on my box
> (HPC nx6325 w/ 64-bit SUSE 10.1):

The good news is that you've isolated the issue to the ACPICA branch,
and exonerated the other patches in the tree.

The bad news is that the ACPICA branch is 90% of the tree:-)

It would be helpful to know if you see the same issue in 32-bit mode --
though I understand that may not be trivial for you to test.

> 47636d8f011b8e709d4c10c4fbd66e0226380544
> 88c108e4c156cdf77d551368ecc84280e59d5681
> 3adafe97513e6e53283002b07f16c8b6666f5699
> 2d23bd8bec6ce95b20cd175d450943d13c21db1f
> 55dda781f6788411ed629e205c74f173959ceaf2
> ddc4d66d74f18a6695ee0f425a104aa5adc3f7ae

> Namely, if I boot the kernel with these patches applied, udev is unable to
> create the device special files for /dev/sda and its partitions, so I can't
> even mount the root fs.

Here are the comments for the above.
While we tried very hard to split individual commits
into individual patches, some of these changes are quite
large and it may not be practical narrow further via bisect
due to earlier patches needing subsequent fixes.

commit ddc4d66d74f18a6695ee0f425a104aa5adc3f7ae
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Oct 26 16:02:20 2006 +0400

    ACPICA: make new ACPICA table code work in Linux

    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 55dda781f6788411ed629e205c74f173959ceaf2
Author: Robert Moore <robert.moore@intel.com>
Date:   Thu Oct 26 16:02:19 2006 +0400

    ACPICA: Lint changes

    Lint changes
    Move RSDT/XSDT pointer extraction to separate function
    Warning on 32-bit platforms if XSDT pointers use more than 32 bits.

    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2d23bd8bec6ce95b20cd175d450943d13c21db1f
Author: Robert Moore <robert.moore@intel.com>
Date:   Thu Oct 26 16:02:19 2006 +0400

    ACPICA: Fix for FADT conversion in 64-bit mode

    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3adafe97513e6e53283002b07f16c8b6666f5699
Author: Robert Moore <robert.moore@intel.com>
Date:   Thu Oct 26 16:02:19 2006 +0400

    ACPICA: Update comments for individual table fields

    comments only

    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 88c108e4c156cdf77d551368ecc84280e59d5681
Author: Robert Moore <robert.moore@intel.com>
Date:   Thu Oct 26 16:02:19 2006 +0400

    ACPICA: misc fixes for new Table Manager:

    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 47636d8f011b8e709d4c10c4fbd66e0226380544
Author: Robert Moore <robert.moore@intel.com>
Date:   Thu Oct 26 16:02:19 2006 +0400

    ACPICA: Implement simplified Table Manager

    The Table Manager component has been completely
    redesigned and reimplemented. The new design is much
    simpler, and reduces the overall code and data size of
    the kernel-resident ACPICA by approximately 5%. Also,
    it is now possible to obtain the ACPI tables very early
    during kernel initialization, even before dynamic memory
    management is initialized.

    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
