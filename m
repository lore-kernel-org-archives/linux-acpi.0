From: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Subject: Re: [PATCH v3 2/2] net: qcom/emac: add phy-handle support for ACPI
Date: Tue, 30 Oct 2018 05:15:21 +0000
Message-ID: <f203bb0a0d154ede9010889dab313d4e@HXTBJIDCEMVIW02.hxtcorp.net>
References: <78719753-77bd-596a-dfc7-ccd676850283@kernel.org>
 <cover.1540459999.git.dongsheng.wang@hxt-semitech.com>
 <7935985e49270ad2948b2a52d26510bdf55572e6.1540459999.git.dongsheng.wang@hxt-semitech.com>
 <20181025192430.GA16785@lunn.ch>
 <0a55d42c839140dd9a5264ab4dae4c8e@HXTBJIDCEMVIW02.hxtcorp.net>
 <ea868a30-13a1-f695-4e34-d873d975ebc9@kernel.org>
 <a1adfc5a696d40388ad9bf982f0ff64d@HXTBJIDCEMVIW02.hxtcorp.net>
 <20181026131301.GC30093@lunn.ch>
 <4f5563ba21604315b93cf128f18ce067@HXTBJIDCEMVIW02.hxtcorp.net>
 <20181029124044.GB9174@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Timur Tabi <timur@kernel.org>, "Zheng, Joey" <yu.zheng@hxt-semitech.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "robert.moore@intel.com" <robert.moore@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 2018/10/29 20:40, Andrew Lunn wrote:
> On Mon, Oct 29, 2018 at 02:39:36AM +0000, Wang, Dongsheng wrote:
>> On 2018/10/26 21:12, Andrew Lunn wrote:
>>> On Fri, Oct 26, 2018 at 03:04:25AM +0000, Wang, Dongsheng wrote:
>>>> On 2018/10/26 10:37, Timur Tabi wrote:
>>>>> On 10/25/18 9:18 PM, Wang, Dongsheng wrote:
>>>>>> But when I was reading Documentation/acpi/DSD-properties-rules.txt, my
>>>>>> understanding is we should try to conform to DT bindings. So maybe ACPI
>>>>>> doesn't have such a document, just DT bindings.
>>>>> There was an attempt to document DSDs, but it was abandoned after a while.
>>>>>
>>>>> https://github.com/ahs3/dsd
>>>>>
>>>> Yes, here's a database concept, and I asked some Intel guys, the answer
>>>> I got was there is no such database or document. :(
>>> Hi Dongsheng
>>>
>>> If there is no clear documentation for ACPI, it becomes even more
>>> important that the xgene code is refactored into a central location,
>>> and you make use of it. We really need to avoid every ACPI ethernet
>>> driver doing its own thing.
>> However, without a document specifying MDIO and phy-handle, it is almost
>> difficult for us to do this. Because maybe the ACPI device or property
>> corresponding to each platform is different.
>> Just like APM looks different to us. APM's MDIO adev doesn't describe
>> the concept of port, and our platform does. Besides, I cannot get the
>> ACPI table of APM or other manufacturers.
>> The table of ACPI cannot be obtained from kernel source as easily as DT.
>> We can't know without a platform to do ACPI dump. Unless some of the
>> manufacturers have pushed the table to upstream.
>> So I think we might have a hard time doing this without a document. And
>> it's likely that this work involves code modifications by BIOS vendors.
> Hi Dongsheng
>
> There are two different options here.
>
> 1) Everybody does their own thing, ignoring what everybody else has
> done, and invents their own wheel. There is no shared code, no shared
> description, everybody has their own bugs, etc. ACPI as a standard is
> pointless for Ethernet MDIOs and PHYs because it is not a standard,
> everybody does something different.
>
> 2) Somebody takes the time to design a concept for Ethernet PHYs and
> MDIO busses using ACPI. They implement the common code, try to modify
> any existing users if possible, and submit the whole thing to become
> part of ACPI 6.3.
>
> I would really prefer we go the second route here. It is more initial
> effort, but in the long run, everybody benefits.

Yes, I also would like the second one. I will reply in a few days.

Cheers,
Dongsheng

> 	Andrew
>
