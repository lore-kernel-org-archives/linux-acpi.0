From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] acpica events: Call acpi_os_hotplug_execute on
 Ejection Requests
Date: Fri, 23 Sep 2011 16:37:32 +0100
Message-ID: <20110923153732.GA31605@srcf.ucam.org>
References: <1316733417-22528-1-git-send-email-prarit@redhat.com>
 <CAErSpo70F012EEh3TEdgK=rSst-27P-j8JxMDkcUaJGd29BnDg@mail.gmail.com>
 <20110923011311.GA18632@srcf.ucam.org>
 <CAErSpo5uAg6wAP8jfDcrLDXh-Z86S+hD91Qkz=Mi4QMkkMtNuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58847 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709Ab1IWPhg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Sep 2011 11:37:36 -0400
Content-Disposition: inline
In-Reply-To: <CAErSpo5uAg6wAP8jfDcrLDXh-Z86S+hD91Qkz=Mi4QMkkMtNuA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-acpi@vger.kernel.org

On Fri, Sep 23, 2011 at 09:29:19AM -0600, Bjorn Helgaas wrote:
> On Thu, Sep 22, 2011 at 7:13 PM, Matthew Garrett <mjg@redhat.com> wrote:
> > We're seeing an increasing number of machines that use acpi
> > notifications to trigger rescans of devices - for instance, SD readers
> > that only appear on the PCI bus once a card has been inserted. These
> > often fail to flag themselves as removable or ejectable, so the acpiphp
> > core never binds. I think we need to fix this pretty urgently, for PCI
> > if nothing else.
> 
> Can you elaborate on this a bit?  I certainly agree that Prarit's
> process hang needs to be fixed, but it sounds like you're talking
> about the larger issue of the ACPI core not supporting hotplug.

Yup.

> I think that since the core doesn't do hotplug, we can't deal with
> hot-add of any ACPI devices unless we have already loaded a driver
> that has hotplug support for that device.  And acpiphp is not really a
> "driver," in the sense that it doesn't bind to a specific PNP ID and
> there isn't a good way to autoload it.

Indeed. Worse, it only binds to devices that have _RMV or _EJ* methods.

> If we moved most of the notification parts of acpiphp into the core,
> maybe that would be a step towards handling these SD readers and
> similar devices?

I think so, yes.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
