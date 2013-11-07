From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Subject: Re: [RFC PATCH][SeaBIOS] Add _PXM to CPU objects for NUMA hot-plug
Date: Thu, 7 Nov 2013 12:11:14 +0200
Message-ID: <20131107101114.GA2570@shadowkeep>
References: <1382693530-31137-1-git-send-email-vasilis.liaskovitis@profitbricks.com>
 <20131104105149.GB30503@dhcp-192-168-178-175.profitbricks.localdomain>
 <20131106025239.GA18207@morn.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:54268 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab3KGKLU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2013 05:11:20 -0500
Received: by mail-bk0-f47.google.com with SMTP id d7so128703bkh.6
        for <linux-acpi@vger.kernel.org>; Thu, 07 Nov 2013 02:11:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131106025239.GA18207@morn.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kevin O'Connor <kevin@koconnor.net>
Cc: seabios@seabios.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, wency@cn.fujitsu.com, thilo.fromm@profitbricks.com

Hi,

On Tue, Nov 05, 2013 at 09:52:39PM -0500, Kevin O'Connor wrote:
> On Mon, Nov 04, 2013 at 11:51:49AM +0100, Vasilis Liaskovitis wrote:
> > Any comment on this?
> > 
> > On Fri, Oct 25, 2013 at 11:32:10AM +0200, Vasilis Liaskovitis wrote:
> > > This patch adds a _PXM object to seabios CPU objects. The _PXM value is derived
> > > from CPU SRAT entries, so build_ssdt needs to be called after build_srat for
> > > this to work.
> 
> I think ACPI changes should be done at QEMU.  Going forward, QEMU will
> pass the tables into SeaBIOS.

ok, I will resend a qemu-side patch.

thanks,

- Vasilis
