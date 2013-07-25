From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] APEI/ERST: Fix error message formatting
Date: Thu, 25 Jul 2013 11:32:06 -0600
Message-ID: <CAErSpo5vLbsM5BXjrCVy1AKBxRRSH33TthyyK3O35Mghqw81nQ@mail.gmail.com>
References: <1374526866-6813-1-git-send-email-bp@alien8.de>
 <20130724171347.GB29756@naverao1-tp.watson.ibm.com> <1374686598.18818.18.camel@joe-AO722>
 <51F10AA8.2050901@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51F10AA8.2050901@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Joe Perches <joe@perches.com>, Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 25, 2013 at 5:23 AM, Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
> On 07/24/2013 10:53 PM, Joe Perches wrote:
>>
>> On Wed, 2013-07-24 at 22:43 +0530, Naveen N. Rao wrote:
>>>
>>> On 2013/07/22 11:01PM, Borislav Petkov wrote:
>>>>
>>>> From: Borislav Petkov <bp@suse.de>
>>>>
>>>> [    5.525861] ERST: Can not request iomem region <0x        c7eff000-0x
>>>> c7f00000> for ERST.
>>>>
>>>> This needs to have leading zeroes. Make it so.
>>
>>
>> Why does it need leading zeros?
>>
>>> While looking at this, I noticed that we seem to be using varying field
>>> widths in our APEI code:
>>> - einj.c has two instances using %#010llx.
>>> - apei-base.c uses widths of 10 (4 bytes) and 6 (2 bytes).
>>>
>>> Not sure if these are intentional and those fields truly aren't 64-bit
>>> (as suggested by the usage of long long int).
>>
>>
>> I suggest using "0x%llx" everywhere unless there's a
>> compelling reason like columnar alignment for them.
>
>
> I think that might be better. I see that these changes were done in commit
> 46b91e37. Copying Bjorn Helgaas.

As the 46b91e37 changelog says, it was done to use "the normal
%pR-like format".  I think that's a valid goal.  When we're printing
the same sort of information, we should use the same sort of format.

But I don't think the "Can not request iomem region <0x
c7eff000-0x        c7f00000> for ERST" output mentioned in the
original post was affected by 46b91e37.  I would suggest a change
similar to 46b91e37 for ERST, and I would suggest using the leading
zeros, with %#010llx for physical memory addresses and %#06llx for
ioport addresses.  That's what %pR uses, and it produces columnar
alignment in many cases (though not this one).

Bjorn
