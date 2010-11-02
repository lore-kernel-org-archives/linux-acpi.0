From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: Re: [Intel-gfx] [PATCH 4/4] cpuidle: Hack iowait weighting to
 avoid C-state reduction for graphics.
Date: Tue, 02 Nov 2010 21:00:31 +0100
Message-ID: <1288728031.3031.7.camel@zwerg>
References: <1288643024-5706-1-git-send-email-eric@anholt.net>
	 <1288643024-5706-5-git-send-email-eric@anholt.net>
	 <1288700414.26046.18.camel@localhost.localdomain>
	 <87fwvj7mvz.fsf@pollan.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:52286 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750877Ab0KBUAg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Nov 2010 16:00:36 -0400
In-Reply-To: <87fwvj7mvz.fsf@pollan.anholt.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: ykzhao <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, arjan@linux.intel.com

Am Dienstag, den 02.11.2010, 08:42 -0700 schrieb Eric Anholt:
> On Tue, 02 Nov 2010 20:20:14 +0800, ykzhao <yakui.zhao@intel.com> wrote:
> > On Tue, 2010-11-02 at 04:23 +0800, Eric Anholt wrote:
> > > Improves nexuiz performance by about 1% on my system.
> > 
> > CC: Arjan and linux-acpi mailing list.
> > 
> > It seems that the selection of C-state will become very sensitive to IO
> > wait after the multi factor is changed from 10 to 1000.
> > Maybe only one IO/wait will bring that the system can't enter the deep
> > C-state.
> 
> Note the original message that said "This patch series is a hack, if it
> helps anyone I'll rewrite it to do the right thing".

If this patches about perforamnce issue on 9450gm and sleep state on
CPU, than it do not work for me.

I applied your patches on the top of 3e7b033 (drm/i915: Use the agp_size
determined from the GTT), the 3/4 was rejected so id it manually.

Same result: graphic perfomence drop on smp/ht system if cpu in C4.

-- 
Regards,
        Alexey


