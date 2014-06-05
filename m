From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Revert "ACPI / Battery: Remove battery's proc
 directory" and "ACPI: Remove CONFIG_ACPI_PROCFS_POWER and cm_sbsc.c"
Date: Thu, 5 Jun 2014 15:47:30 +0200
Message-ID: <20140605134730.GA13859@amd.pavel.ucw.cz>
References: <1398872369-2755-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33170 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbaFENrd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Jun 2014 09:47:33 -0400
Content-Disposition: inline
In-Reply-To: <1398872369-2755-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi!

> The commit 1e2d9cd and 7d7ee95 remove ACPI Proc Battery
> directory and breaks some old userspace tools. This patch
> is to revert them.

Quick test shows that battery files are back in 3.15-rc8. Thanks!

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
