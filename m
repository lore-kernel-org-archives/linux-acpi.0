From: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Subject: Question about DSDT hack
Date: Sun, 06 Mar 2005 19:06:23 +0100
Message-ID: <422B469F.2000802@colitti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

as reported a few weeks ago on this list, when my nc6000 resumes from 
sleep I don't get events for battery or AC adapter insertion/removal. 
This means that if I suspend on AC power and resume on battery I don't 
know how much the laptop is going to live unless I reload the battery 
and ac modules.

I have traced this to the _WAK function in my DSDT, which, among other 
things, does the following:

>         Store (\_SB.C044.C057.C0E7.C127 (), Local2)
>         \_SB.C044.C057.C0E7.C0EC (0x03, 0xFF)
>         Store (\_SB.C044.C057.C0E7.C0ED (), Local1)
>         Store (\_SB.C044.C057.C0E7.C127 (), Local3)
>         XOr (Local2, Local3, Local3)
>         If (Local3)
>         {
>             Notify (\_SB.C134, 0x80)
>         }

C134 is the AC adapter, C136 and C137 are the battery slots. As can be 
seen from the above code, ACPI does nothing at all about the batteries 
and only notifies the AC adapter event if some complicated condition 
occurs. Hacking blindly, I changed the last few lines to the following:

>         XOr (Local2, Local3, Local3)
>         Notify (\_SB.C134, 0x80)
>         Notify (\_SB.C136, 0x80)
>         Notify (\_SB.C137, 0x80)

which unconditionally notifies battery and AC adapter events. It seems 
to work OK, but I haven't the faintest idea what the original code is 
trying to do or even what the new code does (for example, what does the 
0x80 do?). Is there someone who can explain it to me?

Further debug info: my DSDT is attached, and this is what I see in 
/proc/acpi:

> flyingsaucer:/proc/acpi# ls ac_adapter/ battery/ button/ embedded_controller/ fan/ power_resource/
> ac_adapter/:
> C134
> 
> battery/:
> C136  C137
> 
> button/:
> lid  power  sleep
> 
> embedded_controller/:
> C0E7
> 
> fan/:
> C20F  C210  C211  C212
> 
> power_resource/:
> C0E6  C13D  C16D  C184  C18B  C195  C20B  C20C  C20D  C20E

Any pointers appreciated. :)

Thanks,
Lorenzo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
