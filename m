From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to iomaps management
Date: Sun, 23 Jan 2011 21:35:32 +0100
Message-ID: <201101232135.32510.rjw@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl> <201101221013.10239.rjw@sisk.pl> <20110123182037.GH24071@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20110123182037.GH24071@khazad-dum.debian.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sunday, January 23, 2011, Henrique de Moraes Holschuh wrote:
> On Sat, 22 Jan 2011, Rafael J. Wysocki wrote:
> > > I discovered CONFIG_THINKPAD_ACPI caused suspend-to-disk to hang. I
> > > need the Thinkpad ACPI to control the fan and bluetooth. It looks like
> > > the thinkpad acpi is trying acquire locks while suspending.  Disabling
> > > cmos, light, led and hotkeys makes suspend-to-disk works again.
> > 
> > Well, we should tell the thinkpad_acpi maintainer about that, then (CCed).
> 
> What are the requirements re. mutexes for sleep-to-disk versus sleep-to-ram?

No difference.  Basically, there are two differences between suspend and
hibernation, as far as drivers are concerned:
(1) It's better to use the ->freeze()/->thaw() and ->poweroff()/->restore()
    callbacks for hibernation.
(2) It may be _much_ more difficult to get free memory during hibernation
    (so theoretically attempts to get memory during hibernation are more likely
    to block).

> Did something change in that area that caused the driver to hang?  A pointer
> to the ML threads, documentation, or patchset/git commit with those changes
> would be enough answer, and I will pursue it from there.

I'm not aware of any such changes.

Besides, the problem reported by Jeff seems to be caused by CPU hotplug.

Thanks,
Rafael
