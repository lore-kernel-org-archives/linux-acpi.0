From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to iomaps management
Date: Fri, 21 Jan 2011 13:01:12 +0100
Message-ID: <201101211301.12390.rjw@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl> <201101210104.43641.rjw@sisk.pl> <AANLkTi=3JZUa3AtfcxnSuS36ORZLbS2-M+fJAR6_Moof@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37272 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab1AUMB4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Jan 2011 07:01:56 -0500
In-Reply-To: <AANLkTi=3JZUa3AtfcxnSuS36ORZLbS2-M+fJAR6_Moof@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Friday, January 21, 2011, Jeff Chua wrote:
> 2011/1/21 Rafael J. Wysocki <rjw@sisk.pl>:
> > Thanks, but unfortunately this wasn't conclusive.  Please apply the patch below
> > instead of the previous one (on top of [1/11] - [11/11]) and collect dmesg
> > output containing a (failing) suspend attempt.
> >
> > Please attach full dmesg, so that I can see the size and address of your
> > system's NVS region.
> 
> Attached.

OK, I suspect the new code tries to map one page too many, but
I still don't know how many pages we are _supposed_ to map, because there's
no e820 information in your dmesg (I'm not sure exactly why).

Anyway, I'll have a replacement for [11/11] later today.

Thanks,
Rafael
