From: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [SeaBIOS] [RFC PATCH] Add _PXM to CPU objects for NUMA hot-plug
Date: Wed, 6 Nov 2013 13:54:15 +0100
Message-ID: <20131106135415.1207cabb@nial.usersys.redhat.com>
References: <1382693530-31137-1-git-send-email-vasilis.liaskovitis@profitbricks.com>
	<20131104105149.GB30503@dhcp-192-168-178-175.profitbricks.localdomain>
	<1383596774.1847.12.camel@misato.fc.hp.com>
	<20131105102029.GA3933@shadowkeep>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28083 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756350Ab3KFMym (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Nov 2013 07:54:42 -0500
In-Reply-To: <20131105102029.GA3933@shadowkeep>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Cc: Toshi Kani <toshi.kani@hp.com>, thilo.fromm@profitbricks.com, seabios@seabios.org, rjw@sisk.pl, linux-acpi@vger.kernel.org

On Tue, 5 Nov 2013 12:20:29 +0200
Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com> wrote:

[...]
> > > > This issue may require a kernel fix alternatively or additionally to the seabios
> > > > fix: The kernel can save the originally parsed SRAT entry info somewhere before
> > > > it resets it at hot-remove time, and use that info on hot-plug time if the _PXM
> > > > value is missing for the hot-plugged CPU BIOS object. This way CPU hot-plug
> > > > works well against a BIOS with no CPU _PXM info.
> > 
> > To support CPU hotplug, seabios needs to implement _PXM to CPU or its
> > parent device object when the system has multiple nodes.

BTW: may we should compare linux behavior with Windows's one. usually MS implements
ACPI spec more strictly.


> ok, so no linux kernel changes are needed. Only adding PXM to seabios CPUs
> objects should be enough, which is what this RFC patch does. 
> 
> thanks,
> 
> - Vasilis
> > 
> > 
> > 
> > 
> 
> _______________________________________________
> SeaBIOS mailing list
> SeaBIOS@seabios.org
> http://www.seabios.org/mailman/listinfo/seabios

