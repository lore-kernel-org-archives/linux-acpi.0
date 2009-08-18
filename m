From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC][PATCH 0/7] PM: Asynchronous suspend and resume (updated)
Date: Tue, 18 Aug 2009 15:16:33 +0800
Message-ID: <1250579793.5351.79.camel@rzhang-dt>
References: <200908122218.13975.rjw@sisk.pl>
	 <200908170215.21173.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:28123 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbZHRHSI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Aug 2009 03:18:08 -0400
In-Reply-To: <200908170215.21173.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@linux.intel.com>, Greg KH <gregkh@suse.de>

On Mon, 2009-08-17 at 08:15 +0800, Rafael J. Wysocki wrote:
> On Wednesday 12 August 2009, Rafael J. Wysocki wrote:
> > Hi,
> >=20
> > The following patches introduce a mechanism allowing us to execute =
device
> > drivers' suspend and resume callbacks asynchronously during system =
sleep
> > transitions, such as suspend to RAM.  The idea is explained in the =
[1/1] patch
> > message.
>=20
> Changes:
>=20
> * Added [1/7] that fixes kerneldoc comments in drivers/base/power/mai=
n.c
>   (this is a 2.6.32 candidate).
>=20
> * Added [2/7] adding a framework for representing PM link (idea descr=
ibed
>   in the patch message).
>=20
> * [3/7] is the async resume patch (idea described in the patch messag=
e).
>=20
> * [4/7] is the async suspend patch.
>=20
> * [5/7] - [7/7] set async_suspend for devices in a few selected subsy=
stems.
>=20
> The patches have been tested on HP nx6325.
>=20
I tried this patch set and it does work. :)
But unfortunately it doesn't save too much time.

I still think that the child device should inherit its parent's
async_suspend flag to do the asynchronous resume more efficiently.

or at least we should provide such an interface
in =EF=BB=BFdrivers/base/power/common.c, so that device can tell the de=
vice core
to inherit this flag if there is no off-tree dependency.

thanks,
rui

> Thanks,
> Rafael
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
