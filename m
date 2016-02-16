From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / tables: Add acpi_force_32bit_fadt_addr option to force 32 bit FADT addresses
Date: Tue, 16 Feb 2016 21:59:31 +0100
Message-ID: <3437356.OAWebRV9e2@vostro.rjw.lan>
References: <1453395947-1567-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52489 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752214AbcBPU6K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2016 15:58:10 -0500
In-Reply-To: <1453395947-1567-1-git-send-email-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Jonathan Corbet <corbet@lwn.net>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, January 21, 2016 05:05:47 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> BugLink: https://bugs.launchpad.net/bugs/1529381
> 
> Some HP laptops seem to have invalid 64 bit FADT X_PM* addresses
> which are causing various boot issues.  In these cases, it would
> be useful to force ACPI to use the valid legacy 32 bit equivalent
> PM addresses.  Add a acpi_force_32bit_fadt_addr to set the ACPICA
> acpi_gbl_use32_bit_fadt_addresses to TRUE to force this override.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I've queued this up for 4.6 with some minor changes in the subject/changelog.

Thanks,
Rafael

