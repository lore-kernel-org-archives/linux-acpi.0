From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH 09/11] arm64: pmu: Add routines for detecting differing
 PMU types in the system
Date: Fri, 1 Jul 2016 10:28:05 -0500
Message-ID: <57768C05.1050509@arm.com>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
 <1466529109-21715-10-git-send-email-jeremy.linton@arm.com>
 <87mvm1e9ye.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87mvm1e9ye.fsf@e105922-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: mark.rutland@arm.com, Lorenzo.Pieralisi@arm.com, linux-acpi@vger.kernel.org, alexander.shishkin@linux.intel.com, catalin.marinas@arm.com, Steve.Capper@arm.com, will.deacon@arm.com, acme@kernel.org, mlangsdorf@redhat.com, peterz@infradead.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On 07/01/2016 08:58 AM, Punit Agrawal wrote:
(trimming)
>> +			if (!pmu) {
>> +				pr_warn("Unable to allocate pmu_types\n");
>
> Bail out with error if the memory can't be allocated. Otherwise, we risk
> silently failing to register a PMU type.

Reading this again, I think I misunderstood what you were saying.. Aka, 
this should be pr_error() not that the error handing is failing to catch 
the failure.

Anyway, I will promote this.
