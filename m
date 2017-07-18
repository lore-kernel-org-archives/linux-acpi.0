From: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Tue, 18 Jul 2017 10:24:27 -0600
Message-ID: <591a9373-11d0-db6b-b345-87ad3c706ffb@codeaurora.org>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <c6b2f416-964f-2283-56b6-899485f39652@codeaurora.org>
 <1500391630.2042.11.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500391630.2042.11.camel@hpe.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "bp@alien8.de" <bp@alien8.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "mchehab@kernel.org" <mchehab@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 7/18/2017 9:36 AM, Kani, Toshimitsu wrote:
> On Tue, 2017-07-18 at 08:39 -0600, Jeffrey Hugo wrote:
>> On 7/17/2017 3:59 PM, Toshi Kani wrote:
>>> The ghes_edac driver was introduced in 2013 [1], but it has not
>>> been enabled by any distro yet.
>>
>> Ubuntu is expected to enable this soon.
> 
> Interesting.  I was told from other distro that there were many buggy
> firmwares out there that prevented to enable ghes_edac.  Do you know if
> Ubuntu has any plan to address such issue?  Or do they not see such
> issue?  I do not test with other vendors' platforms, so I cannot tell
> exactly what those bugs are...
> 

I do not know if Ubuntu intends to address any "known issues".  I know a 
request was made to Canonical to enable the option, and it appears the 
request is being considered, although the option may be limited to 
ARM64, depending on how Canonical's evaluation goes.  I am not aware of 
any particular issues, so I cannot say what the side effects are, or 
what platforms are considered to exhibit such issues.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
