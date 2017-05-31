From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: configfs: Unload SSDT on configfs entry removal
Date: Thu, 01 Jun 2017 00:47:03 +0200
Message-ID: <8721796.Z5PgE6tXoI@aspire.rjw.lan>
References: <5f535371-1053-09c3-25b4-0b75a79a0ff5@siemens.com> <CAJZ5v0ibeMhrdfs8x8gjqASGt8xf1wLXnN9sQf2A5zU6goeGSQ@mail.gmail.com> <794f48cc-eb2f-2e0e-3002-37892fbbe4da@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47472 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751032AbdEaWx4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 18:53:56 -0400
In-Reply-To: <794f48cc-eb2f-2e0e-3002-37892fbbe4da@siemens.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Wednesday, May 31, 2017 06:39:05 PM Jan Kiszka wrote:
> On 2017-05-30 23:41, Rafael J. Wysocki wrote:
> > On Tue, May 30, 2017 at 11:16 PM, Moore, Robert <robert.moore@intel.com> wrote:
> >>
> >>
> >>> -----Original Message-----
> >>> From: Jan Kiszka [mailto:jan.kiszka@siemens.com]
> >>> Sent: Monday, May 29, 2017 5:53 AM
> >>> To: Mika Westerberg <mika.westerberg@linux.intel.com>
> >>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>;
> >>> Zheng, Lv <lv.zheng@intel.com>; linux-acpi@vger.kernel.org; Linux Kernel
> >>> Mailing List <linux-kernel@vger.kernel.org>; devel@acpica.org; Moore,
> >>> Robert <robert.moore@intel.com>
> >>> Subject: Re: [PATCH] acpi: configfs: Unload SSDT on configfs entry
> >>> removal
> >>>
> >>> On 2017-05-29 14:47, Mika Westerberg wrote:
> >>>> On Mon, May 29, 2017 at 01:33:29PM +0200, Jan Kiszka wrote:
> >>>>> Enhance acpi_load_table to also return the table index. Use that
> >>>>> index to unload the table again when the corresponding directory in
> >>>>> configfs gets removed. This allows to change SSDTs without rebooting
> >>> the system.
> >>>>> It also allows to destroy devices again that a dynamically loaded
> >>>>> SSDT created.
> >>>>>
> >>>>> This is widely similar to the DT overlay behavior.
> >>>>>
> >>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>> ---
> >>>>>
> >>>>> Can someone explain to me why an unloaded table still sticks around
> >>>>> in sysfs and why we cannot release its ID and rather have to use a
> >>>>> new one when loading a modified version?
> >>>>
> >>>> IIRC ACPICA relies the fact that SSDTs are never unloaded. Bob (CC'd)
> >>>> can correct me if I got it wrong.
> >>>
> >>
> >>
> >> [Moore, Robert]
> >>
> >> I'm not entirely sure what the table manager code looks like at this time, but ACPICA does in fact support table unloading.
> >>
> >> It is a rather dangerous thing to do, however -- unless you are careful about it. Basically, all handles that reference the table to be unloaded will go bad.
> > 
> > Right.
> > 
> > Linux should handle that in theory, but the code in there is mostly
> > very lightly tested AFAICS.
> > 
> >>> OK... Is that standard-driven or just a limitation of this
> >>> implementation?
> >>>
> >>> Is there an upper limit of tables? I'm thinking of lengthy development
> >>> sessions that play with tables, loading and unloading modified versions.
> >>>
> >>
> >> [Moore, Robert]
> >>
> >> I think that the maximum number of loaded ACPI tables is 255 at any given time. However, things are cleaned up after an unload such that repeated load/unload cycles should not consume resources.
> > 
> > I'm not sure if this is going to work seamlessly right away, but it
> > certainly can be made work.
> > 
> > That said, the change as proposed would be an API modification forcing
> > all of the OSes using ACPICA to change (or to carry out-of-the-tree
> > patches), so not nice.
> > 
> > What about adding a separate version of acpi_load_table() returning an
> > index (or an error on failures) instead of the status and leaving the
> > existing acpi_load_table() as is?
> 
> Sure. Any reference/preference in naming and locating that version?
> Should I leave acpica/ untouched at best? acpi_table_load/unload look
> simple enough to carry the logic in acpi_configfs directly.

Let's do that for the time being.

Later on we may decide to move that back into upstream ACPICA, but let's
get things to work on the Linux side first IMO.

Thanks,
Rafael

