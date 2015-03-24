From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] ACPI: Adjust the return value of _REV on x86
Date: Tue, 24 Mar 2015 09:41:22 -0500
Message-ID: <55117792.3020804@dell.com>
References: <1426150247-18309-1-git-send-email-matthew.garrett@nebula.com>	 <1426363131-14530-1-git-send-email-jason.ekstrand@intel.com>	 <CAOFGe95CiLcHtzD3Vv-KJoCXfeHCyGa55OBkzHSZMWwdOyLnfg@mail.gmail.com>	 <20150323120331.GA3007@codeblueprint.co.uk> <5510FB37.6030808@dell.com> <1427188657.7155.11.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from AUSXIPPS310.us.dell.com ([143.166.148.211]:28386 "EHLO
	ausxipps310.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbbCXOl0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2015 10:41:26 -0400
In-Reply-To: <1427188657.7155.11.camel@loki>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>, Jason Ekstrand <jason@jlekstrand.net>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Bard Liao <bardliao@realtek.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>


On 03/24/2015 04:17 AM, Liam Girdwood wrote:
> On Tue, 2015-03-24 at 00:50 -0500, Mario Limonciello wrote:
>
> There is some work in progress here to standardise the jack kcontrols
> between HDA, ASoC and other ALSA drivers. I would expect this to be
> upstream in the next week or two.
>
> UCM configs and jack support for this DSP and codec combination have now
> been upstreamed :)
>
> Generic patches to support UCM jack switching are now upstream in
> pulseaudio too.
>
> Can you send these to me privately.
>
> Thanks
>
> Liam
>
>
Liam,

This is all great news to hear, thank you.  I'll send you a message privately about the stability issue.
