From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: ACPI-fan: Another source code review around null pointer handling?
Date: Fri, 25 Dec 2015 11:35:29 +0100
Message-ID: <567D1BF1.6060701@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:65272 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683AbbLYKg0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Dec 2015 05:36:26 -0500
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

Hello,

I have looked at the source file for the ACPI fan driver once more.
I would appreciate if a specific implementation detail can be clarified there.

Static source code analysis can point out that functions like the following
share an approach for error detection and corresponding exception handling.
* acpi_fan_get_fif
* acpi_fan_get_fps
* fan_get_state_acpi4
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/acpi/fan.c?id=80c75a0f1d81922bf322c0634d1e1a15825a89e6#n107

Can it matter eventually to handle a detected null pointer differently from
further checks for an attribute like "obj->type" or "obj->package"?

Regards,
Markus
