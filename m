From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: [intel-pstate driver regression] processor frequency very high even
 if in idle
Date: Tue, 29 Mar 2016 19:24:53 +0200
Message-ID: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35135 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757892AbcC2RYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Mar 2016 13:24:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "inux-kernel@vger.kernel.org" <inux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>

in v4.5 and earlier intel-pstate downscaled idle processors (load
0.1-0.2%) to minumum frequency, in my case 800MHz.

Now in v4.6-rc1 the characteristic has dramatically changed. If in
idle the processor frequency is more or less a few MHz around 2500Mhz.
This is the maximum non turbo frequency.

No difference between powersafe or performance governor.

I currently use acpi_cpufreq which works as usual.

Processor:
Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz (family: 0x6, model: 0x3c,
stepping: 0x3)

Last known good kernel is: 4.5.0-01127-g9256d5a
=46irst known bad kernel is: 4.5.0-02535-g09fd671

There is
commit 277edba Merge tag 'pm+acpi-4.6-rc1-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
in between, which brought a few changes in intel_pstate.

thanks, J=C3=B6rg
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
