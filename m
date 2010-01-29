From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [linux-pm] ACPI Lid Issue
Date: Fri, 29 Jan 2010 08:48:31 +0800
Message-ID: <1264726111.9599.35.camel@rzhang1-desktop>
References: <36d20d7f1001280848taf92485g53bb3f6061ea414e@mail.gmail.com>
	 <201001282111.25276.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:58445 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325Ab0A2AuS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jan 2010 19:50:18 -0500
In-Reply-To: <201001282111.25276.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Robin <diilbert.atlantis@gmail.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, 2010-01-29 at 04:11 +0800, Rafael J. Wysocki wrote:
> On Thursday 28 January 2010, Robin wrote:
> > The lid/suspend event works on my Toshiba Satellite A205-S4607 50% of
> > the time.  I think it is possible it is an ACPI driver clitch.
> > 
> > After doing a little research I found out that the current lid state
> > is stored at:
> > /proc/acpi/button/lid/*/state.
> > 
> > So I ran some simple tests:
> > 
> > 1)  After a fresh boot:
> > cat /proc/acpi/button/lid/*/state gives me:
> > State: open
> > 
> > 2) Close (successful suspend) and Reopen the lid:
> > cat /proc/acpi/button/lid/*/state gives me:
> > State: closed
> > 
> > 3) Close the lid (failure to suspend the laptop) and reopen
> > cat /proc/acpi/button/lid/*/state gives me:
> > State: open
> > 
> > 4) Close (successful suspend) and Reopen the lid:
> > cat /proc/acpi/button/lid/*/state gives me:
> > State: closed
> > 
> > I repeated this several times to make sure the pattern is consistent.
> > 
> > Any thoughts?
> 
please file a new bug at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the acpidump output of your laptop there.

thanks,
rui

> It's better to ask on the linux-acpi list (CC added).
> 
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


