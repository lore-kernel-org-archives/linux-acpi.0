From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 1/3] Correctly detect Sony TX770P PIC device type
Date: Sun, 27 Apr 2008 15:15:22 +0900
Message-ID: <20080427061521.GB9533@inferi.kami.home>
References: <1208558495-22792-1-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:35512
	"EHLO tadamune.kami.home" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751156AbYD0HBH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Apr 2008 03:01:07 -0400
Content-Disposition: inline
In-Reply-To: <1208558495-22792-1-git-send-email-ynvich@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergey Yanovich <ynvich@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sat, Apr 19, 2008 at 01:41:33AM +0300, Sergey Yanovich wrote:
> This laptop has Type 4 SPIC device, support for which has been added
> recently. This device resides behind an older ISA bridge and was
> earlier incorrectly detected as Type 3.

NAK, introducing Type4 was actually a mistake in the beginning. Soon
after my patches have been merged into mainline I had reports from Type3
users who would actually benefit from the same extra hotkey handling
implemented for the Type4.

What I'm going to do is remove the Type3/Type4 distinction, this should
be enough.

Cheers
-- 
mattia
:wq!
