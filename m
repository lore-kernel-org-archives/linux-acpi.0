Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495543C1080;
	Tue, 21 Jul 2026 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624938; cv=fail; b=doCda3TuIIP4qwZjnQAg2hIBQyhnqavUzIVne42hl5+yH17Bcu58DLgViVheM4wG2LqjN/IBdejf9coXwkUkdjkOogn8bxF9rOxQpr31n0XBDkg/X6V3zVNzVE74RU2lSD/ufAx7WloGj+cqRcFc825iQO7O3pt/SoKbRHBy4vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624938; c=relaxed/simple;
	bh=tKFrM0Ch3v51nukSVlkol6viHItJHuvPKakGKE8U+BA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dmT0LesIJTr4wigxS7wQixyJfj4+lJEs2lMepsPsappLBFAGCLnJ6WHFCSD3iHlBSEeAzXKoAMzfS4T6dfZoc3kObc3lL58HcbtpcijbctMpY8MIZTTv341tfLIyTIhxsM7NdWbGxEU6AFV/F4v+l9QJubhY8QNsJsSpYF6U8p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cnxH03s8; arc=fail smtp.client-ip=40.107.209.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cnxH03s8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKePj0t4pphhlfuXEAWsU/qsK6kNla/b9lKElHOVD6WhHAwTkjg03TvB4n60IQLG1wu5vTdwjjmFVnPvq8U88511uMhkRnbt5P0/x7LNxK3isAmpBPa2G226aP/yTu8tCvHI6yHyjEEEOABGB7jEAxzjFeVlPaKRG6Fo1bZ9uLcdkaoVp/Rl8JA7fzR60NQcaYTvjI2O8yyMr5YzuAhv9u/5yeiaSU2dGtuyU2qXyuamR3kROyEOyr4OafdA2/FnyifVMlaT3IOtt4EV48ElIjO/Zu4VXAvGY+jbpBv5MhDXVzAihzPueoaeZgPe6iEt/uVlQVlt9B4vSAJMtttfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4TwjzTtXyWqrOWqS7dXe9WNgn2xW8IXMu7oWQUXAq4=;
 b=gSl5LBYQoNa3pVyf65BkZNsE0C36ydnBAKyCf/aeio9DIUTaqIojRw2XCoupBA2mNKzvkzvK/sQYDU0kIjwA/gRmFq5sPkDz3sZkT6uDfDXa0IXURqO+T7Wn6iuqJnQCqEHbBuXkOEbANKmx7HopVSLFRikFd9ja4HSY9c8RO37wqbSojpuE0e5s2RbCZveKINDC0TcnYQioDMjWrUv3zvqqe0fpmNHWrRu5YJ0uiJRgksm6bESyng4BTerT98k0oAZ+C8UPxiraRAks3L9DTNUymIsCkdlPov2fJSU72r8XY0GoaHxTHAgqsvXZFhAdYrk52+tN26mkn/eDADmGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4TwjzTtXyWqrOWqS7dXe9WNgn2xW8IXMu7oWQUXAq4=;
 b=cnxH03s8VZrHjM3fR8AS5V+QZQalvjsGfTT128ZdK+qnAv8IGxUGhBN73MpRCXGJZjOHGGOWz9bvcUkO3RI8CYkYbl9UJsoSmiVy0MmYyM1oUcMuNK+PpUv74YQ8RzJ30GulnmGML3p95+M9cJeZ82LCLt/8abzTzgLmhr5JZlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 09:08:54 +0000
Received: from CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::8782:edc2:9856:bf5c]) by CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::8782:edc2:9856:bf5c%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 09:08:54 +0000
Message-ID: <83b5d634-89e9-479c-8a92-20776deec52d@amd.com>
Date: Tue, 21 Jul 2026 14:38:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/topology: Name the AMD core-type values
To: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>,
 dave.hansen@linux.intel.com, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: mingo@redhat.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org,
 lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 peterz@infradead.org, tony.luck@intel.com, chang.seok.bae@intel.com,
 wei.w.wang@hotmail.com
References: <20260629094349.533301-1-Vishal.Badole@amd.com>
 <20260629094349.533301-2-Vishal.Badole@amd.com>
 <20260702002704.GGakWwWMHxbRnSsfiO@fat_crate.local> <8733y1nj13.ffs@fw13>
 <20260702230337.GAakbuSfEOuD2K-d0I@fat_crate.local>
 <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::14) To CH3PR12MB7523.namprd12.prod.outlook.com
 (2603:10b6:610:148::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7523:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 35dcbc07-74f6-4dfb-796b-08dee707b010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|3023799007|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rcNao3LlqIz0VJs2SCGt6OBJpDLeEVavJhk1A4/0FdgcS3RAfLrhzMiQ6xWFw0P/NZ4ccexgBB9fFoU/7yJip0El6CUzzWPAGPUAyhiGWp7GpxgHttPSeqIJLwn8UhtlVroXokNnaw7jNE6vklw2rhbyxE7Y4lq2FFnIJdlvYm4X/npkOnOKfq1WD1TzoodIMVyJVl8bptsuvMgNcXvS8bJdYUHzAhpi/k23FZEeKannhDdmXO0RLvlT2vo9dzTXdmhpn00oDQJCspSNHHbh0mHygg2Ql13mx/YuMBFnnEmQcNCSLn1Jp4UyF2e4pGxU8cWAG6yBS3aqsEMuGj1czhq0AM5MvRLOABXU/fYOxYNH8lLua1qR8TChii4RUSoWUuCAqnMaJ2QWgTDl+v1kwJS7nganQZlnwIcISiKH3Bt1ZJGBa1bOyhD2sYriQJrKOa78RJSS3mpLCbwAb8C41QG9OmhJZUtnSGh1SmBA1hFr5TAGjijDVaJdwcOWIZtPzRIHC76kiFAg9dhawoEBbA8dcGdn73ZoMY6XBiaRkXOsBX1qwLZ7Qus4Xyf0HcsgvlVw5/NJ/3R1V8ZGBxfapgPCe/YC5Yv3YV+aBV7eSELC7gYBezWivsRLDhHN+oEs1RBiyWm0APFarSYY5L/cHZKD6dAhpTCIGNkE0kyUWw0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7523.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(3023799007)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkNjK0ErSW8vbTVqZ0FDdWFlMW9IdS91Q0lIOGdZS3hETVBhVGxqV0QvdHVM?=
 =?utf-8?B?djVYMnh4L0FhSGtPNlVOcGduSWhHbXhGalcrWGZtOEw3WEYybklwYVN3N0w1?=
 =?utf-8?B?UThaeVJ1U0czSGNsSWxQT0dnVmtRZ0ZUVUNmeVNnUGtINyt0TSsyUnZDV1hB?=
 =?utf-8?B?Wi9ucmFrbjdMeEZmWUlIeDl4d2VCYmNJSVozeW8zaWh1SnlwT2Fnejhmdmt0?=
 =?utf-8?B?UjFvUWM5ZGg3T0JjNVcydFN3SE1yZjlJMVEwRzRhankySHY4MWFUU0ROSjRQ?=
 =?utf-8?B?ZnMvdEJ0MU5GUlR6SWpKU0YxQzJ0OXplbE43WjlzNmtHUCtFVk10R3NJZkhL?=
 =?utf-8?B?eDlqZ0JZWW15c0dlc3RPeWtEak9HUUxBcG9zaUFTRE13bFJlMlVhNGwzbGhM?=
 =?utf-8?B?cWZQeEk2cE5QWjgxdWowK0I3QmRUVmFUemFUSjB4QytBQ0EvdGlNcU5XczE5?=
 =?utf-8?B?UEg0a3VjOEY4VkQrbnZGTjlyaW1HUGRYR0tsbUdUYm8wNHpjRTNtKy9JSVVj?=
 =?utf-8?B?SHlybFVVaUlqT1NnYSsvSGNCamNzVWIvS3JldW9kQWkvQ1dEd0Zub1dwLzBm?=
 =?utf-8?B?N014THNvVHJLbTVyeWNjeG9OVWQ3U1dlUENmaDBCcmFremtJUVRxV0daZEhv?=
 =?utf-8?B?dmVFSTFlVHNJSG5rdi80L3hBOVpXYlpNd2wvN1JhbU02ajZMTENMTDJMMmpP?=
 =?utf-8?B?YTY1a1FhcWljZU5JQkFReVJTa21na2JTOW9Pc1A4VXByb0hQK0taMUpMOGhi?=
 =?utf-8?B?TzlUM2xXTVp0T0xYY3d6WGdCZk9SbzZRTTBCRjJWZUtvQzc5d1BHQUpjcVVh?=
 =?utf-8?B?cHlObitCV0p2dGhBWmJSelRrdTIrU0RHd2R5cDBKRlNiQ1RPWHo3Rzk4cVBm?=
 =?utf-8?B?ZmFmcU9DN29LdzltV21mNnVQaTBGMSszcUlycGJuWUU2NERlK1FpYkdPYmNu?=
 =?utf-8?B?VUNjaHNlRGk1bEZZR3ZZTGhBMk9tZHhtUUkyV1IzUElFckxXRDMwUm82R1lr?=
 =?utf-8?B?UEVIM1ZxMWNRa3ZpWVRqb1pJamRyTDJmRmc3L2N4V0x6QXRPaTNKVjR4RE81?=
 =?utf-8?B?ZXA4anhHRnpKKzVlWXlBOW02UTVoazhWV1NWYm5EbDBWNk04cjBMdUxndklv?=
 =?utf-8?B?cndoZVBOaEpZd0tMUlhGWGh0UkIyTUdRbnBwZVZJTXFFNk9RemJTeElhb2s0?=
 =?utf-8?B?ODZnTi93ajJJMXNCS1djd0g4NWlxdE1IMUVPc21qOFJUdW0wQTdEbTJLQlly?=
 =?utf-8?B?RERIRjNJQlZjc3V6SUxyWStHbzNLb0xPb0pCYUozSWNQdHI2RVE4TVdZbERx?=
 =?utf-8?B?Yk9KZ3pVQ09BVmxaaGNVaUNnTlJKZCs5OTU1UjdjUTVMdzVubHhIVEdhR3hn?=
 =?utf-8?B?djZVRm1DdHpJQ3R6Zk1JS3F0Y3hKZjl3WUxOczB4NUlUekNSd0NOcGIvYTls?=
 =?utf-8?B?cUthWG91aUFrWGdLM3Z5MWdxWEkvS2YwMXBZbmkxVjVpUGpvVE1JSHd1bDZ1?=
 =?utf-8?B?WW9RcVVKc2t5RHhQNlMxbmt4clY1NnErd3RnZzJpUnNyUE1vRjRLdXBGc0Uz?=
 =?utf-8?B?WkY1Q2w0eVkrNXdTMkhKM2JqTU5TSEhXalBGWUVhK3psaUxQbHpraFZKSUor?=
 =?utf-8?B?NXFvZHZFY3BNTlNyZlFKdFVWU09QcUJPSDEvT3FMbXhROU81WnZyZVhNZCtS?=
 =?utf-8?B?TUlTNktIZlhaeFJodE1oMC82a3J5THB1OFdOOG5oVjBSQUpRUG1lR2JUUytz?=
 =?utf-8?B?bytRcXFUU1dzMlBEcVFDaEN5TzVUVUtxRFpEUTFlL2Nzc3NUZU0xWjZqbVZN?=
 =?utf-8?B?M1JFOTZlcFAvUzBaK1lEOVB5ZW9mc21XbnQ5SllGMWpjREllaTJsaVBCVHFm?=
 =?utf-8?B?dVd2cHMyeXNRbWVGdGlPUkg3SlRtRGVnMWdFdFo5cGxGcElXdkxoV0ZsT1Y2?=
 =?utf-8?B?UHdIRUR1WFg3eGdyb1puUjcxTnZ4MGhqNmVSdG1ITjNMN0VkRy83TU15M2Nx?=
 =?utf-8?B?VHhzN2krM3JYMkFXQXYyY1JqRC9Jc0lvaEVjMzNxZWxKeE5FdTNDSjZWNUFo?=
 =?utf-8?B?UjJLTXZsUkUxenB4cHE5UjVQc0FZdVdRV290NEZhK2thSE9nazZjSmlaNkdO?=
 =?utf-8?B?dW80eGhOeER4amhxMEt6T3JoTy80aURRcUNJU0hoM014MmhIcm9UaHRmZnBG?=
 =?utf-8?B?YVRJdEhUd1ZRKzNRYU5iZ0dFRTBrRy9QZ2NCTS9vZjU5UkFURUFmcjFLWVdP?=
 =?utf-8?B?ZGRXVzV0TnBhdTNRZzliUGtKYlczZCtWNytYMWNrcFk1TVBNd1BHNmMvbCtD?=
 =?utf-8?B?K2QrdmdUY1hlbTM0UTFqOElzYWxtN3dBUVNSV0hycVIzcmI4UFcvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dcbc07-74f6-4dfb-796b-08dee707b010
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:08:54.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSlQceDNOVfU9VKreMSWi9G+UPiUJnelYJu8OQo5pDYFBWgm1WnC7gWBwbf09ONahS+2/4m3FLlON803xDWiHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970



On 7/4/2026 1:02 AM, Borislav Petkov wrote:
> + Dave and Pawan.
> 
> On Thu, Jul 02, 2026 at 04:03:37PM -0700, Borislav Petkov wrote:
>> On Fri, Jul 03, 2026 at 12:06:32AM +0200, Thomas Gleixner wrote:
>>> Just do the mapping to vendor-agnostic types _once_ when you enumerate the CPU
>>> and store that information in the per CPU data.
>>>
>>> Then you can do proper vendor agnostic matching against that and define
>>> the TYPE_ANY value as you want without ever colliding with vendor
>>> muck.
>>>
>>> As a bonus get_topology_cpu_type() goes away too as the translation has
>>> been done already.
>>
>> Yeah, we should've done it from the very beginning this way. Lemme hack it up
>> and see how it looks like.
>>
>> Thanks for the cool idea.
> 
> Something like the totally untested below - but it builds at least.
> 
> We've allocated a u8 for the struct x86_cpu_id member type and we compare that
> to enum x86_topology_cpu_type cpu_type. I guess that's ok for now...
> 
> There's potential for more cleanup by removing the ->intel_type and ->amd_type
> and converting them all to our internal represenation of CPU_TYPE but that's
> for later and other patches anyway.
> 
> Thoughts?
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 8d8f890c4bc0..746822bd71fb 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -68,9 +68,13 @@ extern u16 __read_mostly tlb_lld_2m;
>   extern u16 __read_mostly tlb_lld_4m;
>   extern u16 __read_mostly tlb_lld_1g;
>   
> -/*
> - * CPU type and hardware bug flags. Kept separately for each CPU.
> - */
> +enum x86_topology_cpu_type {
> +	/* X86_CPU_TYPE_ANY */
> +	TOPO_CPU_TYPE_ANY = 0,
> +	TOPO_CPU_TYPE_PERFORMANCE,
> +	TOPO_CPU_TYPE_EFFICIENCY,
> +	TOPO_CPU_TYPE_UNKNOWN,
> +};
>   
>   struct cpuinfo_topology {
>   	// Real APIC ID read from the local APIC
> @@ -104,7 +108,7 @@ struct cpuinfo_topology {
>   
>   	// Hardware defined CPU-type
>   	union {
> -		u32		cpu_type;
> +		u32		hw_cpu_type;
>   		struct {
>   			// CPUID.1A.EAX[23-0]
>   			u32	intel_native_model_id	:24;
> @@ -119,8 +123,14 @@ struct cpuinfo_topology {
>   				amd_type		:4;
>   		};
>   	};
> +
> +	// Linux vendor-agnostic CPU type
> +	enum x86_topology_cpu_type cpu_type;
>   };
>   
> +/*
> + * CPU type and hardware bug flags. Kept separately for each CPU.
> + */
>   struct cpuinfo_x86 {
>   	union {
>   		/*
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 8fb61d2465eb..ef76ba674f1b 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -114,12 +114,6 @@ enum x86_topology_domains {
>   	TOPO_MAX_DOMAIN,
>   };
>   
> -enum x86_topology_cpu_type {
> -	TOPO_CPU_TYPE_PERFORMANCE,
> -	TOPO_CPU_TYPE_EFFICIENCY,
> -	TOPO_CPU_TYPE_UNKNOWN,
> -};
> -
>   struct x86_topology_system {
>   	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
>   	unsigned int	dom_size[TOPO_MAX_DOMAIN];
> @@ -160,7 +154,6 @@ extern unsigned int __num_nodes_per_package;
>   struct cpuinfo_x86;
>   
>   const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c);
> -enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
>   
>   static inline unsigned int topology_max_packages(void)
>   {
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index be4c5e9e5ff6..b8f5dd0a8117 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -241,7 +241,6 @@ EXPORT_SYMBOL_GPL(amd_detect_prefcore);
>    */
>   int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>   {
> -	enum x86_topology_cpu_type core_type = get_topology_cpu_type(&cpu_data(cpu));
>   	bool prefcore;
>   	int ret;
>   	u32 tmp;
> @@ -273,8 +272,9 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>   
>   	/* detect if running on heterogeneous design */
>   	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
> -		switch (core_type) {
> +		switch (cpu_data(cpu).topo.cpu_type) {
>   		case TOPO_CPU_TYPE_UNKNOWN:
> +		case TOPO_CPU_TYPE_ANY:
>   			pr_warn("Undefined core type found for cpu %d\n", cpu);
>   			break;
>   		case TOPO_CPU_TYPE_PERFORMANCE:
> diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
> index 4604802692da..7ab077f0cc66 100644
> --- a/arch/x86/kernel/cpu/match.c
> +++ b/arch/x86/kernel/cpu/match.c
> @@ -5,34 +5,6 @@
>   #include <linux/export.h>
>   #include <linux/slab.h>
>   
> -/**
> - * x86_match_vendor_cpu_type - helper function to match the hardware defined
> - *                             cpu-type for a single entry in the x86_cpu_id
> - *                             table. Note, this function does not match the
> - *                             generic cpu-types TOPO_CPU_TYPE_EFFICIENCY and
> - *                             TOPO_CPU_TYPE_PERFORMANCE.
> - * @c: Pointer to the cpuinfo_x86 structure of the CPU to match.
> - * @m: Pointer to the x86_cpu_id entry to match against.
> - *
> - * Return: true if the cpu-type matches, false otherwise.
> - */
> -static bool x86_match_vendor_cpu_type(struct cpuinfo_x86 *c, const struct x86_cpu_id *m)
> -{
> -	if (m->type == X86_CPU_TYPE_ANY)
> -		return true;
> -
> -	/* Hybrid CPUs are special, they are assumed to match all cpu-types */
> -	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> -		return true;
> -
> -	if (c->x86_vendor == X86_VENDOR_INTEL)
> -		return m->type == c->topo.intel_type;
> -	if (c->x86_vendor == X86_VENDOR_AMD)
> -		return m->type == c->topo.amd_type;
> -
> -	return false;
> -}
> -
>   /**
>    * x86_match_cpu - match current CPU against an array of x86_cpu_ids
>    * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
> @@ -81,7 +53,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
>   			continue;
>   		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
>   			continue;
> -		if (!x86_match_vendor_cpu_type(c, m))
> +		if (m->type != X86_CPU_TYPE_ANY && c->topo.cpu_type != m->type)
>   			continue;
>   		return m;
>   	}
> diff --git a/arch/x86/kernel/cpu/topology.h b/arch/x86/kernel/cpu/topology.h
> index 37326297f80c..74e02bacd854 100644
> --- a/arch/x86/kernel/cpu/topology.h
> +++ b/arch/x86/kernel/cpu/topology.h
> @@ -22,6 +22,7 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
>   bool cpu_parse_topology_ext(struct topo_scan *tscan);
>   void cpu_parse_topology_amd(struct topo_scan *tscan);
>   void cpu_topology_fixup_amd(struct topo_scan *tscan);
> +enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
>   
>   static inline u32 topo_shift_apicid(u32 apicid, enum x86_topology_domains dom)
>   {
> diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
> index da080d732e10..c5a6944df86a 100644
> --- a/arch/x86/kernel/cpu/topology_amd.c
> +++ b/arch/x86/kernel/cpu/topology_amd.c
> @@ -177,8 +177,10 @@ static void topoext_fixup(struct topo_scan *tscan)
>   
>   static void parse_topology_amd(struct topo_scan *tscan)
>   {
> -	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
> -		tscan->c->topo.cpu_type = cpuid_ebx(0x80000026);
> +	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
> +		tscan->c->topo.hw_cpu_type = cpuid_ebx(0x80000026);
> +		tscan->c->topo.cpu_type    = get_topology_cpu_type(tscan->c);
> +	}
>   
>   	/*
>   	 * Try to get SMT, CORE, TILE, and DIE shifts from extended
> diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
> index cf7513416b70..b9d025f3373a 100644
> --- a/arch/x86/kernel/cpu/topology_common.c
> +++ b/arch/x86/kernel/cpu/topology_common.c
> @@ -168,8 +168,12 @@ static void parse_topology(struct topo_scan *tscan, bool early)
>   	case X86_VENDOR_INTEL:
>   		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
>   			parse_legacy(tscan);
> -		if (c->cpuid_level >= 0x1a)
> -			c->topo.cpu_type = cpuid_eax(0x1a);
> +
> +		if (c->cpuid_level >= 0x1a) {
> +			c->topo.hw_cpu_type = cpuid_eax(0x1a);
> +			c->topo.cpu_type    = get_topology_cpu_type(c);
> +		}
> +
>   		break;
>   	}
>   }
> 
Ack! I will send a V2 patch set that includes suggested changes and the 
LP core patches.

