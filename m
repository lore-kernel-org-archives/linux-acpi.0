From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 7/8] ACPI / PCI: Do not preserve _OSC control bits returned by a query (v2)
Date: Tue, 3 Aug 2010 11:33:37 +0200
Message-ID: <201008031133.37471.rjw@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl> <4C57A09B.9070206@jp.fujitsu.com> <4C57C182.7060407@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59684 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651Ab0HCJel (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Aug 2010 05:34:41 -0400
In-Reply-To: <4C57C182.7060407@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Tuesday, August 03, 2010, Hidetoshi Seto wrote:
> (2010/08/03 13:52), Kenji Kaneshige wrote:
> > (2010/08/03 6:59), Rafael J. Wysocki wrote:
> >> @@ -434,19 +432,6 @@ acpi_status acpi_pci_osc_control_set(acp
> >>       if ((root->osc_control_set&  control_req) == control_req)
> >>           goto out;
> >>
> >> -    /* Need to query controls first before requesting them */
> >> -    if (!root->osc_queried) {
> >> -        status = acpi_pci_query_osc(root, root->osc_support_set, NULL);
> >> -        if (ACPI_FAILURE(status))
> >> -            goto out;
> >> -    }
> >> -    if ((root->osc_control_qry&  control_req) != control_req) {
> >> -        printk(KERN_DEBUG
> >> -               "Firmware did not grant requested _OSC control\n");
> >> -        status = AE_SUPPORT;
> >> -        goto out;
> >> -    }
> > 
> > I think acpi_pci_osc_control_set() still need to query before commit
> > to ensure all the requested controls are granted to OS.
> > 
> > So the code needs to be
> > 
> >     status = acpi_pci_query_osc(root, root->osc_support_set, &control_req);
> >     if (ACPI_FAILURE(status))
> >         goto out;
> 
> Hum, since acpi_status acpi_pci_osc_control_set() is an exported
> function, we cannot be too careful here. 
> 
> OTOH, I think this second query should be done in caller too,
> i.e. pcie_port_acpi_setup() in patch [4/8].
> 
> Now:
>   pcie_port_acpi_setup()
>   {
>     flags = A|B|C|D;
>     acpi_pci_osc_control_query(handle, &flags);
>     /* note: flags might be changed after query */
>     acpi_pci_osc_control_set(handle, flags);
>   }
> 
> Strictly, it could be like:
> 
> New:
>   pcie_port_acpi_setup()
>   {
>     flags = A|B|C|D;
>     do {
>       pre_flags = flags;
>       acpi_pci_osc_control_query(handle, &flags);
>     } while (flags && pre_flags != flags);
>     if (flags)
>       acpi_pci_osc_control_set(handle, flags);
>   }
> 
> IMHO these checks are kind of preventive guard for corner cases,
> and I suppose it can be implemented by an incremental patch later.

OK

The assumption here is that the BIOS would only mask the bits it's not
going to grant control of and will do it in a consistent way.  So, I guess the
purpose of the change above would be to protect us from buggy BIOSes.

Thanks,
Rafael
