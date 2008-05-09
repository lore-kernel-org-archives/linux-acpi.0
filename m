From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [linux-pm] [PATCH 2/2] PCI PM: Introduce pci_preferred_state
Date: Fri, 9 May 2008 15:13:03 -0700
Message-ID: <200805091513.04194.jbarnes@virtuousgeek.org>
References: <Pine.LNX.4.44L0.0805071139020.3701-100000@iolanthe.rowland.org> <200805091037.23767.jbarnes@virtuousgeek.org> <200805092344.53713.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-135.bluehost.com ([67.222.39.25]:52006 "HELO
	outbound-mail-135.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754593AbYEIWNR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 May 2008 18:13:17 -0400
In-Reply-To: <200805092344.53713.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Friday, May 09, 2008 2:44 pm Rafael J. Wysocki wrote:
> Okay, what about this:
>
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> The new suspend and hibernation callbacks introduced with
> 'struct pm_ops' and 'struct pm_ext_ops' do not take a
> pm_message_t argument, so the drivers using them will not be able
> to use pci_choose_state() in its present form.  For this reason,
> introduce a new function, pci_choose_and_set_state(), playing the
> role of pci_choose_state() combined with pci_set_power_state() and
> allowing the driver to put the device into a power state chosen by
> the platform.

Yeah, that looks pretty good.  The name is long but I can't think of a better 
one offhand.  Can you also update Documentation/power/pci.txt with the latest 
best practices?  I wonder if we should do a pass through the drivers 
converting them to this interface as well...

Thanks,
Jesse
