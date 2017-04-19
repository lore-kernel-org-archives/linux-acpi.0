From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: emits change uevents to all physical companion
 devices of container's children
Date: Wed, 19 Apr 2017 02:30:18 +0200
Message-ID: <CAJZ5v0je_2gk_M7B1PBnvFVtoaiAxm59c2PBWQootZ13eY6tkQ@mail.gmail.com>
References: <20170403155533.30283-1-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33564 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756161AbdDSAaT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2017 20:30:19 -0400
In-Reply-To: <20170403155533.30283-1-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>, Michal Hocko <mhocko@suse.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, Apr 3, 2017 at 5:55 PM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> The caa73ea1 patch, "ACPI / hotplug / driver core: Handle containers
> in a special way", introduced the offline callback of acpi container.
> In the patch description, it mentions:
>
>     For ACPI containers that callback simply walks the list of ACPI
>     device objects right below the container object (its children) and
>     checks if all of their physical companion devices are offline.  If
>     that's not the case, it returns -EBUSY and the container system
>     devivce cannot be put offline.  Consequently, to put the container
>     system device offline, it is necessary to put all of the physical
>     devices depending on its ACPI companion object offline beforehand.
>
> Looks that it means acpi_container_offline() should walks all physical
> companion devices of container's children and checks their offline
> state. And, the comment in source code is "Check all of the dependent
> devices' physical companions", which means it should checks _all_
> physical companions.
>
> But, the checking code just stops at the first not-offlined physical
> companion device of the first not-offlined child, then kernel only
> emits KOBJ_CHANGE uevent to the one device. It doesn't really walk
> all children's all physical companion devices and doesn't send change
> uevent to them.

It is unclear to me from the description whether or not this is a
practical issue.

Also there is an alternative, which is not to send KOBJ_CHANGE uevents
to any children at all.

Why is the approach you chose better?

Thanks,
Rafael
