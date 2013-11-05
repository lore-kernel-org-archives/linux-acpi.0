From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Subject: Re: [RFC PATCH][SeaBIOS] Add _PXM to CPU objects for NUMA hot-plug
Date: Tue, 5 Nov 2013 12:20:29 +0200
Message-ID: <20131105102029.GA3933@shadowkeep>
References: <1382693530-31137-1-git-send-email-vasilis.liaskovitis@profitbricks.com>
 <20131104105149.GB30503@dhcp-192-168-178-175.profitbricks.localdomain>
 <1383596774.1847.12.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:64093 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab3KEKUf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Nov 2013 05:20:35 -0500
Received: by mail-bk0-f42.google.com with SMTP id w16so1019713bkz.1
        for <linux-acpi@vger.kernel.org>; Tue, 05 Nov 2013 02:20:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1383596774.1847.12.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: seabios@seabios.org, linux-acpi@vger.kernel.org, kevin@koconnor.net, rjw@sisk.pl, wency@cn.fujitsu.com, thilo.fromm@profitbricks.com

Hi Toshi,

On Mon, Nov 04, 2013 at 01:26:14PM -0700, Toshi Kani wrote:
> On Mon, 2013-11-04 at 11:51 +0100, Vasilis Liaskovitis wrote:
> > Any comment on this?
> > 
> > On Fri, Oct 25, 2013 at 11:32:10AM +0200, Vasilis Liaskovitis wrote:
> > > This patch adds a _PXM object to seabios CPU objects. The _PXM value is derived
> > > from CPU SRAT entries, so build_ssdt needs to be called after build_srat for
> > > this to work.
> > > 
> > > The motivation for this patch is a CPU hot-unplug/hot-plug bug observed when
> > > using seabios and a 3.11 linux guest kernel on a multi-NUMA node qemu/kvm VM.
> > > The linux guest kernel parses the SRAT CPU entries at boot time and stores them
> > > in the array __apicid_to_node. When a CPU is hot-removed, the linux guest kernel
> > > resets the removed CPU's __apicid_to_node entry to NO_NUMA_NODE (kernel commit
> > > c4c60524). When the removed cpu is hot-added again, the linux kernel looks up
> > > the hot-added cpu object's _PXM  value instead of somehow re-using the SRAT
> > > entry info (acpi_map_cpu2node calls acpi_get_node which calls acpi_get_pxm). If
> > > the _PXM value is not found, the CPU is assumed to be on node 0, and it is
> > > hot-plugged in the wrong NUMA node.
> > > 
> > > Which is the preferred OSPM way of looking up a CPU's proximity info at hotplug
> > > time? Is it the CPU object's _PXM value, or the already-parsed CPU SRAT entry?
> > > Or maybe both ways are valid?
> 
> SRAT describes proximity values at boot-time.  During hotplug, the
> kernel is supposed to obtain the current proximity value from _PXM
> method.

thanks for the clarification.
> 
> > > This issue may require a kernel fix alternatively or additionally to the seabios
> > > fix: The kernel can save the originally parsed SRAT entry info somewhere before
> > > it resets it at hot-remove time, and use that info on hot-plug time if the _PXM
> > > value is missing for the hot-plugged CPU BIOS object. This way CPU hot-plug
> > > works well against a BIOS with no CPU _PXM info.
> 
> To support CPU hotplug, seabios needs to implement _PXM to CPU or its
> parent device object when the system has multiple nodes.

ok, so no linux kernel changes are needed. Only adding PXM to seabios CPUs
objects should be enough, which is what this RFC patch does. 

thanks,

- Vasilis
> 
> 
> 
> 
