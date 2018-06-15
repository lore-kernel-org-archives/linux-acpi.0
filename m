From: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH] arm64/acpi: Add fixup for HPE m400 quirks
Date: Fri, 15 Jun 2018 11:15:34 -0700
Message-ID: <7a1768e2-bab5-c9f3-51b4-2131c9009498@infradead.org>
References: <51d3d738-cdf5-2992-bba5-c3e1f34096c2@infradead.org>
 <098e6d53-8dc7-439f-7165-adbe0e7c4941@arm.com>
 <8a3034b9-6cf3-5182-717f-dd1dc8a087aa@infradead.org>
 <5120aa9f167c19712c01dc812f689eaef23bf0c5.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5120aa9f167c19712c01dc812f689eaef23bf0c5.camel@redhat.com>
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
To: Mark Salter <msalter@redhat.com>, James Morse <james.morse@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Riku Voipio <riku.voipio@linaro.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Hi Mark,

On 06/15/2018 10:33 AM, Mark Salter wrote:
> On Fri, 2018-06-15 at 10:17 -0700, Geoff Levand wrote:
>>>> +            MIDR_IMPLEMENTOR(read_cpuid_id()) == ARM_CPU_IMP_APM) {
>>>
>>> How is the CPU implementer relevant?
>>
>> That was just a copy of what other fixes had.  Should I remove it?
> 
> It was there because HPE ProLiant strings are generic and you may end up
> disabling platforms which would otherwise work. It is the ProLiant system
> based on the APM chipset which is the problem. Thus the check for cpu
> implementor.

Your original fix that had this cpu implementor check was in the main
ACPI code, so would be built for other arches.  This is now in
arch/arm64/kernel/acpi.c, which will only be built for arm64.  Is that
enough to limit it, or do we still need the check?

-Geoff 
