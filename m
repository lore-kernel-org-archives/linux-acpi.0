From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while suspended
 (rev. 2)
Date: Fri, 11 Jan 2008 16:49:04 -0800
Message-ID: <20080111164904.3ca81602.akpm@linux-foundation.org>
References: <200801020032.45529.rjw@sisk.pl>
	<20080111164613.7791bb94.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55373 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762701AbYALAts (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jan 2008 19:49:48 -0500
In-Reply-To: <20080111164613.7791bb94.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, lenb@kernel.org, linux-kernel@vger.kernel.org, pavel@suse.cz, mingo@elte.hug

On Fri, 11 Jan 2008 16:46:13 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> > The first patch in the series introduces such a mechanism.  The remaining three
> > patches modify the MSR, x86-64 MCE and cpuid drivers in accordance with the
> > above approach.
> 
> These patches are a preresuisite to
> gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch and its
> later fixed-up versions.
> 
> So what I have now is
> 
> revert-gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch
> pm-introduce-destroy_suspended_device.patch
> pm-do-not-destroy-create-devices-while-suspended-in-msrc-rev-2.patch
> pm-do-not-destroy-create-devices-while-suspended-in-mce_64c.patch
> pm-do-not-destroy-create-devices-while-suspended-in-cpuidc.patch
> pm-acquire-device-locks-on-suspend-rev-3.patch
> pm-acquire-device-locks-on-suspend-rev-3-checkpatch-fixes.patch
> pm-acquire-device-locks-on-suspend-rev-3-checkpatch-fixes-2.patch
> 
> So what needs to happen in Greg's tree is
> 
> a) drop the old gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch
> 
> b) apply these four patches
> 
> c) apply the new pm-acquire-device-locks-on-suspend-rev-3.patch (and its fixups)

err, no.  pm-introduce-destroy_suspended_device.patch demolishes
pm-acquire-device-locks-on-suspend-rev-3.patch

Confused, giving up.
