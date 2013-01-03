From: Joe Perches <joe@perches.com>
Subject: [PATCH V2] checkpatch: prefer dev_<level>( to
 dev_printk(KERN_<LEVEL>
Date: Thu, 03 Jan 2013 08:49:52 -0800
Message-ID: <1357231792.25181.62.camel@joe-AO722>
References: <20130102232730.5706.82243.stgit@grignak.americas.hpqcorp.net>
	 <20130102232743.5706.63153.stgit@grignak.americas.hpqcorp.net>
	 <1357171594.25181.19.camel@joe-AO722> <20130103100808.GG2649@dm>
	 <1357230494.25181.55.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:59071 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753605Ab3ACQtw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Jan 2013 11:49:52 -0500
In-Reply-To: <1357230494.25181.55.camel@joe-AO722>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Whitcroft <apw@canonical.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lance Ortiz <lance.ortiz@hp.com>, bhelgaas@google.com, lance_ortiz@hotmail.com, jiang.liu@huawei.com, tony.luck@intel.com, bp@alien8.de, rostedt@goodmis.org, mchehab@redhat.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

Add YA check to printk style.

dev_<level> uses are functions and generate smaller
object code than dev_printk(KERN_<LEVEL>.

Signed-off-by: Joe Perches <joe@perches.com>
---
V2: Remove unnecessary copy/paste logic from pr_<level>
    conversion above it.

 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9de3a69..9a1ae72 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2425,6 +2425,15 @@ sub process {
 			     "Prefer pr_warn(... to pr_warning(...\n" . $herecurr);
 		}
 
+		if ($line =~ /\bdev_printk\s*\(\s*KERN_([A-Z]+)/) {
+			my $orig = $1;
+			my $level = lc($orig);
+			$level = "warn" if ($level eq "warning");
+			$level = "dbg" if ($level eq "debug");
+			WARN("PREFER_DEV_LEVEL",
+			     "Prefer dev_$level(... to dev_printk(KERN_$orig, ...\n" . $herecurr);
+		}
+
 # function brace can't be on same line, except for #defines of do while,
 # or if closed on same line
 		if (($line=~/$Type\s*$Ident\(.*\).*\s{/) and



