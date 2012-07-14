From: Len Brown <lenb@kernel.org>
Subject: [GIT PULL] ACPI patch for Linux-3.5-rc6
Date: Sat, 14 Jul 2012 13:46:05 -0400
Message-ID: <5001B05D.7070408@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:40163 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab2GNRqK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Jul 2012 13:46:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull this ACPI patch.

thanks!

Len Brown, Intel Open Source Technology Center


The following changes since commit fdb1335a82ef1ef9442ac9377796e4e7a69d1ae4:

  Merge tag 'md-3.5-fixes' of git://neil.brown.name/md (2012-07-13 17:59:33 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git 

for you to fetch changes up to 46befd6b38d802dfc5998e7d7938854578b45d9d:

  ACPICA: Fix possible fault in return package object repair code (2012-07-14 11:38:41 -0400)

----------------------------------------------------------------
Bob Moore (1):
      ACPICA: Fix possible fault in return package object repair code

 drivers/acpi/acpica/nspredef.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
