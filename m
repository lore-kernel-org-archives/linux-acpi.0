From: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [RFC PATCH 2/2] ACPI / PPTT: cacheinfo: Label caches based on
 fw_token
Date: Wed, 10 Oct 2018 08:16:31 -0600
Message-ID: <d824d1c0-d26b-8b12-ef35-6b760844056f@codeaurora.org>
References: <20181005150235.13846-1-james.morse@arm.com>
 <20181005150235.13846-3-james.morse@arm.com>
 <a68abfd2-1e28-d9e7-919a-8b3133db4d20@arm.com>
 <10e15b8d-c0c2-b73a-de31-f87ae0d86469@arm.com>
 <236eab50-e1d0-e2f5-fb69-95451c4ccc7e@codeaurora.org>
 <20181010094637.GA13498@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181010094637.GA13498@e107155-lin>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Vijaya Kumar K <vkilari@codeaurora.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <Tomasz.Nowicki@cavium.com>, Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>, Richard Ruigrok <rruigrok@qti.qualcomm.com>, Hanjun Guo <guohanjun@huawei.com>, Xiongfeng Wang <wangxiongfeng2@huawei.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On 10/10/2018 3:46 AM, Sudeep Holla wrote:
> On Tue, Oct 09, 2018 at 12:34:51PM -0600, Jeffrey Hugo wrote:
>> On 10/9/2018 11:58 AM, James Morse wrote:
>>>
>>> It can be set for a non-leaf entry, I assumed it would always be set for a leaf.
>>> Is anyone doing this with a PPTT table?
>>
>> QDF2400 takes a strict interpretation of the spec, and does not set the flag
>> for leaf nodes.  I believe there are other implementations which do set the
>> flag for leaf nodes.
>>
> 
> IIRC, based on the discussions when this was added, the ACPI Processor
> ID  *must be* valid for the lead nodes.T he flag bit corresponding
> to that should be considered as don't care as it's always guaranteed
> to be valid.

Correct.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
