From: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Sun, 16 Jan 2005 11:48:01 +0100
Message-ID: <41EA4661.4000304@tiscali.be>
References: <41E81C2C.8010809@bartol.udel.edu>	<1105747983.7368.3.camel@tyrosine>	<47e0449d05011419037877f931@mail.gmail.com> <m2fz13x8mw.fsf@phoenix.squirrel.nl> <41EA2C1D.3030909@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41EA2C1D.3030909-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

Thanks for your driver. With this new version, the AC adapter status is=20
available, which is better. There are even two ac_adapter directory in=20
/proc/acpi. However, I don't find anymore battery information. I have=20
seen that directory structure has changed and that now,=20
/proc/acpi/battery is empty. I have tried the cat command on the new sbs=20
sub-directory but I didn't find usual battery info. Also with the first=20
version you sended, I noticed that the remaining battery time was too=20
low. For example, with a battery fully loaded, I am supposed to have=20
only around 40 minutes of autonomy, which is a bit short !

Thanks for your help,
Sincerely yours,
Fran=E7ois Valenduc

Rich Townsend a =E9crit :

> Johan Vromans wrote:
>
>> Johannes Kuhlmann <jkuhlmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>
>>
>>> I had to put
>>> EXPORT_SYMBOL(acpi_ec_write); and EXPORT_SYMBOL(acpi_ec_read); after
>>> the functions in drivers/acpi/ec.c.
>>
>>
>>
>> This is one of the issues Bruno's patch addressed...
>>
>
> Yeah, I'd completely forgotten about the patch, until I went back and=20
> checked the instructions in Bruno's smartbatt package. D'oh!
>
> I've modified the README file accordingly, and placed a copy of the=20
> patch in my acpi-sbs package. This is on top of a number of changes &=20
> additions to the code, which include:
>
> *) Fixed scaling bug when capacity is reported in mWh
> *) Added a new module parameter, capacity_info, to alter whether=20
> capacities are reported in mAh (charge) or mWh (power)
> *) Fixed a number of bugs in the formatting of info/state output
> *) Added support for Smart Battery System Manager (SBSM), Smart=20
> Battery Selector (SBSEL) and Smart Battery Charge (SBC) subsystems.=20
> With the code for these in place, the module correctly (I think)=20
> enumerates how many batteries the system can support, which ones are=20
> present, etc.
> *) Added a new legacy interface for the AC adapter, in=20
> /proc/acpi/ac_adapter/*/state (where * is typically SBS0).
> *) Put in semaphores, so the code *might* now be SMP safe. Of course,=20
> this may be a purely academic excercise; I've never met the lucky ****=20
> who has an SMP laptop :)
>
> The latest copy of the code can be obtained from:
>
> http://shayol.bartol.udel.edu/~rhdt/download/acpi_sbs-20050116.tar.gz
>
> To move forward from here, I'd appreciate some advice from others on
> this list. In particular
>
> *) I'd like some feedback on the directory structure I've chosen. At=20
> the moment, the root directory of the Smart Battery System is 'sbs',=20
> but would something more verbose like 'smart_battery_system' be=20
> appropriate? Also, should various subdirectories, representing=20
> subsystems, have more descriptive names -- e.g., 'battery_A' instead=20
> of 'SB0' (the SBS spec. refers to the batteries as 'A', 'B' etc),=20
> 'selector' instead of 'SBSL', and so on?
>
> *) I'd appreciate feedback from people with systems *other* than Acer=20
> TravelMater 4x00 laptops, to help check parts of the code that are not=20
> accessed on these machines (e.g., the Smart Battery System Manager=20
> code; my TM4502 laptop has an older Smart Battery Selector)
>
> *) The code to update the Smart Battery System state from the SMBus is=20
> terribly slow, presumably because SMBus itself is a slow protocol.=20
> Unfortunately, this has the effect of freezing the system (including=20
> loss of keystrokes and/or mouse movements) whenever an update occurs.=20
> Typically, these freezes will arise every few seconds, as monitoring=20
> tools (e.g., gkrellm, wmacpi) poll the /proc/acpi interfaces. The=20
> jerkiness that results is unacceptable to many, including myself. How=20
> might I go about fixing this? I've tried putting a schedule() call=20
> after every individual SMBus access, but that appears to have little=20
> effect on the system responsiveness.
>
> *) I'm not sure how to go about implmeneting Alarm functionality, not=20
> only to deal with low-power scenarios, but also to detect asynchronous=20
> events such as AC on-line/off-line and battery change, without the=20
> need for polling. Certainly, interrupts *are* being generated=20
> somewhere, as evidenced by the incrementing value of the acpi field in=20
> /proc/interrupts. Furthermore, with ACPI debugging enabled, I can see=20
> the embedded controller handling the events; for instance, an AC=20
> off-line event produces the following debug output:
>
> Execute Method: [\_SB_.PCI0.LPC0.EC0_._Q20] (Node dded7de8)
>  acpi_ec-0180 [5125] acpi_ec_read          : Read [c0] from address [19=
]
>  acpi_ec-0180 [5125] acpi_ec_read          : Read [14] from address [3d=
]
>  acpi_ec-0180 [5125] acpi_ec_read          : Read [c0] from address [19=
]
>  acpi_ec-0232 [5126] acpi_ec_write         : Wrote [80] to address [19]
>
> The corresponding DSL code for function _Q20 of my DSDT is:
>
>                    Method (_Q20, 0, NotSerialized)
>                     {
>                         If (And (SMST, 0x40))
>                         {
>                             Store (SMAA, Local0)
>                             If (LEqual (Local0, 0x14))
>                             {
>                                 And (SMST, 0xBF, SMST)
>                             }
>                         }
>                     }
>
> ...which unfortunately doesn't mean a whole lot to me. How can I=20
> install some form of a handler, so that when the EC detects a Smart=20
> Battery event (and -- as per the ACPI spec -- sets the EC Alarm=20
> Address and Data registers), and then fires off a General Purpose=20
> Event, a chunk of *my* code gets run?
>
> Any pointers for the above questions will be very welcome -- and=20
> thanks to everyone who has responded with bug reports so far.
>
> cheers,
>
> Rich
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
