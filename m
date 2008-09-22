From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
	GPEs) on Asus EeePC
Date: Mon, 22 Sep 2008 09:31:54 +0800
Message-ID: <1222047114.3999.127.camel@yakui_zhao.sh.intel.com>
References: <48D695B3.5000303@tuffmail.co.uk>  <48D69DC9.5060100@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56573 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923AbYIVB0s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Sep 2008 21:26:48 -0400
In-Reply-To: <48D69DC9.5060100@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux acpi <linux-acpi@vger.kernel.org>

On Sun, 2008-09-21 at 23:17 +0400, Alexey Starikovskiy wrote:
   
    The issue on Asus-EEEPC of bug11089 is that EC notification event is
triggered too quickly. Before the EC notification event is queried,
another EC notification event is triggered again. In such case some EC
notification event will be lost unless EC driver continues to query the
EC notification event until zero is returned. (As suggested in the
Alan's patch).
   And it is different with the issue of bug 9998/10724.


> Regards,
> Alex.
> 
> 
> Alan Jenkins wrote:
> > Alexey Starikovskiy wrote:
> > 
> >> Here is the patch.
> >>
> >> Please try/review.
> >>
> >> Regards,
> >> Alex.
> >> Alan Jenkins wrote:
> >>> Sounds sensible. Hopefully we're right that most systems with these
> >>> broken EC's don't want the workaround. I assume you will still notify
> >>> the user automatically, something like "acpi: ec: GPE storm detected,
> >>> try booting with ec=poll".
> > 
> > My apologies.  I seem to have tested this but neglected to reply :-(.
> > 
> > I've been running with this for a week or so now.  I've been bashing the
> > hotkeys (and holding down the ones with autorepeat), and it works fine. 
> > Plus I get the message in the kernel log suggesting ec_intr=0 if the
> > keyboard doesn't work.  It's all good.
> > 
> > Thanks
> > Alan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

