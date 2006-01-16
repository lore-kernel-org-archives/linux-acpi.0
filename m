From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: Strange interpreter behaviour
Date: Mon, 16 Jan 2006 20:22:49 +0100
Message-ID: <43CBF289.60401@tzi.de>
References: <3ACA40606221794F80A5670F0AF15F840AB2770B@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840AB2770B@pdsmsx403>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Yu, Luming wrote:
>>Sorry, seems I missed the main plot ;-)
>>In case \_SB.INV7 is 0, the _CST method returns a CST object with a C3 
>>and C4 State. If it is 1 I only get the "NOC3" (see above) CST object.
>>I can call the _L17 method as often as I want and it seems I 
>>allways get 
>>a clean fresh CST with only C1 and C2. That's why I assume that 
>>something with setting the \_SB.INV7 register is not right. I 
>>mentioned 
>>this a while ago in a bug : 
>>http://bugzilla.kernel.org/show_bug.cgi?id=4485
> 
> 
> Not sure, but I think you need to do further investigation.
> Are you sure _CST always exits with Return (NOC3).
> 
> ACST contains C3 state?
> 
Yep, ACST and BCST definitely contain one or more C3 states :
                 Name (ACST, Package (0x03)
                 {
                     0x02,
                     Package (0x04)
                     {
                         ResourceTemplate ()
                         {
                             Register (SystemIO, 0x08, 0x00, 
0x00000000000005FF)
                         },

                         0x02,
                         0x01,
                         0x03E8
                     },

                     Package (0x04)
                     {
                         ResourceTemplate ()
                         {
                             Register (SystemIO, 0x08, 0x00, 
0x0000000000000415)
                         },

                         0x03,
                         0x01,
                         0x01F4
                     }
                 })


                  Name (BCST, Package (0x04)
                 {
                     0x03,
                     Package (0x04)
                     {
                         ResourceTemplate ()
                         {
                             Register (SystemIO, 0x08, 0x00, 
0x00000000000005FF)
                         },

                         0x02,
                         0x01,
                         0x03E8
                     },

                     Package (0x04)
                     {
                         ResourceTemplate ()
                         {
                             Register (SystemIO, 0x08, 0x00, 
0x0000000000000415)
                         },

                         0x03,
                         0x01,
                         0x01F4
                     },

                     Package (0x04)
                     {
                         ResourceTemplate ()
                         {
                             Register (SystemIO, 0x08, 0x00, 
0x0000000000000416)
                         },

                         0x04,
                         0x02,
                         0xFA
                     }
                 })

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
