From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] acpi: Split out custom_method functionality into an own driver
Date: Tue, 29 Mar 2011 23:29:14 +0200
Message-ID: <201103292329.15026.rjw@sisk.pl>
References: <1301401990-35469-1-git-send-email-trenn@suse.de> <201103292136.50214.rjw@sisk.pl> <201103292311.10991.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53475 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615Ab1C2V3H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Mar 2011 17:29:07 -0400
In-Reply-To: <201103292311.10991.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org

On Tuesday, March 29, 2011, Thomas Renninger wrote:
> On Tuesday 29 March 2011 21:36:50 Rafael J. Wysocki wrote:
> > On Tuesday, March 29, 2011, Thomas Renninger wrote:
> > > With /sys/kernel/debug/acpi/custom_method root can write
> > > to arbitrary memory and increase his priveleges, even if
> > > these are restricted.
> > > 
> > > -> Make this an own debug .config option and warn about the
> > > security issue in the config description.
> > > 
> > > -> Still keep acpi/debugfs.c which now only creates and empty
> > >    /sys/kernel/debug/acpi directory. There might be other
> > >    users of it later.
> > > 
> > > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > > CC: Rafael J. Wysocki <rjw@sisk.pl>
> > > CC: lenb@kernel.org
> > > CC: rui.zhang@intel.com
> > > CC: linux-acpi@vger.kernel.org
> > 
> > OK, but you don't need to move custom_method to a separate file.  Why
> > are you doing that, exactly?
> Because there may come other acpi debugfs stuff added there and then
> it either needs ugly #ifdef logics inside the file or the split will be done then.
> Separating the code belonging to this option into an own
> file looks like the cleanest way to me.

Well, I don't really expect anything else to depend on
CONFIG_ACPI_CUSTOM_METHOD, or if it does, the options should be called
differently, right?

Thanks,
Rafael
