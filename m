From: Thomas Renninger <trenn@suse.de>
Subject: Re: [1/3] 2.6.22-rc3: known regressions v2
Date: Wed, 06 Jun 2007 14:12:37 +0200
Message-ID: <1181131957.28514.242.camel@queen.suse.de>
References: <46600F1C.5000302@googlemail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:41883 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932756AbXFFMMo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Jun 2007 08:12:44 -0400
In-Reply-To: <46600F1C.5000302@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-acpi@vger.kernel.org

CCs stripped...

On Fri, 2007-06-01 at 14:20 +0200, Michal Piotrowski wrote:
> Hi all,
> 
> Here is a list of some known regressions in 2.6.22-rc3.
> 
> Feel free to add new regressions/remove fixed etc.
> http://kernelnewbies.org/known_regressions
> 

> Subject    : long freezes on thinkpad t60
> References : http://lkml.org/lkml/2007/5/24/100
> Submitter  : Miklos Szeredi <miklos@szeredi.hu>
> Handled-By : Ingo Molnar <mingo@elte.hu>
> Status     : problem is being debugged

I saw the same phenomenon on a totally other machine (therefore it's
likely something else):
Long periods (10-100s) of total unresponsiveness, not even SysRq-*
working.

In my case it was a HP nx6125, beeing unresponsive for about 5s, also
e.g. NUM Led did not work (but was still set after the unresponsive
phase ended).
Looks like machine got stuck with irqs disabled?

It came out that the problem was related to cpufreq (the real cause
probably came from ACPI subsytem). The freq was limited via processor
(_PPC) event and limitation got removed again at the same time, letting
the machine switching down and up it hang in powernow-k8.
Yes, it's unlikely that it's the same problem, but disabling cpufreq
should be worth a test?

Trying a kernel with CONFIG_DETECT_SOFTLOCKUP lockup should tell you at
which place the machine hangs?

   Thomas

