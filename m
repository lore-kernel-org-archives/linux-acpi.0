From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/2] Deliver ACPI events upon subscription and implement multiple readers for /proc/acpi/event
Date: Wed, 25 Jan 2006 00:14:28 +0100
Message-ID: <1138144468337-git-send-email-malattia@linux.it>
Reply-To: Mattia Dongili <malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 213-140-2-73.ip.fastwebnet.it ([213.140.2.73]:10472 "EHLO
	aa006msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750819AbWAXXNi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jan 2006 18:13:38 -0500
In-Reply-To: 
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Mattia Dongili <malattia@linux.it>


Hello.

This patch series revamps an old submission[1] from Dmitry Torokhov that
adds support for multiple readers on /proc/acpi/event.

Due to the code reorganization happened in the last 1.5 years I
re-implemented it a little differently introducing a subscription
mechanism to receive events (it might be used in different context
also). driver/acpi/event.c uses it to register a new listener for each
process opening the /proc/acpi/event file.

I was also wondering if this could fit the recent discussion on
"Untangling the sleep hotkey mess"[2] to allow event deliver through
the input subsystem (yes, a proposed solution was the other way around
but this might still be a viable implementation).

[1]: http://marc.theaimsgroup.com/?l=acpi4linux&m=109333066714671&w=2
[2]: sorry, can't find the beginning of the thread
     http://marc.theaimsgroup.com/?l=linux-acpi&m=113676899930391&w=2

Dmitry, I don't know how to apply the signed-off thing correctly here,
in the meantime:

Signed-off-by: Mattia Dongili <malattia@linux.it>

