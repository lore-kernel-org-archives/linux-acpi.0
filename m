From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] PM: Asynchronous suspend and resume of devices
Date: Thu, 27 Aug 2009 00:25:34 +0200
Message-ID: <200908270025.34821.rjw@sisk.pl>
References: <200908262217.19609.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <200908262217.19609.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 26 August 2009, Rafael J. Wysocki wrote:
> Hi,
> 
> The following patches introduce a mechanism allowing us to execute device
> drivers' suspend and resume callbacks asynchronously during system sleep
> transitions, such as suspend to RAM.
> 
> The idea is explained in the changelogs of the first two patches.
> 
> Comments welcome.

Forgot to say, the patchset is on top of the linux-next branch of suspend-2.6.

Thanks,
Rafael
