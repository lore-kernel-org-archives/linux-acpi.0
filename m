From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2 2/4] toshiba_acpi: Support alternate hotkey
 interfaces
Date: Thu, 5 Jan 2012 18:25:22 +0000
Message-ID: <20120105182522.GD24242@srcf.ucam.org>
References: <1325617358-8286-1-git-send-email-seth.forshee@canonical.com>
 <1325617358-8286-3-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35173 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489Ab2AESZ0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Jan 2012 13:25:26 -0500
Content-Disposition: inline
In-Reply-To: <1325617358-8286-3-git-send-email-seth.forshee@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Len Brown <lenb@kernel.org>, Azael Avalos <coproscefalo@gmail.com>, Thomas Renninger <trenn@suse.de>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 03, 2012 at 01:02:36PM -0600, Seth Forshee wrote:
> There are two types of problems that prevent hotkeys from working
> on many of the machines supported by toshiba_acpi. The first of
> these is the lack of a functioning SCI for hotkey events. For these
> machines it is possible to filter the Fn keypresses from the
> keyboard and generate a notification by executing the ACPI NTFY
> method.
> 
> The second problem is a lack of support for HCI_SYSTEM_EVENT, which
> is used for reading the hotkey scancodes. On these machines the
> scancodes can be read by executing the ACPI NTFY method.
> 
> This patch fixes both problems by installing an i8042 filter when
> the NTFY method is present to generate notifications and by
> detecting which of INFO or HCI_SYSTEM_EVENT is supported for
> reading scancodes. If neither method of reading scancodes is
> supported, the hotkey input device is not registered.
> 
> Signed-off-by: Azael Avalos <coproscefalo@gmail.com>
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

It's still an awful way to implement things, but it doesn't seem like 
there's any alternative, so sure.

> +		error = i8042_install_filter(toshiba_acpi_i8042_filter);

If this is only needed for TOS1900 machines then I think I'd prefer to 
see it only done on them. Just add a flag to the data field of the IDs 
and check that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
