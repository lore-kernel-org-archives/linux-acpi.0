From: Ike Panhc <ike.pan@canonical.com>
Subject: Re: [PATCH 8/8] ideapad: Change the driver name to ideapad_laptop
Date: Wed, 01 Sep 2010 19:55:44 +0800
Message-ID: <4C7E3F40.70205@canonical.com>
References: <1282120564-11324-1-git-send-email-ike.pan@canonical.com>	<1282120734-11635-1-git-send-email-ike.pan@canonical.com>	<alpine.LFD.2.00.1008251656090.3037@localhost.localdomain>	<AANLkTi=STq=_K2NPnK4GM+XwruaR09m6QJ7nkuCJVQvB@mail.gmail.com>	<4C7606A9.40103@canonical.com> <AANLkTik5jZ69_=yzQaheUrxPvnnFFdyysjxndVKfdh1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <AANLkTik5jZ69_=yzQaheUrxPvnnFFdyysjxndVKfdh1d@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Len Brown <lenb@kernel.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <David.Woodhouse@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On 08/26/2010 03:43 PM, Corentin Chary wrote:
> On Thu, Aug 26, 2010 at 8:16 AM, Ike Panhc <ike.pan@canonical.com> wrote:
>> On 08/26/2010 01:43 PM, Corentin Chary wrote:
>>> On Wed, Aug 25, 2010 at 10:56 PM, Len Brown <lenb@kernel.org> wrote:
>>>>>  drivers/platform/x86/ideapad_acpi.c   |  381 ---------------------------------
>>>>>  drivers/platform/x86/ideapad_laptop.c |  381 +++++++++++++++++++++++++++++++++
>>>>
>>>> Acked-by: Len Brown <len.brown@intel.com>
>>>>
>>>> thanks,
>>>> Len Brown, Intel Open Source Technology Center
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> Probably not very important .. but .. other drivers are called *-laptop.c, not
>>> *_laptop.c ..
>>>
>>> asus-laptop.c classmate-laptop.c compal-laptop.c dell-laptop.c eeepc-laptop.c
>>> fujitsu-laptop.c msi-laptop.c panasonic-laptop.c sony-laptop.c topstar-laptop.c
>>>
>> I choose _laptop.c not -laptop.c because when modprobe. We are using
>> "modprobe asus-laptop", but when removing, using "modprobe asus_laptop".
>>
> 
> Hum, that's a "bug" in asus-laptop, because I used KBUILD_MODNAME
> (asus_laptop) instead
> of "asus-laptop" as the driver name. And I don't know if I can change
> that now without breaking
> backward compatibility.
> 
> But other drivers should work (I tested sony-laptop).
> 
Looks like I have some misunderstanding on this. Thank you for correcting it.
When I resend patches, I will change the name to *-laptop. :)
