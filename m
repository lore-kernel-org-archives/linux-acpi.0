From: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Mon, 03 Jan 2005 16:41:41 +0100
Message-ID: <41D967B5.7040002@tiscali.be>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org> <20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl> <20050103143902.GQ19199@poupinou.org> <41D95CDC.8050802@phys.ethz.ch> <41D95F53.5000008@tiscali.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41D95F53.5000008-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello again,
In fact, after having completely recompiled the modules, it works better=20
however the value for "time to empty" seems more correct. Here are the=20
results with the AC adapter unplugged:
    current:       64345 mA
    remain:        6327 mA or mWh
    time to empty: 221 minutes
    time to full:  221 minutes
    temperature:   27.4 C
    voltage:       16589 mV
And with the AC adapter plugged:
    current:       0 mA
    remain:        6330 mA or mWh
    time to empty: 65535 minutes
    time to full:  65535 minutes
    temperature:   27.4 C
    voltage:       16809 mV
I don't really understand why each time the time to full or to empty are=20
the same. I tried it knowing my battery was fully loaded so I should get=20
0 minute for time to full.

Fran=E7ois Valenduc a =E9crit :

> Hello,
> I must have missed something:
>
> When I compile the i2c-acpi-ec module, I get the following errors:
> *** Warning: "i2c_del_adapter"=20
> [/usr/src/smartbatt/i2c-acpi-ec/i2c-acpi-ec.ko] undefined!
> *** Warning: "i2c_add_adapter"=20
> [/usr/src/smartbatt/i2c-acpi-ec/i2c-acpi-ec.ko] undefined!
> *** Warning: "acpi_ec_read"=20
> [/usr/src/smartbatt/i2c-acpi-ec/i2c-acpi-ec.ko] undefined!
> *** Warning: "acpi_ec_write"=20
> [/usr/src/smartbatt/i2c-acpi-ec/i2c-acpi-ec.ko] undefined!
> I also have a problem when I load the i2c-core module:
>    i2c_core: disagrees about version of symbol struct_module
>
> What should I do to fix these errors ?
> Thanks for your help,
> Fran=E7ois Valenduc
> =20
> Mathias Weyland a =E9crit :
>
>> Bruno Ducrot wrote:
>>
>>> I think I found was wrong.  Please refetch, or (at your option) repla=
ce
>>> i2c-acpi-ec.ec with
>>> http://www.poupinou.org/acpi/smartbatt/smartbatt/i2c-acpi-ec/i2c-acpi=
-ec.c=20
>>>
>>> then redo the sh compile.sh
>>> Sorry, it was a stupid bug(tm) requiring that I buy a brown bag...
>>
>>
>>
>> Ok, I don't understand the joke with the brown bag, but.... wooohoo!=20
>> It looks like something is working!
>>
>> Wich ac plugged in:
>>
>> corcovado:/usr/src/smartbatt# ./smartbattery 1
>> current:       0 mA
>> remain:        2027 mA or mWh
>> time to empty: 65535 minutes
>> time to full:  65535 minutes
>> temperature:   28.7 C
>> voltage:       16767 mV
>>
>>
>> And after I plugged it out:
>>
>> corcovado:/usr/src/smartbatt# ./smartbattery 1
>> current:       64499 mA
>> remain:        2026 mA or mWh
>> time to empty: 117 minutes
>> time to full:  117 minutes
>> temperature:   28.7 C
>> voltage:       16428 mV
>>
>>
>> You definitley are my hero! Thank you very much. I'll instantly call=20
>> my girlfriend.
>>
>>
>>> Something wrong also with rmmod i2c-acpi-ec :( so you have to reboot =
in
>>> order to be able to 'insmod i2c-acpi-ec.ko' again (I'm sure the brown
>>> bag will still be helpfull also...).
>>
>>
>>
>> Well yes, and when I run smartbattery several times, I don't always=20
>> get exactley the same values:
>>
>> corcovado:/usr/src/smartbatt# ./smartbattery 1
>> current:       64108 mA
>> remain:        1885 mA or mWh
>> time to empty: 79 minutes
>> time to full:  79 minutes
>> temperature:   30.1 C
>> voltage:       15950 mV
>> corcovado:/usr/src/smartbatt# ./smartbattery 1
>> current:       64159 mA
>> remain:        1885 mA or mWh
>> time to empty: 82 minutes
>> time to full:  82 minutes
>> temperature:   30.1 C
>> voltage:       15926 mV
>>
>>
>> And it would be nice if that could be read through a /sys file. I=20
>> think it's time for me to contribute something: I'll fix the 65535=20
>> error and try to make the information available through a /sys=20
>> interface.
>>
>> Thank you very very much for all the work you made.
>>
>> Best Regards
>>
>> Mathias
>>
>>
>> -------------------------------------------------------
>> The SF.Net email is sponsored by: Beat the post-holiday blues
>> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
>> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
>> _______________________________________________
>> Acpi-devel mailing list
>> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>
>
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
>



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
