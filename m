From: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/6] btt: ensure that flags were also unchanged during a
 map_read
Date: Fri, 14 Jul 2017 16:11:45 -0600
Message-ID: <20170714221148.11232-4-vishal.l.verma@intel.com>
References: <20170714221148.11232-1-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20170714221148.11232-1-vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In btt_map_read, we read the map twice to make sure that the map entry
didn't change after we added it to the read tracking table. In
anticipation of expanding the use of the error bit, also make sure that
the error and zero flags are constant across the two map reads.

Signed-off-by: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/nvdimm/btt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 3aa6bc0..304dac4 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1031,6 +1031,7 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 		 */
 		while (1) {
 			u32 new_map;
+			int new_t, new_e;
 
 			if (t_flag) {
 				zero_fill_data(page, off, cur_len);
@@ -1049,15 +1050,18 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 			 */
 			barrier();
 
-			ret = btt_map_read(arena, premap, &new_map, &t_flag,
-						&e_flag, NVDIMM_IO_ATOMIC);
+			ret = btt_map_read(arena, premap, &new_map, &new_t,
+						&new_e, NVDIMM_IO_ATOMIC);
 			if (ret)
 				goto out_rtt;
 
-			if (postmap == new_map)
+			if ((postmap == new_map) && (t_flag == new_t) &&
+					(e_flag == new_e))
 				break;
 
 			postmap = new_map;
+			t_flag = new_t;
+			e_flag = new_e;
 		}
 
 		ret = btt_data_read(arena, page, off, postmap, cur_len);
-- 
2.9.3
