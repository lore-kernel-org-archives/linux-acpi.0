From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [linux-pm] ACPI/ACPICA: resume hang (battery related)
Date: Sun, 22 Nov 2009 15:36:11 +0200
Message-ID: <1258896971.3432.6.camel@maxim-laptop>
References: <1258664394.3611.8.camel@maxim-laptop>
	 <200911192255.45447.rjw@sisk.pl>  <1258670277.27524.4.camel@maxim-laptop>
	 <1258892448.3231.23.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:32928 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbZKVNgL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Nov 2009 08:36:11 -0500
Received: by fxm5 with SMTP id 5so3870538fxm.28
        for <linux-acpi@vger.kernel.org>; Sun, 22 Nov 2009 05:36:16 -0800 (PST)
In-Reply-To: <1258892448.3231.23.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

I had just disabled the AC driver, yeah, got similar backtrace from acpi
video driver.

Ok, enough, pattern is visible.
The common point is that all backtraces lead to
acpi_ex_acquire_global_lock

According to sources, it is only taken on access to ACPI hardware ranges
that are marked as 'Lock'.

On my system only EC space is marked as such, thus this leads me to two
conclusions.

Ether during suspend EC access isn't synced (this is, EC transaction is
still pending),or that EC gets busted (suprise...) on resume or suspend,
and first read/write cycle to/from it never finishes.

I am using hibernate cycles using 'reboot' mechanism.


Best regards,
Maxim Levitsky

