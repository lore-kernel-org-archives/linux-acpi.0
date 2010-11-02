From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [Intel-gfx] [PATCH 4/4] cpuidle: Hack iowait weighting to avoid C-state reduction for graphics.
Date: Tue, 02 Nov 2010 20:44:11 +0000
Message-ID: <c6d829$pduqrb@fmsmga001.fm.intel.com>
References: <1288643024-5706-1-git-send-email-eric@anholt.net> <1288643024-5706-5-git-send-email-eric@anholt.net> <1288700414.26046.18.camel@localhost.localdomain> <87fwvj7mvz.fsf@pollan.anholt.net> <1288728031.3031.7.camel@zwerg>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11304 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518Ab0KBUoP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Nov 2010 16:44:15 -0400
In-Reply-To: <1288728031.3031.7.camel@zwerg>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Fisher <bug-track@fisher-privat.net>, Eric Anholt <eric@anholt.net>
Cc: linux-acpi@vger.kernel.org, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, arjan@linux.intel.com

On Tue, 02 Nov 2010 21:00:31 +0100, Alexey Fisher <bug-track@fisher-privat.net> wrote:
> If this patches about perforamnce issue on 9450gm and sleep state on
> CPU, than it do not work for me.
> 
> I applied your patches on the top of 3e7b033 (drm/i915: Use the agp_size
> determined from the GTT), the 3/4 was rejected so id it manually.
> 
> Same result: graphic perfomence drop on smp/ht system if cpu in C4.

Useful check. The patches proposed should only affect readback and
throttling, when the driver is stuck waiting for the GPU with the device
mutex held. The scenario with missing vblank wakeups is that it is the
application waiting in poll for the event to be sent from the driver. In
order to have an effect, we would need to prevent the CPU from dropping
below C2? C1? whilst the vblank interrupt is unmasked i.e
drm_vblank_get(). That would also hopefully have a bigger impact on both
performance and battery life for Intel GPUs/
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
