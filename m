From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Patch to correct battery capacity values on Thinkpads (repost)
Date: Fri, 16 Nov 2012 22:46:07 +0100
Message-ID: <2078100.fvvKhnd6Mi@vostro.rjw.lan>
References: <20121112050935.GA25110@scooby.iskra.name> <20121112202202.GA18138@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:49677 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700Ab2KPVlo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Nov 2012 16:41:44 -0500
In-Reply-To: <20121112202202.GA18138@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Kamil Iskra <kamil@iskra.name>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Monday, November 12, 2012 06:22:03 PM Henrique de Moraes Holschuh wrote:
> On Sun, 11 Nov 2012, Kamil Iskra wrote:
> > Please find below a patch to drivers/acpi/battery.c that adds a quirk to
> > correctly report battery capacity on 2010 and 2011 Lenovo Thinkpad models.
> > I think the patch is ready to be applied (Len: please apply).  However,
> > since it specifically affects Thinkpads, I've copied ibm-acpi-devel ML on
> > this message to give them a chance to provide input, if any.
> 
> FWIW,
> 
> Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Applied to the linux-next branch of the linux-pm.git tree as v3.8 material.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
