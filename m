From: Corrado Zoccolo <czoccolo@gmail.com>
Subject: Re: "ACPI: EC: missing confirmations, switch off interrupt mode"
	wastes time on startup
Date: Wed, 29 Apr 2009 09:41:14 +0200
Message-ID: <4e5e476b0904290041u6bb475e0o9a409b5e6d83b9ba@mail.gmail.com>
References: <4e5e476b0903260847m1de3e976ne20279df359176cf@mail.gmail.com>
	 <9b2b86520903260958r790e5459r553308311522e88f@mail.gmail.com>
	 <4e5e476b0903261454h1525c30chdc86dbcb1cf3cb5c@mail.gmail.com>
	 <9b2b86520903270310x78193514l44b89ed6d3088cf8@mail.gmail.com>
	 <48f7fe350904281736j5ecb6fa8l12426fc17f591551@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758034AbZD2Hlb@vger.kernel.org>
In-Reply-To: <48f7fe350904281736j5ecb6fa8l12426fc17f591551@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Hope <rmh3093@gmail.com>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, linux-kernel@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Alexey has provided a patch for this. Please look at:
http://bugzilla.kernel.org/show_bug.cgi?id=12949

Corrado

On Wed, Apr 29, 2009 at 2:36 AM, Ryan Hope <rmh3093@gmail.com> wrote:
> I am getting this on my Acer also...
>
> -Ryan
>
> On 3/27/09, Alan Jenkins <sourcejedi.lkml@googlemail.com> wrote:
>> On 3/26/09, Corrado Zoccolo <czoccolo@gmail.com> wrote:
>>> On Thu, Mar 26, 2009 at 5:58 PM, Alan Jenkins
>>> <sourcejedi.lkml@googlemail.com> wrote:
>>>> On 3/26/09, Corrado Zoccolo <czoccolo@gmail.com> wrote:
>>>>
>>>> Currently there is no option to force polling, sorry.  I'm _guessing_
>>>> this was a deliberate omission.  But I can sympathise that even 0.5s
>>>> boot delay is bad on a netbook.
>>>>
>>> Yes. Do you think that changing olpc_ec_timeout kernel parameter may
>>> help in getting the timeout sooner?
>>>
>>
>> No, that's something different.  There's no boot option to change the
>> timeout.
>>
>>>> Feel free to create a new bugzilla entry.  You can attach the full
>>>> output of dmesg, but acpidump is probably not required.  What would be
>>>> really helpful is if you could file on bugzilla, and attach a full
>>>> debug trace.  I.e. as well as the normal dmesg, attach the dmesg
>>>> output after recompiling with this change:
>>>>
>>>
>>> bug: http://bugzilla.kernel.org/show_bug.cgi?id=12949
>>> full debug dmesg: http://bugzilla.kernel.org/attachment.cgi?id=20695
>>
>> Great.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>



-- 
__________________________________________________________________________

dott. Corrado Zoccolo                          mailto:czoccolo@gmail.com
PhD - Department of Computer Science - University of Pisa, Italy
--------------------------------------------------------------------------
The self-confidence of a warrior is not the self-confidence of the average
man. The average man seeks certainty in the eyes of the onlooker and calls
that self-confidence. The warrior seeks impeccability in his own eyes and
calls that humbleness.
                               Tales of Power - C. Castaneda
