From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: [PATCH 0/3] Override DSDT via initramfs
Date: Sun, 03 Feb 2008 18:28:14 +0100
Message-ID: <47A5F9AE.7020509@tremplin-utc.net>
References: <4798E2A5.6020804@users.sf.net> <200801311417.57469.lenb@kernel.org> <1201859637.14573.41.camel@queen.suse.de> <200802012336.10687.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:8237 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309AbYBCR2Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Feb 2008 12:28:25 -0500
In-Reply-To: <200802012336.10687.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: trenn@suse.de, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

Hello,

Here are three patches to implement the override of DSDT via initramfs. 
I haven't included the feature for overriding the SSDTs as it's seems 
it's still a bit controversial, and anyway for now there is very little 
need for it. It should be fairly trivial to add it later if need arises.

The patches are against 2.6.24-git-du-jour, and they have been 
boot-tested on my laptop.

See you,
Eric
