From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: [v3.20]: Missing /sys/class/ACAD directory OR Cannot release Mutex
Date: Sun, 22 Feb 2015 13:33:09 +0100
Message-ID: <CADDKRnDO7LAr5bg-5TJ-2=Va3kBw-cWqDvWoL3omWVJHUUd7tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:55328 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbbBVMdL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Feb 2015 07:33:11 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Starting with kernel 3.19.0-05184-g18320f2, I often find my notebook
running with 'powersave' policy even if it is on AC.

It turned out that /sys/class/ACAD directory is missing and in the
logs I see:

ACPI Error: Cannot release Mutex [MUT0], not acquired (20150204/exmutex=
-376)
ACPI Error: Method parse/execution failed [\_SB_.ACAD._PSR] (Node
ffff880216028d48), AE_AML_MUTEX_NOT_ACQUIRED (20150204/psparse-536)
ACPI Exception: AE_AML_MUTEX_NOT_ACQUIRED, Error reading AC Adapter
state (20150204/ac-131)

At the last 25 startups since 3.19.0-05184-g18320f2 it occured 13 times=
=2E

It does not occur with kernels older than 3.19.0-05184-g18320f2.

Thanks, J=C3=B6rg
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
