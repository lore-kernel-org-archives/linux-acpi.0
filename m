From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] trace, RAS: Add eMCA trace event interface
Date: Mon, 10 Mar 2014 14:29:48 +0100
Message-ID: <20140310132948.GF14808@pd.tnic>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-3-git-send-email-gong.chen@linux.intel.com>
 <20140307114416.GA5255@pd.tnic>
 <20140310082241.GA873@gchen.bj.intel.com>
 <20140310070435.1981ddd5@samsung.com>
 <20140310103129.GC14808@pd.tnic>
 <20140310084113.7be77602@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:35212 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753748AbaCJN3w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Mar 2014 09:29:52 -0400
Content-Disposition: inline
In-Reply-To: <20140310084113.7be77602@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, arozansk@redhat.com, linux-acpi@vger.kernel.org

On Mon, Mar 10, 2014 at 08:41:13AM -0300, Mauro Carvalho Chehab wrote:
> True, but if we decide to go on that direction, a change like that
> should then be done on all EDAC drivers, and that's an API change.
>
> We also need to be sure that userspace will handle this change
> properly.

We don't have a choice:

[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
