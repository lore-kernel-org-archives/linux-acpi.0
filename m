From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH]  ACPI / Video: Fix initial brightness problem on Acer Ferrari One
Date: Tue, 6 Apr 2010 20:51:16 +0200
Message-ID: <201004062051.16998.rjw@sisk.pl>
References: <201004010319.19366.rjw@sisk.pl> <201004050119.19790.rjw@sisk.pl> <1270533897.24064.4575.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33144 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756888Ab0DFSsS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Apr 2010 14:48:18 -0400
In-Reply-To: <1270533897.24064.4575.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Moore, Robert" <robert.moore@intel.com>

On Tuesday 06 April 2010, Zhang Rui wrote:
> On Mon, 2010-04-05 at 07:19 +0800, Rafael J. Wysocki wrote:
> > On Friday 02 April 2010, Rafael J. Wysocki wrote:
> > > On Friday 02 April 2010, Zhang Rui wrote:
> > > > On Fri, 2010-04-02 at 03:45 +0800, Rafael J. Wysocki wrote:
> > > > > On Thursday 01 April 2010, Zhang Rui wrote:
> > > > > > On Thu, 2010-04-01 at 09:34 +0800, Zhang Rui wrote:
> > > > > > > On Thu, 2010-04-01 at 09:19 +0800, Rafael J. Wysocki wrote:
> > 
> > This patch may not be necessary after all.
> > 
> > I'll repost it if I find it's still needed.
> > 
> okay.
> I re-read the code and find out that you're right. sorry for the noise.
> 
> please feel free to add an Acked-by from me next time you send it to the
> list.

Thanks, but it looks like only one box is affected and because its BIOS returns
the minimal brightness value in the initial _BQC.  I'm not sure if it's worth
changing the current behavior because of that.

Rafael
