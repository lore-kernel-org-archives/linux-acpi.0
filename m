From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Battery change in sleep mode breaks battery support
Date: Wed, 09 Feb 2005 20:15:16 +0100
Message-ID: <420A6144.5050501@suse.de>
References: <420A224B.9050308@colitti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <420A224B.9050308-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Lorenzo Colitti wrote:
> Hi,
> 
> I am having problems with battery monitoring and sleep mode: if I plug 
> in or unplug the battery while the machine is asleep, when it wakes up 
> the change has not been registered and no further changes are logged.
> 
> This means that I suspend the machine while on AC power and wake it up 
> on battery power, there is no way for me to keep track of how much 
> charge is left, which is a problem!
> 
> As an example, I started with init=/bin/sh, with no battery and AC 
> plugged in, and did the following:
> 
>> sh-3.00# modprobe battery
>> ACPI: Battery Slot [C138] (battery absent)
>> ACPI: Battery Slot [C137] (battery absent)
>> sh-3.00# modprobe ac
>> ACPI: AC Adapter [C135] (on-line)
>> sh-3.00# echo 3 > /proc/acpi/sleep
> 
> 
> While the machine was asleep, I plugged in the battery and removed AC 
> power, then turned the machine on. The kernel didn't notice that the 
> battery had been plugged in:
> 
>> sh-3.00# cat /proc/acpi/battery/C138/info present:                 no
>> sh-3.00# cat /proc/acpi/battery/C137/info
>> present:                 no
>> sh-3.00# cat /proc/acpi/ac_adapter/C135/state state:                   
>> off-line
> 
> 
> Unplugging and reinserting the battery and/or reloading the battery 
> module didn't help. :(
> 
> The machine is an HP NC6000 on which ACPI mostly works (decompiling and 
> recompiling the DSDT yields only the warning "Unknown reserved name 
> (_WDG)"). I have ACPI debugging enabled in the kernel, but I don't know 
> how to use it.
> 
> Any ideas?
> 
I expect that your _WAK function does not work properly.
Does S3 invoke the _WAK function after wake up?

I remember some things like that concerning suspend to disk (no buttons, 
wrong AC/battery states), that vanished when using platform mode.
The main differnce to shutdown mode is (correct me if I am wrong), that 
the BIOS _WAK function is called and the devices get initialised again.

        Thomas



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
