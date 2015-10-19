From: Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] GHES: Fix cached error-status
Date: Mon, 19 Oct 2015 10:55:54 -0700
Message-ID: <20151019175554.GB3367@linux-uzut.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42935 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbbJSR4P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Oct 2015 13:56:15 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

In ghes_estatus_cached() we currently have a situation where
we can break out of the loop before examining all the possible
estatus_caches. Move the 'break' statement inside of the 'if',
such that an otherwise possibly missed cache is acknowledged
and the function returns the proper value.

Introduced by 152cef40a808d (ACPI, APEI, GHES, Error records
content based throttle).

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---

Hi,

I found this accidentally and have no idea if it is correct, but
seems to be a case of a misplaced break. If this is not the case,
then it is a very weird way of using a for-loop, and should probably
be rewritten -- and there are other funky places in this file...

100% untested.

Thanks,
Davidlohr

  drivers/acpi/apei/ghes.c | 5 +++--
  1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3dd9c46..3fda4a2 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -541,9 +541,10 @@ static int ghes_estatus_cached(struct acpi_hest_generic_status *estatus)
  			continue;
  		atomic_inc(&cache->count);
  		now = sched_clock();
-		if (now - cache->time_in < GHES_ESTATUS_IN_CACHE_MAX_NSEC)
+		if (now - cache->time_in < GHES_ESTATUS_IN_CACHE_MAX_NSEC) {
  			cached = 1;
-		break;
+			break;
+		}
  	}
  	rcu_read_unlock();
  	return cached;
-- 
2.1.4

