From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] Cast removal
Date: Wed, 4 Oct 2006 23:56:02 -0400
Message-ID: <200610042356.03348.len.brown@intel.com>
References: <Pine.LNX.4.61.0610010026050.32229@yvahk01.tjqt.qr>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:10932 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751430AbWJEDyC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Oct 2006 23:54:02 -0400
In-Reply-To: <Pine.LNX.4.61.0610010026050.32229@yvahk01.tjqt.qr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

I'm okay applying this patch it touches the linux-specific
drivers/acpi/* files only, no ACPICA files.

But I don't know if Linus will want changes like this post -rc1.
It might be a pain to have in the tree all the way to 2.6.20 opens b/c
it is sure to cause merge conflicts -- and at the end of the day
the benefit of this patch is what?  A few less characters in the source...

-Len
