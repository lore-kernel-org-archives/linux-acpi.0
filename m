From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / platform / LPSS: disable async suspend/resume of LPSS devices
Date: Tue, 23 Sep 2014 01:17:08 +0200
Message-ID: <2190534.fECTUJ0MGh@vostro.rjw.lan>
References: <540E91F0.2060306@linux.intel.com> <54184C92.7060209@linux.intel.com> <54203616.2040803@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59216 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754119AbaIVW5W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Sep 2014 18:57:22 -0400
In-Reply-To: <54203616.2040803@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Monday, September 22, 2014 10:45:42 PM Fu, Zhonghui wrote:
> 

[cut]

> >>>
> >>> This operation is reading data from Operation Region of one operand object in name space. I don't know the reason of hang at this point. Could you please give out some explanation about this?
> >> I don't know the exact reason why this particular read hangs, but this means
> >> that, perhaps, instead of disabling async suspend/resume for all LPSS devices
> >> altogether, perhaps we can serialize their acpi_dev_resume_early()?
> >>
> >> Rafael
> > Do you mean keeping other phases(prepare, suspend, suspend_late, suspend_noirq, resume_noirq, resume, complete) of suspend/resume asynchronous, and only serializing "resume_early" phase for all LPSS devices?
> >
> > Thanks,
> > Zhonghui
> Hi, Rafael
> 
> Could you please confirm my understanding?

This is not what I meant.

Since we have a PM domain for the LPSS devices already, why don't we add an
internal lock to that PM domain and acquire it over executing either
acpi_dev_suspend_late() (during suspend) or acpi_dev_resume_early() (during
resume) for all of them?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
