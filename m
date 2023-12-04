Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41506DF;
	Sun,  3 Dec 2023 20:26:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 265A1165C;
	Sun,  3 Dec 2023 20:27:39 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63D513F762;
	Sun,  3 Dec 2023 20:26:48 -0800 (PST)
Message-ID: <58882cab-89ce-4554-aee4-24e70d82fc09@arm.com>
Date: Mon, 4 Dec 2023 09:56:45 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/7] coresight: replicator: Move ACPI support from AMBA
 driver to platform driver
Content-Language: en-US
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20231201062053.1268492-1-anshuman.khandual@arm.com>
 <20231201062053.1268492-2-anshuman.khandual@arm.com>
 <20231201123515.gntwvhsxd5nzojn7@bogus>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20231201123515.gntwvhsxd5nzojn7@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/1/23 18:05, Sudeep Holla wrote:
> On Fri, Dec 01, 2023 at 11:50:47AM +0530, Anshuman Khandual wrote:
>> Add support for the dynamic replicator device in the platform driver, which
>> can then be used on ACPI based platforms. This change would now allow
>> runtime power management for repliacator devices on ACPI based systems.
>>
>> The driver would try to enable the APB clock if available. Also, rename the
>> code to reflect the fact that it now handles both static and dynamic
>> replicators.
>>
>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
> 
> Except the minor nit below which may apply also for few other patches
> in the series
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com> # For ACPI related changes
> Tested-by: Sudeep Holla <sudeep.holla@arm.com> # Boot and driver probe only
> 
> [...]
> 
>> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
>> index b6be73034996..64de0bee02ec 100644
>> --- a/drivers/hwtracing/coresight/coresight-replicator.c
>> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
>> @@ -38,6 +38,7 @@ DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
>>  struct replicator_drvdata {
>>  	void __iomem		*base;
>>  	struct clk		*atclk;
>> +	struct clk		*pclk;
> 
> [minor nit] Perhaps can be documented as well ?

Sure, will add the following comment above the structure.

@pclk:    optional clock for the core parts of the replicator.
