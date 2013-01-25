From: David Rientjes <rientjes@google.com>
Subject: Re: [patch] sysfs: Fix build when sysfs is disabled
Date: Fri, 25 Jan 2013 13:34:28 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301251334090.25226@chino.kir.corp.google.com>
References: <3307415.pdOY6ovZLa@vostro.rjw.lan> <1511541.AH8DLsNQJH@vostro.rjw.lan> <alpine.DEB.2.00.1301251211410.3815@chino.kir.corp.google.com> <2337783.BBmzZI9Lts@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57636 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab3AYVea (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Jan 2013 16:34:30 -0500
Received: by mail-pb0-f46.google.com with SMTP id uo15so441431pbc.33
        for <linux-acpi@vger.kernel.org>; Fri, 25 Jan 2013 13:34:29 -0800 (PST)
In-Reply-To: <2337783.BBmzZI9Lts@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kristen C. Accardi" <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 25 Jan 2013, Rafael J. Wysocki wrote:

> Can you please send me the .config that triggered those errors?  It will be
> useful for future build testing.
> 

Anything with CONFIG_SYSFS disabled.
