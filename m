From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [BISECTED] HP G7000 battery disappears after suspend
Date: Wed, 8 Jul 2009 21:41:17 +0200
Message-ID: <200907082141.18135.rjw@sisk.pl>
References: <61b223ba0907081216q3813c8f0n677bcce8b24ae52c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42130 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847AbZGHTlD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jul 2009 15:41:03 -0400
In-Reply-To: <61b223ba0907081216q3813c8f0n677bcce8b24ae52c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>

On Wednesday 08 July 2009, Alan Jenkins wrote:
> Hi,
> 
> I've borrowed this laptop for a few days.  Linux works pretty well,
> but I found a problem on newer kernels.  After suspend it claims the
> battery has been removed.  E.g. /proc/acpi/battery/BAT0/state claims
> the battery is not present (but it is).
> 
> I've attached acpidump and dmidecode output at
> <http://bugzilla.kernel.org/show_bug.cgi?id=13745>.  I still have
> access to the laptop for further tests, but only until Friday.
> 
> I bisected it to the commit below.  Manually reverting the patch fixes
> the problem (in both 2.6.30 and 2.6.31-rc2).

Well, the commit below can't be reverted, because that would cause the boxes
it fixed to stop working.

Now, the only case this patch can make any difference is when the BIOS doesn't
set SCI_EN before returning control the the kernel, which quite evidently is a
BIOS bug.  The fact that the battery doesn't work with this patch applied means
that the BIOS not only doesn't set SCI_EN, but also expects it to remain unset,
which is insane.

IMO this is a "won't fix", sorry.

Best,
Rafael


> commit d0c71fe7ebc180f1b7bc7da1d39a07fc19eec768
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Sat Oct 4 00:05:05 2008 +0200
> 
>     ACPI Suspend: Enable ACPI during resume if SCI_EN is not set
> 
>     On some machines, like for example MSI Wind U100, the BIOS doesn't
>     enable ACPI before returning control to the OS, which sometimes
>     causes resume to fail.  This is against the ACPI specification,
>     which clearly states that "When the platform is waking from an S1, S2
>     or S3 state, OSPM assumes the hardware is already in the ACPI mode
>     and will not issue an ACPI_ENABLE", but it won't hurt to check the
>     SCI_EN bit and enable ACPI during resume from S3 if this bit is not
>     set.
> 
>     Fortunately, we already have acpi_enable() for that, so use it in the
>     resume code path, before executing _BFS, in analogy with the
>     resume-from-hibernation code path.
> 
>     NOTE: We aren't supposed to set SCI_EN directly, because it's owned
>     by the hardware.
> 
>     Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>     Pavel Machek <pavel@suse.cz>
>     Signed-off-by: Len Brown <len.brown@intel.com>
