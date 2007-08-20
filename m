From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/4] 2.6.23-rc3: known regressions v2
Date: Mon, 20 Aug 2007 18:01:36 +0200
Message-ID: <46C9BAE0.50706__26561.7822217338$1187625737$gmane$org@googlemail.com>
References: <46C9B6C7.5070704@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:36943 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760666AbXHTQCA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Aug 2007 12:02:00 -0400
Received: by wr-out-0506.google.com with SMTP id 36so943658wra
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2007 09:02:00 -0700 (PDT)
In-Reply-To: <46C9B6C7.5070704@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Plamen Petrov <plamen.petrov@tk.ru.acad.bg>, Michael Sedkowski <sedmich@gmail.com>, Alex Hunsaker <badalex@gmail.com>, Denis Sadykov <denis.m.sadykov@intel.com>, dth <dth@dth.net>, linux-fsdevel@vger.kernel.org, Trond Myklebust <Trond.Myklebust@netapp.com>, Andrew Clayton <andrew@digital-domain.net>

Hi all,

Here is a list of some known regressions in 2.6.23-rc3.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

List of Aces

Name                    Regressions fixed since 21-Jun-2007
Adrian Bunk                            9
Andi Kleen                             5
Linus Torvalds                         5
Andrew Morton                          4
Al Viro                                3
Cornelia Huck                          3
Jens Axboe                             3
Tejun Heo                              3



ACPI

Subject         : 2.6.23-rc3 fails to boot (acpi)
References      : http://lkml.org/lkml/2007/8/19/31
Last known good : 2.6.23-rc2
Submitter       : Alex Hunsaker <badalex@gmail.com>
Caused-By       : ?
Handled-By      : ?
Status          : unknown

Subject         : MCFG bug on hp nx6310
References      : http://lkml.org/lkml/2007/8/8/252
Last known good : ?
Submitter       : Michael Sedkowski <sedmich@gmail.com>
Caused-By       : ?
Handled-By      : ?
Status          : unknown

Subject         : 2.6.23-rc1-git10 hangs on boot - needs "acpi=off"
References      : http://lkml.org/lkml/2007/8/2/24
Last known good : ?
Submitter       : Plamen Petrov <plamen.petrov@tk.ru.acad.bg>
Caused-By       : ?
Handled-By      : Len Brown <len.brown@intel.com>
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



FS

Subject         : [NFSD OOPS] 2.6.23-rc1-git10
References      : http://lkml.org/lkml/2007/8/2/462
Last known good : ?
Submitter       : Andrew Clayton <andrew@digital-domain.net>
Caused-By       : ?
Handled-By      : ?
Status          : unknown



Regards,
Michal

--
LOG
http://www.stardust.webpages.pl/log/
