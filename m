From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: [regression] linux-3.14.0-rc5-.. kernel does not switch power off
Date: Sun, 9 Mar 2014 17:12:56 +0100
Message-ID: <CADDKRnCTBiGC2fkd1Utp7BY7vjORcHh4O9GgqfMP7iDfFkNKuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On shutdown power is not switched off. The harddisk is already down.
Reboot is working.

Last known good kernel is: 3.14.0-rc5-00265-gb01d4e6
=46irst known bad kernel is: 3.14.0-rc5-00287-gca62eec

=46UJITSU LIFEBOOK AH532/FJNBB1C, BIOS Version 1.09 05/22/2012

J=C3=B6rg
