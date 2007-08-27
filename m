From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 0/3] PM: Improve ACPI handling during suspend and hibernation (rev. 3)
Date: Mon, 27 Aug 2007 23:47:44 +0200
Message-ID: <200708272347.45438.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965362AbXH0VzG@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

The patches in this series are intended to improve the handling of the =
ACPI
platform during suspend and hibernation.

They do the following things:
* make hibernation_platform_enter() consistent with the sleep state ent=
ering
=A0 code in kernel/power/main.c
* introduce global platform callbacks allowing us to handle ACPI in a m=
ore fine
=A0 grained way during suspend and hibernation
* improve the handling of the system status indicator during suspend an=
d
=A0 hibernation.

Greetings,
Rafael
