From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [GIT PULL] More ACPI updates for v4.10-rc1
Date: Thu, 05 Jan 2017 11:57:56 +0800
Message-ID: <1483588676.2112.1.camel@intel.com>
References: <CAJZ5v0iq8z-cdja46o2z__Pfs9M+j2q4SXFu=7cS4LHY3XqL4g@mail.gmail.com>
         <CA+55aFxB_vuENriLFT6S+HMfWouKvrOaaM3NYgeYGnmTYsKU=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:11575 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936219AbdAED6B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Jan 2017 22:58:01 -0500
In-Reply-To: <CA+55aFxB_vuENriLFT6S+HMfWouKvrOaaM3NYgeYGnmTYsKU=g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, 2017-01-04 at 09:46 -0800, Linus Torvalds wrote:
> On Thu, Dec 22, 2016 at 6:18 AM, Rafael J. Wysocki <rafael@kernel.org
> > wrote:
> > 
> > 
> > Please pull from the tag
> > 
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> > \
> >  acpi-extra-4.10-rc1
> I only just noticed that this apparently introduces a new warning:
> 
>   ACPI Warning: Table ffffffff9fe6c0a0, Validation count is zero
> before decrement
> 
> the bug may be old, it looks like just the check is new to commit
> 174cc7187e6f.
> 
> But it does seem like something is putting a table that wasn't
> properly gotten.
> 
this looks like the same issue reported here
https://bugzilla.kernel.org/show_bug.cgi?id=191221

Lv, do you think the patch in comment #4 can fix the problem?

thanks,
rui
