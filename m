From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / SBS: fix inconsistent indenting inside if statement
Date: Tue, 05 Jan 2016 13:58:54 +0100
Message-ID: <60513852.mJuouf0eX3@vostro.rjw.lan>
References: <1451692425-4667-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60306 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751590AbcAEM2O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2016 07:28:14 -0500
In-Reply-To: <1451692425-4667-1-git-send-email-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, January 01, 2016 11:53:45 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The indenting in acpi_battery_set_alarm is inconsistent and has been
> so since 2007; commit 94f6c0860139da9219255b8ff45ad42117dda859
> ("ACPI: SBS: Add support for power_supply class (and sysfs)"). Minor
> fix for this, no code functionality change.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks!

Rafael

