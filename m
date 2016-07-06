From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/init: Correct the comments about acpi_subsystem_init
Date: Wed, 06 Jul 2016 23:32:59 +0200
Message-ID: <1617053.AnIizLWWUT@vostro.rjw.lan>
References: <1467602039-13186-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51763 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755798AbcGFV2Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jul 2016 17:28:24 -0400
In-Reply-To: <1467602039-13186-1-git-send-email-bhe@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, July 04, 2016 11:13:59 AM Baoquan He wrote:
> In acpi_subsystem_init, function acpi_enable_subsystem is called to do
> the real job. However with different flags passed to acpi_enable_subsystem,
> different code is executed. In acpi_subsystem_init with "~ACPI_NO_ACPI_ENABLE"
> passed in it will only switch over the platform to the ACPI mode. The rest
> part of acpi_enable_subsystem is done when acpi_bus_init is called.
> 
> So the comments above acpi_subsystem_init is not exact, change it here.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Applied, thanks!

