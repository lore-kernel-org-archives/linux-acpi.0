From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 01/10] ACPI: support acpi_device_ops .notify methods
Date: Fri, 3 Apr 2009 15:14:47 +0200
Message-ID: <200904031514.50482.trenn@suse.de>
References: <20090330174646.20905.18465.stgit@bob.kio> <200904021556.32810.trenn@suse.de> <200904020903.21140.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42265 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381AbZDCNPD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Apr 2009 09:15:03 -0400
In-Reply-To: <200904020903.21140.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Alexander Graf <agraf@suse.de>
Cc: kamezawa.hiroyu@jp.fujitsu.com, y-goto@jp.fujitsu.com, Len Brown <lenb@kernel.org>, Tony Vroon <tony@linx.net>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

On Thursday 02 April 2009 17:03:19 Bjorn Helgaas wrote:
> On Thursday 02 April 2009 07:56:28 am Thomas Renninger wrote:
> > On Monday 30 March 2009 19:48:13 Bjorn Helgaas wrote:
> > > This patch adds support for ACPI device driver .notify() methods.  If
> > > such a method is present, Linux/ACPI installs a handler for device
> > > notifications (but not for system notifications such as Bus Check,
> > > Device Check, etc).  When a device notification occurs, Linux/ACPI
> > > passes it on to the driver's .notify() method.
> > I sent more or less the same some years ago.
> > Thanks a lot for finally cleaning this up!
> 
> Hi Thomas,
> 
> Oh, sorry, I didn't know that, or I would have given you some credit :-)
> In fact, if you have a URL, I'll add a pointer to the changelog.  I
> always like to leave breadcrumbs to help future research.
I only find the acpi_memhotplug things, but I remember I suggested
(maybe privately?) to introduce a .notify callback.
Hmm, I even had some code, but got cold feet when I realized that not
present devices have to call .add or .start functions...
While this is not much worth crediting :), I just want to give you the
feedback I missed, IMO you are going the right way.

    Thomas
