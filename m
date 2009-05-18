From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH]: ACPI: Skip the power state check in power transition
Date: Mon, 18 May 2009 08:13:55 +0100
Message-ID: <20090518071355.GA1710@srcf.ucam.org>
References: <1242106060.3773.216.camel@localhost.localdomain> <1242265659.3773.428.camel@localhost.localdomain> <20090514105626.GA17294@srcf.ucam.org> <200905141249.35822.bjorn.helgaas@hp.com> <1242612503.3685.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59023 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875AbZERHOE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 May 2009 03:14:04 -0400
Content-Disposition: inline
In-Reply-To: <1242612503.3685.15.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Witold Szczeponik <Witold.Szczeponik@gmx.net>

On Mon, May 18, 2009 at 10:08:23AM +0800, yakui_zhao wrote:

> The flag of "force_power_state" can't be removed. For example: The ACPI
> fan is in Off state. But the bogus bios reports that it is in D0 state.
> If there is no flag of "force_power_state", we can't turn on the FAN
> device.

If Windows never calls _STA in this case, why do we care that it's lying 
to us?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
