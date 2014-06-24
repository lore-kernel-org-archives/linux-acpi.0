From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 5/7 REVISION v2] trace, RAS: Add eMCA trace event
 interface
Date: Tue, 24 Jun 2014 12:20:15 +0200
Message-ID: <20140624102015.GD4439@pd.tnic>
References: <20140617020937.GA14404@gchen.bj.intel.com>
 <1403058787-15449-1-git-send-email-gong.chen@linux.intel.com>
 <1403058787-15449-2-git-send-email-gong.chen@linux.intel.com>
 <20140622164839.GB3385@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F32845603@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:46770 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbaFXKUS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jun 2014 06:20:18 -0400
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F32845603@ORSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "m.chehab@samsung.com" <m.chehab@samsung.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Jun 23, 2014 at 11:51:04PM +0000, Luck, Tony wrote:
> > Yep, this is starting to look good now:
> >
> > Acked-by: Borislav Petkov <bp@suse.de>
> 
> Thanks Boris,
> 
> Ok - one more piece committed, two to go.  They both
> seem pretty simple:
> 
> Part 6 just enables the debugfs knob to turn off console logging if someone has the magic file open.
>   http://www.spinics.net/lists/linux-acpi/msg50906.html
> 
> Part 7 is a trivial cleanup to not bother checking for EDAC/EXTLOG conflicts on platforms that don't support EXTLOG
>   http://www.spinics.net/lists/linux-acpi/msg50527.html
> 
> Neither seems to need an update as the result of changes we made
> to earlier parts of the series.

Right.

Acked-by: Borislav Petkov <bp@suse.de>

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
