From: <Mario_Limonciello@Dell.com>
Subject: RE: [PATCH] ACPI: fix Thunderbolt hotplug
Date: Thu, 28 Apr 2016 18:44:53 +0000
Message-ID: <0502496faa2f494a8d81e4789fa2a77e@ausx13mpc120.AMER.DELL.COM>
References: <1461760019-12930-1-git-send-email-prarit@redhat.com>
 <b80830ab-20b4-bd75-5331-4ad55cbff355@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausxipps301.us.dell.com ([143.166.148.223]:5527 "EHLO
	ausxipps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbcD1Soz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Apr 2016 14:44:55 -0400
In-Reply-To: <b80830ab-20b4-bd75-5331-4ad55cbff355@kernel.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: luto@kernel.org, prarit@redhat.com, linux-kernel@vger.kernel.org
Cc: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org, devel@acpica.org



> -----Original Message-----
> From: Andy Lutomirski [mailto:luto@kernel.org]
> Sent: Thursday, April 28, 2016 1:39 PM
> To: Prarit Bhargava <prarit@redhat.com>; linux-kernel@vger.kernel.org
> Cc: Robert Moore <robert.moore@intel.com>; Lv Zheng
> <lv.zheng@intel.com>; Rafael J. Wysocki <rafael.j.wysocki@intel.com>; Len
> Brown <lenb@kernel.org>; linux-acpi@vger.kernel.org; Limonciello, Mario
> <Mario_Limonciello@Dell.com>; stable@vger.kernel.org; devel@acpica.org
> Subject: Re: [PATCH] ACPI: fix Thunderbolt hotplug
> 
> On 04/27/2016 05:26 AM, Prarit Bhargava wrote:
> > Rafael, this patch is in the acpica.git tree as 7a3bd2d ("Dispatcher:
> > Update thread ID for recursive method calls").  I've had many positive
> > testing results from hardware vendors and users with this patch and
> > this resolves many of the problems seen here:
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=115121
> >
> > This does not fix the problems with the TB docking station.  Although
> > this patch will also be required, the docking station issues require a FW
> update.
> > Updated FW should be coming soon to resolve those problems.
> >
> 
> No kidding!?!  Will that update be installable from Linux?  If so, could you cc
> me on that?
> 


This patch does let the dock hotplug properly after the BIOS fix is applied.

For the dock devices not showing up on the other side of the thunderbolt bridge:
It's going to be a system firmware update for both the XPS 9350 and Precision 5510.  It will get distributed to LVFS and can be loaded up with fwupd/fwupdate.  
I don't yet have an ETA that I can share other than "Next BIOS release"

After the update, set Thunderbolt Security to "No Security" and devices should be available.

Thanks,

