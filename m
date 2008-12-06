From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: samsung x360, acpi support
Date: Sat, 6 Dec 2008 18:54:10 +0000
Message-ID: <20081206185410.GA9348@srcf.ucam.org>
References: <200812041915.39971.mheinz@cs.uni-frankfurt.de> <200812061828.29429.mheinz@cs.uni-frankfurt.de> <20081206173234.GA8400@srcf.ucam.org> <200812061947.17897.mheinz@cs.uni-frankfurt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36900 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbYLFSyN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Dec 2008 13:54:13 -0500
Content-Disposition: inline
In-Reply-To: <200812061947.17897.mheinz@cs.uni-frankfurt.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Heinz <mheinz@cs.uni-frankfurt.de>
Cc: linux-acpi@vger.kernel.org

On Sat, Dec 06, 2008 at 07:47:17PM +0100, Matthias Heinz wrote:

> If you mean it this way...

Yup. If you could open a bug on this against drivers/video(dri) at 
bugzilla.kernel.org and then let me know the bug number, I'll make sure 
the appropriate people look at this. There are still a few irq issues 
with i915, so this isn't entirely surprising.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
