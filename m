From: Ognjen Galic <smclt30p@gmail.com>
Subject: Re: [PATCH v2] thinkpad_acpi: Support the battery wear control
Date: Mon, 4 Dec 2017 20:55:24 +0100
Message-ID: <20171204195524.GA25730@thinkpad>
References: <20171203225640.GA11655@thinkpad>
 <3171660.sUGE0a2FEN@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:44059 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbdLDTz2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Dec 2017 14:55:28 -0500
Content-Disposition: inline
In-Reply-To: <3171660.sUGE0a2FEN@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Mon, Dec 04, 2017 at 03:53:32PM +0100, Rafael J. Wysocki wrote:

> Not really.
> 
> This is generic code, so no thinkpad_acpi-specific stuff in this file, please,
> even under #ifdefs.
> 

I have some ideas, and I want your confirmation if that would be
acceptable.

Can I do this:

Expose a new API from battery.c for platform specific hooks:

struct battery_hook {
	int (*add_battery)(struct acpi_battery* battery);
	int (*remove_battery)(struct acpi_battery *battery);
};

battery_hook_register(struct battery_hook *hook)
battery_hook_unregister(struct battery_hook *hook)

When that hook is invoked from some other module, battery.c 
calls the add_battery method for each battery that is added and
remove_battery for each battery that is removed.

battery.c would keep a list of the battery_hook structs and invoke 
the add_battery and remove_battery methods as batteries get added 
and removed. 

With this API, we can add more hooks for battery features in 
the future, not just the ThinkPad hooks.

I hope you like the proposal :)

