From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 14/16] ACPICA: Add several repairs for _CST predefined name
Date: Sun, 16 Jun 2013 01:17:47 +0200
Message-ID: <1495814.TSDYuEFDRi@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <b2c18e07f4c9e59179c273d051924417053cd774.1369274559.git.lv.zheng@intel.com> <CAJvTdKk9i+qcmKhuoCzqoL_hDUgv8Y3qZrs=j=onUb46kZWZGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38762 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698Ab3FOXIa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Jun 2013 19:08:30 -0400
In-Reply-To: <CAJvTdKk9i+qcmKhuoCzqoL_hDUgv8Y3qZrs=j=onUb46kZWZGQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Wednesday, June 12, 2013 01:58:59 PM Len Brown wrote:
> On Fri, Jun 7, 2013 at 9:01 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> > Sort list based on the C-state, remove invalid/zero entries.
> > ACPICA BZ 890. Lv Zheng.
> 
> The commit message should not just say what the code does,
> it should more importantly answer WHY the change was made,
> and why anybody should care about the patch.
> 
> I think the answer here is that we are adding _CST sanity checking --
> presumably to deal with buggy AML?
> 
> What will we see happen after this patch that we did not see before it?
> 
> Nacked-by: Len Brown <len.brown@intel.com>

Dropped for now, Lv please resend this one.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
