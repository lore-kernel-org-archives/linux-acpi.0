From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] cpuidle: fix new C-states not functional after AC disconnect
Date: Sun, 13 Jan 2013 20:30:42 +0100
Message-ID: <CA+icZUXCObXMqVMNLFL58fZCBzo8dv+mqa7Ue_+jVfAdaYG45A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:39359 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755765Ab3AMTan (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Jan 2013 14:30:43 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, daniel.lezcano@linaro.org, Linux ACPI <linux-acpi@vger.kernel.org>

Hi Thomas,

I read your original LKML posting in [1].

[ QUOTE ]
Currently, Daniel Lezcano seems to be working on an intrusive change of not
using the power_usage value at all for choosing a C-state:

[4] https://lkml.org/lkml/2012/12/14/155

As I could not find any of these patches in any git trees to be merged for
3.8...
[ /QUOTE ]

You can find the patches at LKML ([2] and [3]) or patchwork ([4] and [5]).

As a Linux-Next "customer" I know about Daniel's work for-next [5] but
I did not found any other GIT repository of him.
Striving through Daniel's other GIT repos I found idlestat [6] and
powerdebug [7] tools which I want to test.
( So, thank you for your email! )

Have fun!

Regards,
- Sedat -

[0] http://marc.info/?l=linux-acpi&m=135808048905350&w=2
[1] https://lkml.org/lkml/2012/12/14/153
[2] https://lkml.org/lkml/2012/12/14/149
[3] https://patchwork.kernel.org/patch/1878691/
[4] https://patchwork.kernel.org/patch/1878701/
[5] http://git.linaro.org/gitweb?p=people/dlezcano/cpuidle-next.git
[6] http://git.linaro.org/gitweb?p=people/dlezcano/idlestat.git;a=summary
[7] http://git.linaro.org/gitweb?p=people/dlezcano/powerdebug.git;a=summary
