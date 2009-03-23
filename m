From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: Re: Paravirtualizing bits of acpi access
Date: Mon, 23 Mar 2009 11:29:59 +0800
Message-ID: <0A882F4D99BBF6449D58E61AAFD7EDD60E5E8766@pdsmsx502.ccr.corp.intel.com>
References: <49C484B7.20100@goop.org> <200903211810.53990.rjw@sisk.pl>
	<49C5BDD8.1050605@goop.org> <200903221228.40181.rjw@sisk.pl>
	<49C67054.7020603@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <49C67054.7020603@goop.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: 'Jeremy Fitzhardinge' <jeremy@goop.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Brown, Len" <len.brown@intel.com>, "Cihula,
	Joseph" <joseph.cihula@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

>From: Jeremy Fitzhardinge
>Sent: Monday, March 23, 2009 1:08 AM
>
>Rafael J. Wysocki wrote:
>> On Sunday 22 March 2009, Jeremy Fitzhardinge wrote:
>>  =20
>>> Rafael J. Wysocki wrote:
>>>    =20
>>>> Well, why don't you implement the platform suspend=20
>operations for Xen?
>>>> I guess you don't want ACPI _PTS to be executed during=20
>suspend as well.
>>>>  =20
>>>>      =20
>>> I don't know.  What's _PTS?
>>>    =20
>>
>> It's an ACPI method called to prepare the platform to enter=20
>the sleep state
>> (the name stands for "prepare to sleep").  Executing it may=20
>affect the
>> hardware.
>>  =20
>
>OK, that's what we want.  Dom0 is the control domain which is=20
>responsible for the bulk of the hardware; Xen itself has very little=20
>hardware knowledge.

yes, Xen only takes care of several core system devices (pic,=20
ioapic, serial, timer sources) and cpus, and let dom0 control all
the rest. _PTS, imo, will not affect Xen controlled devices as=20
even on native those devices are suspended after _PTS. Also
Xen doesn't incorporate ACPI parser and thus can't evaluate any
ACPI method on its own.

>
>> I think you really should not execute any global ACPI=20
>methods to suspend a
>> guest, because that may affect the host.  That's why I think=20
>it's better to
>> regard Xen as a platform and implement a separate set of=20
>suspend operations for
>> it.
>>  =20
>
>In this case we're talking about the special privileged domain=20
>which can=20
>be considered to be on the "host" side of the line.=20
>
>That said, I'd be interested in looking at a suspend operations-based=20
>approach if you think its the right way to go.  But I'm concerned that=20
>we'd end up with a big set of very similar-looking parallel functions=20
>just to deal with some difference in detail near the bottom.  Can you=20
>give me a pointer to where this gets put together for acpi?
>

As Jeremy pointed out, dom0 is a special domain which cooperate
with Xen to fulfill the whole S3 sequence, i.e. dom0 still carries 99%
existing ACPI S3 flow, with several exceptions as below:

a) No need to prepare wakeup stub (since it's Xen to be first waken
up after resume), and no expectation that execution flow will be=20
resumed from its wakeup stub (context is resumed at hypercall
return)

b) No need to save/restore bsp context and gear to Xen by hypercall
at last step where originally hardware reg bits are written

And then Xen jumps in to finish remaining steps. From this angle,
Xen is not a completely new platform and, well, S3 is more like a
'S1' type from dom0's p.o.v with a different trigger method. Then is
it overkilled to introduce a new set of ops with 99% content=20
duplicated?

Thanks,
Kevin=20
