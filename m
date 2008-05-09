From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [linux-pm] [PATCH 2/2] PCI PM: Introduce pci_preferred_state
Date: Fri, 9 May 2008 10:37:23 -0700
Message-ID: <200805091037.23767.jbarnes@virtuousgeek.org>
References: <Pine.LNX.4.44L0.0805071139020.3701-100000@iolanthe.rowland.org> <200805091024.53027.jbarnes@virtuousgeek.org> <200805091934.41341.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-111.bluehost.com ([69.89.18.7]:36773 "HELO
	outbound-mail-111.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752097AbYEIRhh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 May 2008 13:37:37 -0400
In-Reply-To: <200805091934.41341.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Friday, May 09, 2008 10:34 am Rafael J. Wysocki wrote:
> > So in this case pci_choose_state would either change state or leave it
> > untouched if it didn't have a better idea about things.  But now that I
> > look at it I'm not sure it's an improvement. :)
>
> Well, in principle we could go farther and introduce a wrapper around
> pci_set_power_state() that will call platform_pci_choose_state() to obtain
> the new state or use the driver-provided one if that fails.

Hm, yeah that sounds pretty reasonable actually.  Especially given that so 
many drivers just do:
  pci_set_power_state(pdev, pci_choose_state(pdev, state));
anyway...

Jesse
