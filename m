From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] ACPI: emits change uevents to all physical companion
 devices of container's children
Date: Wed, 19 Apr 2017 16:50:37 +0800
Message-ID: <20170419085037.GD16910@linux-l9pv.suse>
References: <20170403155533.30283-1-jlee@suse.com>
 <CAJZ5v0je_2gk_M7B1PBnvFVtoaiAxm59c2PBWQootZ13eY6tkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:56225 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760729AbdDSIuu (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Wed, 19 Apr 2017 04:50:50 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0je_2gk_M7B1PBnvFVtoaiAxm59c2PBWQootZ13eY6tkQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, Jiri Kosina <jkosina@suse.cz>

Hi, 

On Wed, Apr 19, 2017 at 02:30:18AM +0200, Rafael J. Wysocki wrote:
> On Mon, Apr 3, 2017 at 5:55 PM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > The caa73ea1 patch, "ACPI / hotplug / driver core: Handle containers
> > in a special way", introduced the offline callback of acpi container.
> > In the patch description, it mentions:
> >
> >     For ACPI containers that callback simply walks the list of ACPI
> >     device objects right below the container object (its children) and
> >     checks if all of their physical companion devices are offline.  If
> >     that's not the case, it returns -EBUSY and the container system
> >     devivce cannot be put offline.  Consequently, to put the container
> >     system device offline, it is necessary to put all of the physical
> >     devices depending on its ACPI companion object offline beforehand.
> >
> > Looks that it means acpi_container_offline() should walks all physical
> > companion devices of container's children and checks their offline
> > state. And, the comment in source code is "Check all of the dependent
> > devices' physical companions", which means it should checks _all_
> > physical companions.
> >
> > But, the checking code just stops at the first not-offlined physical
> > companion device of the first not-offlined child, then kernel only
> > emits KOBJ_CHANGE uevent to the one device. It doesn't really walk
> > all children's all physical companion devices and doesn't send change
> > uevent to them.
> 
> It is unclear to me from the description whether or not this is a
> practical issue.
> 
> Also there is an alternative, which is not to send KOBJ_CHANGE uevents
> to any children at all.
> 
> Why is the approach you chose better?
>

Please ignore this patch!

Thanks for your review. I'd say sorry for that I confused with
the code in acpi_scan_hot_remove() when I was sending this patch.
At that time I didn't aware that the acpi_container_offline() does
not need to send uevent to not-offline-yet devices.  

Before two weeks ago (around Apr. 5), I sent a mail to linux-acpi
for reminding to ignore this patch. I don't know why the mail got
filtered...

Thanks a lot!
Joey Lee
