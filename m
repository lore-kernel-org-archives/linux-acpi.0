From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/4] ACPI: Support _OSI("Darwin") correctly
Date: Thu, 19 Jun 2014 01:42:56 +0200
Message-ID: <3186737.5xBXzTniGn@vostro.rjw.lan>
References: <1401640436-1947-1-git-send-email-matthew.garrett@nebula.com> <20140617144614.GA16934@srcf.ucam.org> <20140618052615.GA26873@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64513 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754167AbaFRXZV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jun 2014 19:25:21 -0400
In-Reply-To: <20140618052615.GA26873@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com

On Wednesday, June 18, 2014 06:26:15 AM Matthew Garrett wrote:
> On Tue, Jun 17, 2014 at 03:46:15PM +0100, Matthew Garrett wrote:
> > On Tue, Jun 17, 2014 at 02:11:36PM +0200, Rafael J. Wysocki wrote:
> > > Does applying this patch without the rest of the series makes things worse
> > > or better on the machines in question (or perhaps it doesn't matter at all
> > > alone)?
> > 
> > On its own, I think this will do nothing.
> 
> Ugh, no, sorry - on its own, this will break PCIe hotplug events and 
> battery reporting. It should only be merged with the others.

Well, in that case it is not useful to split that material into
multiple patches.  And it will need to be Linux-specific, as adding
patch [1/4] to upstream ACPICA might break some other OSes using it.

Rafael

