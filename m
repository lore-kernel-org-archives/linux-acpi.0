From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] PNP ACPI: Use real gsi
Date: Thu, 10 Nov 2011 11:07:33 +0800
Message-ID: <1320894453.15460.15.camel@rui>
References: <1320372728-3235-1-git-send-email-trenn@suse.de>
	 <1320373233-3725-1-git-send-email-trenn@suse.de>
	 <201111090935.52141.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:34429 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546Ab1KJDJP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Nov 2011 22:09:15 -0500
In-Reply-To: <201111090935.52141.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "lenb@kernel.org" <lenb@kernel.org>, "stable@kernel.org" <stable@kernel.org>, Ingo Molnar <mingo@elte.hu>, H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

Hi, Thomas,

can you attach the full dmesg output after applying the patch,
and the full acpidump of this machine please?

thanks,
rui

On Wed, 2011-11-09 at 16:35 +0800, Thomas Renninger wrote:
> Hi,
> 
> On Friday, November 04, 2011 03:20:33 AM Thomas Renninger wrote:
> > From: Yinghai Lu <yinghai@kernel.org>
> > 
> ...
> > On an IBM Xseries (x3850) this caused the machine to freeze around when
> > the init userspace process is tried to get started.
> > The reason is that the timer interrupt is not set up correctly on this
> > machine.
> ...
> 
> What is the state/opinion about this one?
> It fixes a sever bug/regression for me and it would be great to
> see this one in 3.2.
> 
> Thanks,
> 
>     Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


