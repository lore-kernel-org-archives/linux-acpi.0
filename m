From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v7 2/4] perf/smmuv3: Add arm64 smmuv3 pmu driver
Date: Tue, 26 Mar 2019 16:57:42 +0000
Message-ID: <fa89c332-d420-8fef-5034-518e60571bd9@arm.com>
References: <20190326151753.19384-1-shameerali.kolothum.thodi@huawei.com>
 <20190326151753.19384-3-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326151753.19384-3-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, lorenzo.pieralisi@arm.com
Cc: andrew.murray@arm.com, jean-philippe.brucker@arm.com, will.deacon@arm.com, mark.rutland@arm.com, guohanjun@huawei.com, john.garry@huawei.com, pabba@codeaurora.org, vkilari@codeaurora.org, rruigrok@codeaurora.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, neil.m.leeder@gmail.com
List-Id: linux-acpi@vger.kernel.org

Hi Shameer,

On 26/03/2019 15:17, Shameer Kolothum wrote:
[...]
> +static int smmu_pmu_apply_event_filter(struct smmu_pmu *smmu_pmu,
> +				       struct perf_event *event, int idx)
> +{
> +	u32 span, sid;
> +	unsigned int num_ctrs = smmu_pmu->num_counters;
> +	bool filter_en = !!get_filter_enable(event);
> +
> +	span = filter_en ? get_filter_span(event) :
> +			   SMMU_PMCG_DEFAULT_FILTER_SPAN;
> +	sid = filter_en ? get_filter_stream_id(event) :
> +			   SMMU_PMCG_DEFAULT_FILTER_SID;
> +
> +	/* Support individual filter settings */
> +	if (!smmu_pmu->global_filter) {
> +		smmu_pmu_set_event_filter(event, idx, span, sid);
> +		return 0;
> +	}
> +
> +	/* Requested settings same as current global settings*/
> +	if (span == smmu_pmu->global_filter_span &&
> +	    sid == smmu_pmu->global_filter_sid)
> +		return 0;
> +
> +	if (!bitmap_empty(smmu_pmu->used_counters, num_ctrs))
> +		return -EAGAIN;
> +
> +	if (idx == 0) {
> +		smmu_pmu_set_event_filter(event, idx, span, sid);
> +		smmu_pmu->global_filter_span = span;
> +		smmu_pmu->global_filter_sid = sid;
> +		return 0;
> +	}

When I suggested dropping the check of idx, I did mean removing it 
entirely, not just moving it further down ;)

Nothing to worry about though, I'll just leave this here for Will to 
consider applying on top or squashing.

Thanks,
Robin.

----->8-----
From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] perf/smmuv3: Relax global filter constraint a little

Although the current behaviour of smmu_pmu_get_event_idx() effectively
ensures that the first-allocated counter will be counter 0, there's no
need to strictly enforce that in smmu_pmu_apply_event_filter(). All that
matters is that we only ever touch the global filter settings in
SMMU_PMCG_SMR0 and SMMU_PMCG_EVTYPER0 while no counters are active.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  drivers/perf/arm_smmuv3_pmu.c | 11 ++++-------
  1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 6b3c0ed7ad71..23045ead6de1 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -286,14 +286,11 @@ static int smmu_pmu_apply_event_filter(struct 
smmu_pmu *smmu_pmu,
  	if (!bitmap_empty(smmu_pmu->used_counters, num_ctrs))
  		return -EAGAIN;

-	if (idx == 0) {
-		smmu_pmu_set_event_filter(event, idx, span, sid);
-		smmu_pmu->global_filter_span = span;
-		smmu_pmu->global_filter_sid = sid;
-		return 0;
-	}
+	smmu_pmu_set_event_filter(event, 0, span, sid);
+	smmu_pmu->global_filter_span = span;
+	smmu_pmu->global_filter_sid = sid;

-	return -EAGAIN;
+	return 0;
  }

  static int smmu_pmu_get_event_idx(struct smmu_pmu *smmu_pmu,
-- 
2.20.1.dirty
