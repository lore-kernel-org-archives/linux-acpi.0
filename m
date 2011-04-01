From: Norbert Preining <preining@logic.at>
Subject: Lenovo Thinkpad Edge: suspend to ram works, but wake up not
Date: Fri, 1 Apr 2011 11:10:55 +0900
Message-ID: <20110401021055.GB6071__11457.3358362124$1301628323$gmane$org@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:48302 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203Ab1DADZQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Mar 2011 23:25:16 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Dear all,

I got a new laptop, Lenovo Thinkpad Edge (intel , intel graphic)
and I am running 2.6.39-rc1 on it (but tried also 2.6.38).

Suspend to RAM, either by pm-suspend or by echo "mem" >/sys/..
works, both wiht  running or from a recovery session where nothing
else is running.

But wake-up hangs the machine. The video comes back, I see the last
lines I typed before I suspended, but after that no keypress nor
anything else (Sysrq) does work, but 4sec-hard-off. No traces in the
log files.

ANy suggestions how to proceed and debug that?

Thanks a lot and all the best

Norbert
------------------------------------------------------------------------
Norbert Preining            preining@{jaist.ac.jp, logic.at, debian.org}
JAIST, Japan                                 TeX Live & Debian Developer
DSA: 0x09C5B094   fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
------------------------------------------------------------------------
ARDSCALPSIE (n.)
Excuse made by rural Welsh hairdresser for completely massacring your
hair.
			--- Douglas Adams, The Meaning of Liff
