From: Zdenek Kabelac <zkabelac@redhat.com>
Subject: Re: Acpi deadlocks with 3.7.0-rc4
Date: Thu, 29 Nov 2012 11:13:10 +0100
Message-ID: <50B73536.9060408@redhat.com>
References: <50A513A8.9010404@redhat.com> <CA+55aFyLMmKuEvY6T2=vSHp_R4=ndqFEFNJsc3Axze2vYknKhg@mail.gmail.com> <50B63A04.9010901@redhat.com> <CA+55aFy7hxayPzr3MiV1xc0bvLcd+-7b52iA3CYhbPZuWXr9yA@mail.gmail.com> <50B64996.1010709@redhat.com> <CA+55aFz2p2_WUkhThjSDWAFVda6nujxX2YE_Qkqv1OVDChUEJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42619 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645Ab2K2KNQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Nov 2012 05:13:16 -0500
In-Reply-To: <CA+55aFz2p2_WUkhThjSDWAFVda6nujxX2YE_Qkqv1OVDChUEJQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Dne 28.11.2012 20:07, Linus Torvalds napsal(a):
> whole "prefix_node" pointer is bogus. It seems to have the value 0x1000.

Tested also this patch with this result:

https://bugzilla.kernel.org/show_bug.cgi?id=51071#c8

So while it's made it pass suspend/resume, it's not really usable
as docking then.

Zdenek

