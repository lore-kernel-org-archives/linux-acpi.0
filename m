Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022092.outbound.protection.outlook.com [40.107.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9516484250;
	Thu, 23 Jul 2026 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822290; cv=fail; b=XPgiQ3h3kUvofYEWBzmojEYYWhG33JSOfeS5iJJTdhsc/wy8qnYcYx26C/b5KDzW5OBk9TWblWvVrB0HOKzWdHQwwGCAo5XYxtIlxjXKiC++/M9scv9J+veLhu9uC+bsxlyNWHMJVTaAGGMlr0PnFGZvbJ8QqaNQ8uRiT0biX8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822290; c=relaxed/simple;
	bh=3PislCxkURYPFStoJUXLUqrk7CGRqM/uTxSr68dit14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NI1eiy2LKtMMrgTjZ1IHfCYopouFkV6fBtTefqQDDWs4/nc8vHMFOrmTWg8x1YeXOQ4+LVwHjae6HGQmkBmPjYQ0DCN3dAHx6ogOv6ZvKTdvv3BDuTWwJf569Q6Y1zOxxQ0CHLBhWpo1aWGk/v0XIpcxfcuqYySAABHWY3lSpjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=EeXaDoUA reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="EeXaDoUA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3Ykb/ABMj59HsmWJdIrAuKriJ5YhtdNCZ56unnpnCFiut2/AkCkZKlajHkJPDDHoW80CtvZsRswqgrOmbBMIEsK9xfMLeUeHFkJ1+l9K+9RLx6aiWQ0bVeNEzn1Clu+jvN7khwTVluONuGvvo3N7AAPNSStETyQIUdGTngxOds1t4Uz0BrdWCFF//N8IujgsCr7w8o+1EL0OBvs8lEAJlS7V7pw45QI8qnmJOPrLH8t2/JQD35lKVJSv0Hd9t+rlxSbMium37hhDaFIKej5o/sozwZstJCZlOIUK6mHlR7BWUp6FSe6m4didLq4A9hgovHO0zrIiJubFE6gJJNa1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MdjDc16zmsyie+9GSjITdRukP8Q9TU9HRAK4RHO9zg=;
 b=kePpx+DwVveKwWKi2Mf0mY5gmSsLOzBZkiHtgZv4D8YSCGEVYMvZAvIhbtnzACIDHqICZ9E34vFyTPf2L+tkSRLVAACWSQFDKBhCm2WIwmKDOX4GKbegy9j7DzIGp+7AB5cbVo/6v3fhPtchEbhd8D8EhW7BeZJws9q0ox+fRVLzMxYVbuW9rNifOHdmekJxtU03ukhcRULRyMuN3UHaMNBkk2rZGnxKAhKDRtlTUEDpFWxqYz63Z8msnb8DCXeIJ8VFxmyfZuB52AkWAPy0gtr3+Ryq5SeG/r8mD//ZDakUFQiJGvyGwqstnpwTQoYg5jA8mDrZW3KsnLMUV2llDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MdjDc16zmsyie+9GSjITdRukP8Q9TU9HRAK4RHO9zg=;
 b=EeXaDoUAeZYbcQkC0U5GgHejitHfDzinQ7XSkm410k5coquM0i8Z1ZNmTLgQwQw0ODuub+UTBKhpRmAFnvgdBY6+muhlRxh8ZuDb6g0msirQOl8ORXFjoSjHgTyEM+LxlSe92n2ZsRAR0HW1IbUlTXuZYheBj7A8PR6ONY3dYcU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BN5PR01MB9125.prod.exchangelabs.com (2603:10b6:408:2a8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Thu, 23 Jul 2026 15:58:02 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 15:58:02 +0000
Message-ID: <18d7ecb3-c0a1-4d10-9b26-1f287e2de4bb@amperemail.onmicrosoft.com>
Date: Thu, 23 Jul 2026 11:57:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mailbox: pcc: Fix command timeout due to missed
 interrupt
To: Sudeep Holla <sudeep.holla@kernel.org>,
 Adam Young <admiyo@os.amperecomputing.com>
Cc: jassisinghbrar@gmail.com, lihuisong@huawei.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260717075649.467172-4-sudeep.holla@kernel.org>
 <20260723031051.156890-1-admiyo@os.amperecomputing.com>
 <20260723-mastodon-of-simple-criticism-2bdcc9@sudeepholla>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260723-mastodon-of-simple-criticism-2bdcc9@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0141.namprd15.prod.outlook.com
 (2603:10b6:930:67::6) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BN5PR01MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a7439c-04f0-436d-8f45-08dee8d32ca6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mClebVYb39KQm2p52TZNoDtoLBTR3Ta6uQ/tulNrzOB+2i/mUFnEKKQKTj5QvuV3AMSIC+sVX+2is17l91jFg4P9vFZ/u0/AparpwRRMTkXPf4cXMeAqGVoohFWDGClA5hjK8Ya5BEj/YZ/jzK1erj1AFHkXWYwMSf3U1qMoB7BUNZHv0FD9W492v9LoTQKT8vORKLJA9mn3aYoy9Luez64BDT4+Q9PBfYjz7O56jnN6iSv23swPZ+2ahagHOw/CuLjkrzN/1laEmN6TFgm4nXiBYYPRR0iZsHSQgl9HN5Bp3ilDfLdeieEFIiOQIi7SIEm09LGLr/EHUm3lyKs3ZIZlPvTRt+AUQpsIJg2mLpwl4KGo+HhniU93+pAGJwOBTLDwdVAxeQ6aQkEOWxkOM9nkRKuzKLDV8diSLl81Ddv9oUbBUSZiNbqYGAb80wo9pvoB/qAVuC/MlhLBcDFbFj/mu0+zqIfZDl9WybAnmPqLzko3fyLLme6BVbB9ZTbFTEk+Xlzp2HNZQTH2JkENs29PpLkpLOd4MsTbWJ3l0bYhqwtNfSCg6gU59QEoLTDJD1uBf9R1snNK0RlfQBIVhPUQlyAxypX9P9e2/3yt11C3HYQnqVFdaQ1WbR8ivQYruHADo0hOwZU9I6knR3L3hb6L+cFBsKCC2IB1C2914jc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXFKMTJVVElKRmhMV1RmdWUwdXB0WDAvNkxPMFNLbWlBbUNJSnhDYktoSHR2?=
 =?utf-8?B?eXh3QjFON2FtSEM3Qmk4b0VhZ21jbE5oVFJVcHRQd3RYSi9jd1RGMEJXR1M3?=
 =?utf-8?B?UzNSTi91ZXRQY0R1QzVqTU1pc2V1Qy9lb0g1eDhqVCs5Y25YcW1sa0RZUGxH?=
 =?utf-8?B?YWFHWE9jL1dpc1I0ZkJaWk01Q2t1TkJkbSt3WTZ6RnR4M2Z5ZHlFQXVyN21z?=
 =?utf-8?B?NjlhYkpEQms3OTgyaEJFdldCU0RIbytLQnE3N20vUlNwRGdwZnpPSnMxcGZt?=
 =?utf-8?B?a2NHc2syUnBBd044WWwxWG1kSnVaaU9tZEROSUNKZ3pBRE9TRW12d3IvbzJW?=
 =?utf-8?B?TVhib1hhbXJOTzY4VEVwSkZhZFh6aStFNzZVY2c2ditKNjNOeWErZGFLbkFI?=
 =?utf-8?B?cmI3SUR6M0tUUGpOSUZCSzI3eVVGWVNUR3FPVmlSaDlNRTVJOUdTU1dXaUsy?=
 =?utf-8?B?V0tGZHJPVHl3QmMwbkVhOTQ4cFFkNjNYY0VZeGFtQ3dLU2xSWHdSMVF6WW9Z?=
 =?utf-8?B?U01DallTZzdsMnZTcElaOEJVVm0wd0NZT3RXZXpDbjNHL2JGSEdDTFBtNlM2?=
 =?utf-8?B?d0lDZlVqbjU0d05uZU1zQmFUQktEdTFBdEo3dlJaNVlIY1JRWW9ZZ3hrL0xZ?=
 =?utf-8?B?VkhJWnBTcGJJbmxqMWlHenNDL1BJTm90bldIajNHekxyNWZIZ2tmSzl4UjFo?=
 =?utf-8?B?WHZHUUx3RkppTi9NZWFQNjJIcTlFZndRdkZRQ3ppeVVoMjBpY09yMVdua0Zs?=
 =?utf-8?B?WnVDc0tmNUZyS1dvT28yaGpWTjFXVWdMM3pJbWhZNWw1WmVmMGpaYVVtY0xS?=
 =?utf-8?B?OTRhUkhSTHhodGNLM1VBc2R5UTFFRk9OcDVsU3k4K2hJelBnaGUyMXAzTkx5?=
 =?utf-8?B?NWRLM2lNSGVLWVVTZXQyT0NoMVQ0eWk1dE9kcG54TmRDdFZPQkgyVGxrYzRl?=
 =?utf-8?B?R01hVXhzYUx6MHB3a29FZUhyWEJnWHdoZW5TMXkvelZKODlyUnhEc1Jhb09X?=
 =?utf-8?B?V0E2UDBwZzV4TkhoNG1qNEVuN2dlOHMwSDIraStSelE2WFpJS01DazBieHoy?=
 =?utf-8?B?L3FKc3pDUDNKUnFqS2VKeUV0RWtFeVl6cUovM01xUmg3UHNDZUM1ZTJVQUs4?=
 =?utf-8?B?RDhqQThGK21qR0tMaXpYbnhwL0kwOVZ4WWNpdThtb3FTUkRDd3JWQXcwMGZJ?=
 =?utf-8?B?RU9tM0xKcDk5eCtURUFRUDRGSTFmNjhrOWpEa2ltYnV1U3FmUkI0T0VxMVM1?=
 =?utf-8?B?VGJEd2tQeFQyUDkvT1dBMFQwWitJRkI5bkJ0QmhTZFFnamwraXh4YTcxRFZR?=
 =?utf-8?B?dWo1YWl1U2NrSVRWTW04akRYb1dFMkJmbTgxajl6dUNmU01XczhUUGhEamN1?=
 =?utf-8?B?K3o0Uy9uSVhxaDNLbk5PaDQrWHhNZVZpL2JIWldLOU5nVVgrK0tKUVRZVUZ4?=
 =?utf-8?B?Ulhrd1Y5SkxOTUViSTBQOUhqVGtSaWdobTI2R0Q5KzdFcWtvYzhNRGx4RGho?=
 =?utf-8?B?MDdyNFlrRWlHK3hqNTV4aHo5RFFnL3daSng1eEdVSlNVVkVISzcvbnBxd1NS?=
 =?utf-8?B?VGxDOVgvaTBpeEdKa1RrT2hoMzFZZzZpZzlLN3cyQU91TjZHR3llcHNKbVIw?=
 =?utf-8?B?QUsvc1RBa3QrM1ZJTmNRenBoTlBwbjZOYTJxZWN3NkNrcXV3b0ZqRGhzREU1?=
 =?utf-8?B?ZjgvOEJGaVJUZEkrZVB2a2dySkcralJNMW1UOHVyWmorSG0xQVVCT2VaWHdp?=
 =?utf-8?B?K3NTOXI5MnYwTmZOcGZCM1lnLzVGaUJBY3R1SUs4WndRRktPQXUvcURPUzhO?=
 =?utf-8?B?VFd6VHpBaWN3NWRsckJFdUxkTVNxa3NuenNabDVSOHhTWERTcFEvZ1BueEdV?=
 =?utf-8?B?UFBmWFY2cE81Z1lndTlKNjZ2M2hwY1BXTndSQlFrNVppYzNFM0NnQzlmZWM1?=
 =?utf-8?B?K0ZjSjk3d1h4UFBDdk5FOEM5QUZVcDEvWHBvVXRjb3Zmdm9yQ3VyZXZaVi90?=
 =?utf-8?B?U0thRlNwSlkxZjV5Qk5ybnJNNDQ0THppMDkyUnE5SVNhdENKUTNrZ0ZjVGVW?=
 =?utf-8?B?SWFidS9pMS8wazFMSVU0Nmc0cFlicEVyb1J3OWk2dGZHQUo4VU04N0swZVF5?=
 =?utf-8?B?SHVjbzJwYWlPTUMyOFF4akhKdGFJV3E5dXJhY0FPNjJPenlmek1laE5PYllq?=
 =?utf-8?B?cUR4dFliVkdFdU16b29uWEMycHJSRmI0UkgxbGgzSVdxU1RHZ3VDbUhCREdM?=
 =?utf-8?B?UHJrYmwrdXFmMUpOTiswaXFiUDR3RnErdStwYTBLM0w0aDBMOUs1UEVkdGlW?=
 =?utf-8?B?cmNySXFKRXFYOGdyTzZ2RGFuU3lyd3IvRDJEc3RYUzdLZ0lqZXdEZlI4NEVI?=
 =?utf-8?Q?t1mXSjfWxEJrhyq+3FqoHefzAoNhF06aiL6WNqmaDZsgE?=
X-MS-Exchange-AntiSpam-MessageData-1:
	cEcKHfZm3ZuWCZqbdRtLF0XUQLFtH7DUJbAsGSrLEygi5Mi7L/cQ2eee
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a7439c-04f0-436d-8f45-08dee8d32ca6
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:58:02.0350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x58GmSpwJV7oWOXslGNnhqxVn9otLjxuonGpyB1ar5LN3c3Q306lxoe3gx3xcD7+F+ajuAhPX7S2S33nTmNWOyb5W1CqXGg4n74xZaitBkky7yaaPMpxXyuRa3U7+rX2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR01MB9125


On 7/23/26 05:16, Sudeep Holla wrote:
> On Wed, Jul 22, 2026 at 11:10:51PM -0400, Adam Young wrote:
>>   
>> +	/*
>> +	 * Set chan_in_use before ringing the doorbell so a fast completion
>> +	 * interrupt is not mistaken for a shared interrupt from another
>> +	 * subspace. Use WRITE_ONCE() for the lockless flag update. The
>> +	 * ordered MMIO accessor used to ring the doorbell keeps this store
>> +	 * visible before the platform is notified.
>> +	 */
>> +	if (pchan->plat_irq > 0)
>> +		WRITE_ONCE(pchan->chan_in_use, true);
>>   	ret = pcc_chan_reg_read_modify_write(&pchan->db);
>>   	if (!ret && pchan->plat_irq > 0)
>> -		pchan->chan_in_use = true;
>> +		WRITE_ONCE(pchan->chan_in_use, false);
>>   
>>   	return ret;
>>   }
>> -- 
>> 2.43.0
>> iAt the end of the above code,
>>   WRITE_ONCE(pchan->chan_in_use, false);
>>   should be
>>   WRITE_ONCE(pchan->chan_in_use, true);
>>
>> In order to keep the original semantics.  The flag is cleared when the
>> messages is ACKed, not here.  This version causes a hang.
>>
> Did you run and seeing hang or just code inspection. If latter, have you
> considered that modified code sets it true before doorbell is rung and
> set to false only if there is a failure to ring the doorbell ?
>
Yes, I saw the hang, and debugged to see this line semantically 
different.  I changed it to true and things resumed working.  !ret is 0  
so that happens in the success case.




