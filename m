From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pm/linux-next cause network stop working with qemu-kvm/e1000
Date: Sat, 23 Mar 2013 13:30:15 +0100
Message-ID: <2281042.ltEMndsGee@vostro.rjw.lan>
References: <CAE9FiQVZ5VZDo1KCun6SDonTJ=TGWLxm5zJQN5U4f1_52cKKwg@mail.gmail.com> <CAE9FiQUarQVqzB_VSMqUrMvSHryrSN3_4tLTEJqygDFzB7uDUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:35955 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708Ab3CWMWy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 Mar 2013 08:22:54 -0400
In-Reply-To: <CAE9FiQUarQVqzB_VSMqUrMvSHryrSN3_4tLTEJqygDFzB7uDUw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bob Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Saturday, March 23, 2013 01:38:43 AM Yinghai Lu wrote:
> On Fri, Mar 22, 2013 at 5:27 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > c13085e519e8984fede41fa3d6a5502523b10996 is the first bad commit
> > commit c13085e519e8984fede41fa3d6a5502523b10996
> > Author: Bob Moore <robert.moore@intel.com>
> > Date:   Fri Mar 8 09:19:38 2013 +0000
> >
> >     ACPICA: Resource Mgr: Prevent infinite loops in resource walks
> >
> >     Add checks for zero-length resource descriptors in all code that
> >     loops through a resource descriptor list. This prevents possible
> >     infinite loops because the length is used to increment the traveral
> >     pointer and detect the end-of-descriptor.
> >
> >     Signed-off-by: Bob Moore <robert.moore@intel.com>
> >     Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > :040000 040000 84f29d6ee654ffe4c935ce9023208019b2ef09a5
> > c8a6613be9a5a130f69e654c5b560a8adb2174db M      drivers
> >
> >
> > long delay after
> > calling  ip_auto_config+0x0/0xea4 @ 1
> >
> > also happen on one 8 sockets nehalem-ex.
> >
> > If I revert that commit, network works again.
> 
> Attached patch fix the problem. Please fold it into offending patch in
> pm/linux-next.

I'd actually prefer to apply it as a separate patch, so can you please post
it with a proper changelog?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
