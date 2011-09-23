From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] acpica events: Call acpi_os_hotplug_execute on Ejection Requests
Date: Fri, 23 Sep 2011 09:29:19 -0600
Message-ID: <CAErSpo5uAg6wAP8jfDcrLDXh-Z86S+hD91Qkz=Mi4QMkkMtNuA@mail.gmail.com>
References: <1316733417-22528-1-git-send-email-prarit@redhat.com>
 <CAErSpo70F012EEh3TEdgK=rSst-27P-j8JxMDkcUaJGd29BnDg@mail.gmail.com> <20110923011311.GA18632@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:5844 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813Ab1IWP3l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Sep 2011 11:29:41 -0400
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com [172.24.198.77])
	by smtp-out.google.com with ESMTP id p8NFTfGO006556
	for <linux-acpi@vger.kernel.org>; Fri, 23 Sep 2011 08:29:41 -0700
Received: from yia25 (yia25.prod.google.com [10.243.65.25])
	by wpaz13.hot.corp.google.com with ESMTP id p8NFTdD0016678
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 23 Sep 2011 08:29:40 -0700
Received: by yia25 with SMTP id 25so3279290yia.0
        for <linux-acpi@vger.kernel.org>; Fri, 23 Sep 2011 08:29:39 -0700 (PDT)
In-Reply-To: <20110923011311.GA18632@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-acpi@vger.kernel.org

On Thu, Sep 22, 2011 at 7:13 PM, Matthew Garrett <mjg@redhat.com> wrote:
> We're seeing an increasing number of machines that use acpi
> notifications to trigger rescans of devices - for instance, SD readers
> that only appear on the PCI bus once a card has been inserted. These
> often fail to flag themselves as removable or ejectable, so the acpiphp
> core never binds. I think we need to fix this pretty urgently, for PCI
> if nothing else.

Can you elaborate on this a bit?  I certainly agree that Prarit's
process hang needs to be fixed, but it sounds like you're talking
about the larger issue of the ACPI core not supporting hotplug.

I think that since the core doesn't do hotplug, we can't deal with
hot-add of any ACPI devices unless we have already loaded a driver
that has hotplug support for that device.  And acpiphp is not really a
"driver," in the sense that it doesn't bind to a specific PNP ID and
there isn't a good way to autoload it.

If we moved most of the notification parts of acpiphp into the core,
maybe that would be a step towards handling these SD readers and
similar devices?
