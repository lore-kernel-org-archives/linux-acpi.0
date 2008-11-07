From: Len Brown <lenb@kernel.org>
Subject: Re: Build error with latest kernel
Date: Thu, 06 Nov 2008 21:30:34 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811062129380.3106@localhost.localdomain>
References: <1225377756.3689.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_nsq0SCEswt3vPDA5VU15cw)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:41367 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbYKGCag (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 21:30:36 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9X00DJ3YYZG761@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 20:30:35 -0600 (CST)
In-reply-to: <1225377756.3689.5.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: airlied@linux.ie, linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_nsq0SCEswt3vPDA5VU15cw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

shoudl be fixed by 65e082c9a33a6e9f24e9a713a7d38d11206d3c3d

cheers,
-Len

Author: Len Brown <len.brown@intel.com>  2008-10-24 17:18:10
Committer: Dave Airlie <airlied@redhat.com>  2008-10-27 17:46:06
Parent: 70740d6c93030b339b4ad17fd58ee135dfc13913 (Merge branch 'drm-next' 
of git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6)
Child:  4e270e9b8a9d246290f3901f1fb6c5efdb734ddf (drm/radeon: fixup 
further bus mastering confusion.)
Branches: acpica, bugzilla-11917, linus, misc-test, processor-256-2.6.29, 
suspend
Follows: v2.6.27
Precedes: 

    build fix: CONFIG_DRM_I915=y && CONFIG_ACPI=n
...

On Thu, 30 Oct 2008, Steven Whitehouse wrote:

> Hi,
> 
> There is a build error with the attached config on the latest upstream
> Linus kernel.
> 
>   CC [M]  drivers/gpu/drm/i915/i915_suspend.o
> drivers/gpu/drm/i915/i915_opregion.c: In function ‘intel_opregion_init’:
> drivers/gpu/drm/i915/i915_opregion.c:340: error: implicit declaration of
> function ‘register_acpi_notifier’
> drivers/gpu/drm/i915/i915_opregion.c: In function ‘intel_opregion_free’:
> drivers/gpu/drm/i915/i915_opregion.c:361: error: implicit declaration of
> function ‘unregister_acpi_notifier’
> make[4]: *** [drivers/gpu/drm/i915/i915_opregion.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> 
> Looks like the symbols are not defined when ACPI is not configured.
> 
> Steve.
> 

--Boundary_(ID_nsq0SCEswt3vPDA5VU15cw)--
