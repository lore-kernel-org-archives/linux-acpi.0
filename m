From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI / video: clean up DMI table for initial black screen problem
Date: Sat, 16 Nov 2013 02:28:47 +0100
Message-ID: <1811092.ouA97g8YiM@vostro.rjw.lan>
References: <1367828623-22998-1-git-send-email-alex.hung@canonical.com> <528593F5.2010901@intel.com> <5285C190.8030000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51237 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751481Ab3KPBQP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Nov 2013 20:16:15 -0500
In-Reply-To: <5285C190.8030000@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Gustavo Maciel Dias Vieira <gustavo@sagui.org>, Alex Hung <alex.hung@canonical.com>, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Friday, November 15, 2013 02:39:12 PM Aaron Lu wrote:
> With commit 2c62333a408f "ACPI / video: Quirk initial backlight level 0"
> we do not need to have the following systems in DMI table, so remove them.
> HP Pavilion m4, HP 1000 Notebook PC, HP Pavilion g6 Notebook PC,
> HP Pavilion dm4, Fujitsu E753, HP Folio 13-2000.
> 
> With this change, the use_bios_initial_backlight module parameter is no
> longer needed and thus removed.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Tested-by: Alex Hung <alex.hung@canonical.com> # for HP 1000 Notebook PC
> Tested-by: Gustavo Maciel Dias Vieira <gustavo@sagui.org> # for HP Pavilion dm4

Queued up for the next ACPI pull request, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
