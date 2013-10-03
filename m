From: Alexey Neyman <stilor@att.net>
Subject: Re: [PATCH] Fix coalescing host bridge windows in arch/x86/pci/acpi.c
Date: Thu, 03 Oct 2013 11:44:23 -0700
Message-ID: <1569389.72Ab6LcEbn@mistral>
References: <6362938.J7ZtNEOFpc@mistral> <52410B49.3050306@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2999110.gUrYDbNVgY"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nm4-vm2.access.bullet.mail.gq1.yahoo.com ([216.39.63.32]:21855
	"EHLO nm4-vm2.access.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754375Ab3JCSoZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Oct 2013 14:44:25 -0400
In-Reply-To: <52410B49.3050306@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yijing Wang <wangyijing@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Feng Tang <feng.tang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart2999110.gUrYDbNVgY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

[Patch ping #4...]

On Tuesday, September 24, 2013 11:47:21 AM Yijing Wang wrote:
> On 2013/9/23 14:15, Alexey Neyman wrote:
> > [Resending due to no response to the original message in a week]
> > 
> > Hi all,
> > 
> > I have a board with a BIOS bug that reports the following I/O port regions
> > in _CRS on one of the host bridges:
> > 
> > 0x0000-0x03af // #0
> > 0x03e0-0x0cf7 // #1
> > 0x03b0-0x03bb // #2
> > 0x03c0-0x03df // #3
> > 0x0000-0xdfff // #4
> > 0xf000-0xffff // #5
> > 
> > Obviously, region number #4 is erroneous as it overlaps with regions
> > #0..3.
> > The code in coalesce_windows() in arch/x86/pci/acpi.c attempts to recover
> > from such kind of BIOS bugs by merging the overlapping regions. Current
> > code expands region #0 to 0x0000-0xdffff and makes region #4 ignored. As
> > a result, overlap of the expanded region #0 with regions #1..3 remains
> > undetected (as the inner loop already compared them with region #0). As a
> > result, regions #1..3 are inserted into the resource tree even though
> > they overlap with adjusted region #0 - which later results in resource
> > conflicts for PCI devices with IO ports in one of those regions (e.g.,
> > for an PCI IDE controller in legacy mode - which has port 0x3f6). The
> > kernel then refuses to initialize these devices.
> > 
> > The fix: instead of expanding res1 and ignoring res2, do the opposite. The
> > res2 window is yet to be compared against all windows between res1 and
> > res2
> > (regions #1..3 in the above example), so the resulting resource map will
> > include just the expanded region - and will ignore any overlapping ones.
> > 
> > Signed-off-by: Alexey Neyman <stilor@att.net>
> 
> It looks fine to me, but I have no platform to test it. :)

Thanks for a review. Could anybody push it into the tree? :)
For convenience, patch attached again.

Regards,
Alexey.
--nextPart2999110.gUrYDbNVgY
Content-Disposition: attachment; filename="acpi.c.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="utf-8"; name="acpi.c.diff"

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index b30e937..7fb24e5 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -354,12 +354,12 @@ static void coalesce_windows(struct pci_root_info *info, unsigned long type)
 			 * the kernel resource tree doesn't allow overlaps.
 			 */
 			if (resource_overlaps(res1, res2)) {
-				res1->start = min(res1->start, res2->start);
-				res1->end = max(res1->end, res2->end);
+				res2->start = min(res1->start, res2->start);
+				res2->end = max(res1->end, res2->end);
 				dev_info(&info->bridge->dev,
 					 "host bridge window expanded to %pR; %pR ignored\n",
-					 res1, res2);
-				res2->flags = 0;
+					 res2, res1);
+				res1->flags = 0;
 			}
 		}
 	}

--nextPart2999110.gUrYDbNVgY--

