From: Len Brown <lenb@kernel.org>
Subject: [GIT PATCH] ACPI patch for 2.6.21-rc5
Date: Fri, 30 Mar 2007 14:37:33 -0400
Message-ID: <200703301437.33798.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57847 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbXC3Six (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Mar 2007 14:38:53 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This restores 2.6.20 behavior, fixing the 2.6.21 regression below.

thanks!

-Len

ps. individual patches are available on linux-acpi@vger.kernel.org
and a consolidated plain patch is available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.21/acpi-release-20070126-2.6.21-rc5.diff.gz

 Documentation/kernel-parameters.txt |    2 +-
 drivers/acpi/tables.c               |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

through these commits:

Len Brown (1):
      Revert "ACPI: parse 2nd MADT by default"

with this log:

commit 4e381a4f06e3c7b350b55a2636b9d45691780eba
Author: Len Brown <len.brown@intel.com>
Date:   Fri Mar 30 14:16:10 2007 -0400

    Revert "ACPI: parse 2nd MADT by default"
    
    This reverts commit 09fe58356d148ff66901ddf639e725ca1a48a0af.
    http://bugzilla.kernel.org/show_bug.cgi?id=8283
    
    Signed-off-by: Len Brown <len.brown@intel.com>
