From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Bad AC adaptateur value trought sysfst
Date: Tue, 02 Nov 2010 09:16:35 +0800
Message-ID: <1288660595.2234.164.camel@rui>
References: <AANLkTino-WkpMHfqD6amL-gk5mabiQAVbn9Low8L6joF@mail.gmail.com>
	 <1288572245.2234.88.camel@rui>
	 <AANLkTin517i-Ld_rNRxjmt65hiVpT3bC3wCrL43weiu7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1716 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384Ab0KBBQ2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Nov 2010 21:16:28 -0400
In-Reply-To: <AANLkTin517i-Ld_rNRxjmt65hiVpT3bC3wCrL43weiu7@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seblu <seblu@seblu.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Tue, 2010-11-02 at 04:10 +0800, Seblu wrote:
> On Mon, Nov 1, 2010 at 1:44 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> > will you please attach the acpidump output of this laptop?
> yes, sure.

does the error message pop up every time you boot the kernel?

> > please try the patch attached to see if it helps.
> > BTW, the patch is based on today's git tree. and there may be some
> > conflict if you use 2.6.36 kernel.
> Right, i join my version to test it on 2.6.35.8.
> 
> I've tested after many startup (from shutdown or reboot) on 2.6.35.8
> and on linux-next-2010-10-29 and this seems to fix the issue. Thanks!
> 
good to know.
But I'm still confused about this problem.
you can get the notifications every time you plug or unplug the AC
adapter, right?

here is how ACPI AC driver works:
1. plug/unplug AC
2. AC driver receives notification (done by BIOS)
3. update the AC status (in notification hander)
4. send notification to userspace (in notification handler)
5. user space query AC status when receiving the notification

as we can see, the AC status is already updated in step 3, that's why AC
driver returns a cached value to user space in step 5.
But apparently this is broken in your case.

This makes me wondering if BIOS forgets to do step 2, thus AC driver
does not update the AC status. But you can catch the AC plug/unplug
event every time which suggest the notification is sent correctly.

Seblu,
will you please plug and unplug the AC adapter for several times and
attach the output of "grep . /sys/firmware/acpi/interrupts/*" every time
you plug or unplug the AC adapter?

> I think we have the same bug on battery module, because sometimes i
> need to cat /proc/acpi/battery/BAT*/state do have a proper report of
> battery level. Do you have a patch for this too?
> 
I'll cook up one soon. :) thanks for remindering.

thanks,
rui


