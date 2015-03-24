From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Re: [PATCH] ACPI: Adjust the return value of _REV on x86
Date: Tue, 24 Mar 2015 09:17:37 +0000
Message-ID: <1427188657.7155.11.camel@loki>
References: <1426150247-18309-1-git-send-email-matthew.garrett@nebula.com>
	 <1426363131-14530-1-git-send-email-jason.ekstrand@intel.com>
	 <CAOFGe95CiLcHtzD3Vv-KJoCXfeHCyGa55OBkzHSZMWwdOyLnfg@mail.gmail.com>
	 <20150323120331.GA3007@codeblueprint.co.uk> <5510FB37.6030808@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52022 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106AbbCXJSF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Mar 2015 05:18:05 -0400
In-Reply-To: <5510FB37.6030808@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>, Jason Ekstrand <jason@jlekstrand.net>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Bard Liao <bardliao@realtek.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tue, 2015-03-24 at 00:50 -0500, Mario Limonciello wrote:

> I believe a majority of the kernel work is complete, but from some off
> kernel mailing list discussions I understand that pulseaudio doesn't
> understand the control interface that gets used for I2S for jack
> detection. 

There is some work in progress here to standardise the jack kcontrols
between HDA, ASoC and other ALSA drivers. I would expect this to be
upstream in the next week or two.  

>  UCM can't be used for it. 

UCM configs and jack support for this DSP and codec combination have now
been upstreamed :)

>  This leads to a really confusing mixer design that needs a variety of
> toggles manually changed when headphones or a headset get plugged in.

Generic patches to support UCM jack switching are now upstream in
pulseaudio too.

>   There have also been some stability problem with audio reported
> after a few days usage.

Can you send these to me privately.

Thanks

Liam


