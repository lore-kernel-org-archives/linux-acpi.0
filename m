From: Erik Meitner <usenet-cuDg6iFcrsRAfugRpC6u6w@public.gmane.org>
Subject: Re: DSDT Change (Compaq Presario 2100)
Date: Tue, 29 Jun 2004 15:04:46 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <cbsi0v$t1r$1@sea.gmane.org>
References: <200405280621.29874.andre@eisenbach.com> <c9am7j$nng$1@sea.gmane.org> <200405291345.51712.andre@eisenbach.com> <20040628213409.GA19468@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040628213409.GA19468-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>>and errors, I stumbled across this (in method SMSL
>>>>
>>>>If (0x01)
>>>>{
>>>>	Store (\_SB.PCI0.ISA.EC0.TTDC, TRDC)
>>>>	Store ("AC remove! Set Throttle Duty Cycle ---: ", Debug)
>>>>	Store (TRDC, Debug)
>>>>	Store (0x01, TREN)
>>>>}
>>>
>>>The DSDT for my laptop has the exact same code.
>>
>>That piece of code is the state cange code (i.e. when you unplug the AC cord). 
>>There is another place you need to change, which initializes the behaviour 
>>when you boot with the power cable already unplugged.
>>
>>The method is _REG. Here is the code
>>
>>                                Store (0x01, \_SB.PCI0.PMU.CRUN)
>>                                If (0x01)
>>                                {
>>                                    Store (\_SB.PCI0.ISA.EC0.TTDC, TRDC)
>>                                    Store (0x01, TREN)
>>                                }
>>
>>Once again change "If (0x01)" to "If (0x00)".
> 
> 
> Try your machine on battery, with full load. Monitor battery
> temperature. If it gets hot, your battery was not really designed for
> this, and forget this...
> 								Pavel

Is the concern here that this allows the system to draw a greater 
current from the battery than it was designed for? If so, too bad that 
there is no way for the system to monitor current draw and throttle back 
when it gets to great.

Erik



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
