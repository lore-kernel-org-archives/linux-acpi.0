From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: [1/3] 2.6.23-rc2: known regressions
Date: Sun, 05 Aug 2007 18:26:17 +0200
Message-ID: <46B5FA29.2070509@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:26483 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbXHEQ1b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Aug 2007 12:27:31 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1215281fkz
        for <linux-acpi@vger.kernel.org>; Sun, 05 Aug 2007 09:27:29 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Markus <lists4me@web.de>

Hi all,

Here is a list of some known regressions in 2.6.23-rc2.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

List of Aces

Name                    Regressions fixed since 21-Jun-2007
Adrian Bunk                            6
Andi Kleen                             4
Andrew Morton                          4
Linus Torvalds                         4
Al Viro                                3
Cornelia Huck                          3
Jens Axboe                             3
Tejun Heo                              3
David Woodhouse                        2
Hugh Dickins                           2
Trent Piepho                           2



Unclassified

Subject         : console is messed up after resume from s2ram or switching to console from X
References      : http://lkml.org/lkml/2007/8/4/6
Last known good : ?
Submitter       : Jeff Chua <jeff.chua.linux@gmail.com>
Caused-By       : ?
Handled-By      : H. Peter Anvin <hpa@zytor.com>
                  Antonino A. Daplas <adaplas@gmail.com>
Status          : problem is being debugged

Subject         : konqueror suddenly vanishing, "konqueror: Fatal IO error: client killed"
References      : http://lkml.org/lkml/2007/7/22/86
Last known good : ?
Submitter       : Markus <lists4me@web.de>
Caused-By       : ?
Handled-By      : Ingo Molnar <mingo@elte.hu>
Status          : problem is being debugged



ACPI

Subject         : 2.6.23-rc1-git10 hangs on boot - needs "acpi=off"
References      : http://lkml.org/lkml/2007/8/2/24
Last known good : ?
Submitter       : Plamen Petrov <plamen.petrov@tk.ru.acad.bg>
Caused-By       : ?
Handled-By      : ?
Status          : unknown

Subject         : T60 ACPI issues/THINKPAD_ACPI_INPUT_ENABLED seems regressive
References      : http://lkml.org/lkml/2007/8/1/198
                  http://lkml.org/lkml/2007/8/1/176
Last known good : ?
Submitter       : Michael S. Tsirkin <mst@dev.mellanox.co.il>
                  Hugh Dickins <hugh@veritas.com>
Caused-By       : ?
Handled-By      : Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Status          : problem is being debugged



CPUFREQ

Subject         : ide problems: 2.6.22-git17 working, 2.6.23-rc1* is not
References      : http://lkml.org/lkml/2007/7/27/298
                  http://lkml.org/lkml/2007/7/29/371
Last known good : ?
Submitter       : dth <dth@dth.net>
Caused-By       : Len Brown <lenb@kernel.org>
                  commit f79e3185dd0f8650022518d7624c876d8929061b
Handled-By      : Len Brown <lenb@kernel.org>
Status          : problem is being debugged



Regards,
Michal

--
LOG
http://www.stardust.webpages.pl/log/
