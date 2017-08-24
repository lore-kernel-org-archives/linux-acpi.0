From: Boqun Feng <boqun.feng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/2] nfit: Fix the abuse of COMPLETION_INITIALIZER_ONSTACK()
Date: Thu, 24 Aug 2017 22:22:36 +0800
Message-ID: <20170824142239.15178-1-boqun.feng@gmail.com>
References: <20170823152542.5150-2-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20170823152542.5150-2-boqun.feng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Boqun Feng <boqun.feng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Byungchul Park <byungchul.park-Hm3cg6mZ9cc@public.gmane.org>, kernel-team-Hm3cg6mZ9cc@public.gmane.org, Nicholas Piggin <npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, walken-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

COMPLETION_INITIALIZER_ONSTACK() is supposed to used as an initializer,
in other words, it should only be used in assignment expressions or
compound literals. So the usage in drivers/acpi/nfit/core.c:

	COMPLETION_INITIALIZER_ONSTACK(flush.cmp);

, is inappropriate.

Besides, this usage could also break compilations for another fix to
reduce stack sizes caused by COMPLETION_INITIALIZER_ONSTACK(), because
that fix changes COMPLETION_INITIALIZER_ONSTACK() from rvalue to lvalue,
and usage as above will report error:

	drivers/acpi/nfit/core.c: In function 'acpi_nfit_flush_probe':
	include/linux/completion.h:77:3: error: value computed is not used [-Werror=unused-value]
	  (*({ init_completion(&work); &work; }))

This patch fixes this by replacing COMPLETION_INITIALIZER_ONSTACK() with
init_completion() in acpi_nfit_flush_probe(), which does the same
initialization without any other problem.

Signed-off-by: Boqun Feng <boqun.feng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 19182d091587..1893e416e7c0 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2884,7 +2884,7 @@ static int acpi_nfit_flush_probe(struct nvdimm_bus_descriptor *nd_desc)
 	 * need to be interruptible while waiting.
 	 */
 	INIT_WORK_ONSTACK(&flush.work, flush_probe);
-	COMPLETION_INITIALIZER_ONSTACK(flush.cmp);
+	init_completion(&flush.cmp);
 	queue_work(nfit_wq, &flush.work);
 	mutex_unlock(&acpi_desc->init_mutex);
 
-- 
2.14.1
