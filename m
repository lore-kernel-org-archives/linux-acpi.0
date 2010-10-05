From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/5] ACPI: Bind implicit GPE dependencies to PCI devices
Date: Wed, 6 Oct 2010 01:37:29 +0200
Message-ID: <201010060137.29369.rjw@sisk.pl>
References: <1286216549-5438-1-git-send-email-mjg@redhat.com> <1286216549-5438-4-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48419 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756357Ab0JEXij (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Oct 2010 19:38:39 -0400
In-Reply-To: <1286216549-5438-4-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

On Monday, October 04, 2010, Matthew Garrett wrote:
> Several platforms provide GPE information about devices in ACPI, but provide
> no ACPI methods to handle these at runtime. Provide a default handler for
> this case and bind it to PCI devices as they're discovered in ACPI space.
> Keep the methods associated in case they have side effects.

I think I'd prefer it if ACPICA maintained a list of devices to Notify() if
the given GPE triggers.  That would require us to redefine
acpi_gpe_can_wake() a bit, but that should be generally more
efficient.

Thanks,
Rafael
