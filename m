From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: 2.6.29-rc6-git7: Reported regressions from 2.6.28
Date: Wed, 04 Mar 2009 09:15:12 +0800
Message-ID: <1236129312.32297.259.camel@rzhang-dt>
References: <KiHv0irKPzE.A.l3.hUarJB@chimera>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64670 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbZCDBOt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Mar 2009 20:14:49 -0500
In-Reply-To: <KiHv0irKPzE.A.l3.hUarJB@chimera>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Natalie Protasevich <protasnb@gmail.com>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, eric@anholt.net, airlied@linux.ie

On Wed, 2009-03-04 at 03:22 +0800, Rafael J. Wysocki wrote:

> Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=12705
> Subject         : X200: Brightness broken since 2.6.29-rc4-58-g4c098bc
> Submitter       : Nico Schottelius <nico-linux-20090213@schottelius.org>
> Date            : 2009-02-13 9:33 (19 days old)
> References      : http://marc.info/?l=linux-kernel&m=123451768406825&w=4
> Handled-By      : Len Brown <lenb@kernel.org>
> 

e806b4957412bf472d826bd8cc571da041248799 is first bad commit
commit e806b4957412bf472d826bd8cc571da041248799
Author: Eric Anholt <eric@anholt.net>
Date:   Thu Jan 22 09:56:58 2009 -0800

    drm/i915: Suppress GEM teardown on X Server exit in KMS mode.
    
    Fixes hangs when starting X for the second time.
    
    Signed-off-by: Eric Anholt <eric@anholt.net>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

http://marc.info/?l=linux-kernel&m=123479975503827&w=2

thanks,
rui


