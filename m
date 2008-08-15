From: Andi Kleen <andi@firstfloor.org>
Subject: Please pull ioremap fix
Date: Fri, 15 Aug 2008 19:42:49 +0200
Message-ID: <20080815174249.GA22026@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:39330 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbYHORmy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 13:42:54 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: venki.pallipadi@intel.com, suresh.b.siddha@intel.com


ACPI exposed a off by one bug in the PAT/ioremap changes. Please
pull the fix from the ACPI tree. This fixes
http://bugzilla.kernel.org/show_bug.cgi?id=11346

  git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6 ioremap

Andi Kleen (1):
      x86: Fix ioremap off by one BUG

 arch/x86/mm/ioremap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
