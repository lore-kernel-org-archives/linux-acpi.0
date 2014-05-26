From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/7 v4] CPER: Adjust code flow of some functions
Date: Mon, 26 May 2014 12:23:11 +0200
Message-ID: <20140526102311.GF25732@pd.tnic>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-4-git-send-email-gong.chen@linux.intel.com>
 <20140521110521.GF21205@pd.tnic>
 <20140521235159.GB1644@gchen.bj.intel.com>
 <20140522105242.GG4383@pd.tnic>
 <20140523014910.GB16945@gchen.bj.intel.com>
 <20140523093703.GB21332@pd.tnic>
 <20140526020745.GB31035@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:39260 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbaEZKXU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 May 2014 06:23:20 -0400
Content-Disposition: inline
In-Reply-To: <20140526020745.GB31035@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Sun, May 25, 2014 at 10:07:45PM -0400, Chen, Gong wrote:
> I can shrink it to 10 bytes. Please see my another reply for why I
> hope to use a string.

No need - just instantiate both the physical address and mask to invalid
values and put that in a comment somewhere stating which values are
invalid.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
