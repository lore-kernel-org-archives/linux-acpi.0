From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 04/13] arm64/acpi: Create arch specific cpu to acpi id
 helper
Date: Thu, 26 Apr 2018 11:27:01 +0100
Message-ID: <16324b54-42d4-d9bc-6d57-de52431dc209@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-5-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425233121.13270-5-jeremy.linton@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com, Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com, Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com, ard.biesheuvel@linaro.org
List-Id: linux-acpi@vger.kernel.org



On 26/04/18 00:31, Jeremy Linton wrote:
> Its helpful to be able to lookup the acpi_processor_id associated
> with a logical cpu. Provide an arm64 helper to do this.
> 

As I pointed out in the earlier version, this patch is not required.
The acpi_id stored in the acpi_processor can be used for this.
Won't the below change make it work ? I can't think of any reason why it
shouldn't.

Regards,
Sudeep

-->8

diff --git i/drivers/acpi/pptt.c w/drivers/acpi/pptt.c
index 0fc4b2654665..f421f58b4ae6 100644
--- i/drivers/acpi/pptt.c
+++ w/drivers/acpi/pptt.c
@@ -432,7 +432,7 @@ static void cache_setup_acpi_cpu(struct
acpi_table_header *table,
 {
        struct acpi_pptt_cache *found_cache;
        struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-       u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+       u32 acpi_cpu_id = per_cpu(processors, cpu)->acpi_id;
        struct cacheinfo *this_leaf;
        unsigned int index = 0;
        struct acpi_pptt_processor *cpu_node = NULL;
