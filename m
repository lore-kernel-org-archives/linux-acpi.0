From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/3] ACPI / button: Remove initial lid state notification
Date: Thu, 23 Jun 2016 02:36:09 +0200
Message-ID: <2071595.qfKer86pIB@vostro.rjw.lan>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com> <009785fc9fed68dc2f0496e6d014586d8eaa7cf2.1464775699.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62224 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750777AbcFWAbu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jun 2016 20:31:50 -0400
In-Reply-To: <009785fc9fed68dc2f0496e6d014586d8eaa7cf2.1464775699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday, June 01, 2016 06:10:34 PM Lv Zheng wrote:
> The _LID control method's initial returning value is not reliable.
> 
> The _LID control method is described to return the "current" lid state.
> However the word of "current" has ambiguity, many BIOSen return the lid
> state upon the last lid notification instead of returning the lid state
> upon the last _LID evaluation. There won't be difference when the _LID
> control method is evaluated during the runtime, the problem is its initial
> returning value. When the BIOSen implement this control method with cached
> value, the initial returning value is likely not reliable. There are simply
> so many examples retuning "close" as initial lid state (Link 1), sending
> this state to the userspace causes suspending right after booting/resuming.
> 
> Since the lid state is implemented by the BIOSen, the kernel lid driver has
> no idea how it can be correct, this patch stops sending the initial lid
> state to the userspace to try to avoid sending the wrong lid state to the
> userspace to trigger such kind of wrong suspending. This actually reverts
> the following commit introduced for fixing a novell bug (Link 2):
>   Commit: 23de5d9ef2a4bbc4f733f58311bcb7cf6239c813
>   Subject: ACPI: button: send initial lid state after add and resume
> 
> Link 1: https://bugzilla.kernel.org/show_bug.cgi?id=89211
>         https://bugzilla.kernel.org/show_bug.cgi?id=106151
>         https://bugzilla.kernel.org/show_bug.cgi?id=106941
> Link 2: https://bugzilla.novell.com/show_bug.cgi?id=326814
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

I've applied [1-3/3] from this series, but I'm not sure if the last patch
is the latest version.  Can you please verify in linux-next?

Thanks,
Rafael

