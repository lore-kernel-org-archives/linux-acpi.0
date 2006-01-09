From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: Strange interpreter behaviour
Date: Mon, 09 Jan 2006 08:16:18 +0100
Message-ID: <43C20DC2.2040409@tzi.de>
References: <3ACA40606221794F80A5670F0AF15F840AA37537@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840AA37537@pdsmsx403>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Yu, Luming wrote:
>>I got an ASUS M6, which contains some strange _CST related ASL code.
>>In the _CST method there is a check, if \_SB.INV7 is set :
>>                If (\_SB.INV7)
>>                {
>>                    Return (NOC3)
>>                }
>>This seems to always return true. There is also the method \_GPE:_L17 
>>which just inverts \_SB.INV7 and sends a signal to refetch the 
>>CST Object :
>>          Method (_L17, 0, NotSerialized)
>>        {
>>            If (\_SB.INV7)
>>            {
>>                Store (0x00, \_SB.INV7)
>>            }
>>            Else
>>            {
>>                Store (0x01, \_SB.INV7)
>>            }
>>
>>            Notify (\_PR.CPU1, 0x81)
>>        }
>>
>>Now I called the _L17 method manually :
>>echo "0:\\_GPE:_L17:\\_GPE:_L17:10001:1" > 
>>/proc/acpi/hotkey/poll_config
>>echo "10001:0:1:0" > /proc/acpi/hotkey/action
>>
>>What I noticed is that every time I call the action, my C-State usage 
>>counter gets reset to zero. From that behaviour I would 
> 
> 
> Please show  /proc/acpi/processor/power .
>
Before executing \_GPE:_L17 :

active state:            C2
max_cstate:              C8
bus master activity:     00000000
states:
     C1:                  type[C1] promotion[C2] demotion[--] 
latency[000] usage[00000010]
    *C2:                  type[C2] promotion[--] demotion[C1] 
latency[001] usage[00037580]

After executing
active state:            C2
max_cstate:              C8
bus master activity:     00000000
states:
     C1:                  type[C1] promotion[C2] demotion[--] 
latency[000] usage[00000010]
    *C2:                  type[C2] promotion[--] demotion[C1] 
latency[001] usage[00000430]


> 
>>follow, that the 
>>L17 method was executed and the CST Object was refetched. 
>>there seems 
>>to be an error in setting the \_SB.INV7 bit/register/whatever. 
>>(I assume 
>>0 is false an 1 is true in ASL if-clauses ?)
> 
> 
> Don't understand what is wrong.
> Please clearly point it out.

Sorry, seems I missed the main plot ;-)
In case \_SB.INV7 is 0, the _CST method returns a CST object with a C3 
and C4 State. If it is 1 I only get the "NOC3" (see above) CST object.
I can call the _L17 method as often as I want and it seems I allways get 
a clean fresh CST with only C1 and C2. That's why I assume that 
something with setting the \_SB.INV7 register is not right. I mentioned 
this a while ago in a bug : http://bugzilla.kernel.org/show_bug.cgi?id=4485
Greets
    Janosch
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
