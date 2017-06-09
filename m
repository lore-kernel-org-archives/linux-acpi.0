From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH] ACPICA: Remove unnecessary call to debugger
Date: Fri, 9 Jun 2017 03:33:51 +0200
Message-ID: <20170609013351.fvpuwqcxw2jxp2dv@angband.pl>
References: <20170608213106.11982-1-kilobyte@angband.pl>
 <1AE640813FDE7649BE1B193DEA596E886CECBBA1@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:54523 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbdFIBeM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jun 2017 21:34:12 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CECBBA1@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Fri, Jun 09, 2017 at 01:18:25AM +0000, Zheng, Lv wrote:
> > Subject: [PATCH] ACPICA: Remove unnecessary call to debugger
> > 
> > This is a port of https://github.com/acpica/acpica/commit/eaa455ac by
> > Robert Moore to the kernel:
> > 
> > > This call was simply wrong, and resulted in a -1 index into the operand
> > > stack.
> > 
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=120351
> > Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> 
> I think my first fix also worked and your test on bug 120351 was wrong.
> I just added comment a moment ago.
> 
> However I just pushed the removal of the wrong debugging statement fix to the upstream.
> It's really redundant, you need to enable the log and check them.
> 
> The patch has already been sent here:
> https://patchwork.kernel.org/patch/9765837/
> So you don't have to send it again.

Date: June 5, and it's not even in next-20170608 yet, so I obviously didn't
see you applying the fix (it seemed stalled since Apr 4).  If it's already
on the way, that's good.

However, it is not redundant: without this removal, I see the UBSAN error
(at least in current mainline).

Whether an alternate fix would be enough is another question.  You guys know
more about the issue, all I know is whether I see warnings spewed into my
dmesg :)


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ A tit a day keeps the vet away.
⣾⠁⢰⠒⠀⣿⡁
⢿⡄⠘⠷⠚⠋⠀ (Rejoice as my small-animal-murder-machine got unbroken after
⠈⠳⣄⠀⠀⠀⠀ nearly two years of no catch!)
