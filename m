From: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Sat, 01 Jan 2005 23:33:10 +0100
Message-ID: <41D72526.3030205@tiscali.be>
References: <20041231092156.GA612@phys.ethz.ch>	<41D56002.5060008@mega.ist.utl.pt>	<20041231150724.GK19199@poupinou.org>	<20041231181628.GL19199@poupinou.org>	<20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2acrth375.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
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

Johan Vromans a =E9crit :

> Happy New Year to y'all!
>
> Mathias Weyland <mweyland-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org> writes:
>
>> corcovado:/usr/src/smartbatt# ./smartbattery
>> Error: No i2c-bus specified!
>> Syntax: smartbatt I2CBUS
>> Installed I2C busses:
>> i2c-1 unknown ACPI EC SMBus adapter at 0018
>> Algorithm unavailable
>> i2c-0 unknown SMBus I801 adapter at 1880
>> Algorithm unavailable
>
>
> I only have one bus i2c-0 (ACPI EC SMBus adapter at 0018) here.
>
>> corcovado:/usr/src/smartbatt# ./smartbattery 1
>> current: 65535 mA
>> remain: 65535 mA or mWh
>> time to empty: 65535 minutes
>> time to full: 65535 minutes
>> temperature: 6280.5 C
>> voltage: 65535 mV
>
>
> Same here (with bus 0).
> I also get a lot of spinlock errors in my system log.
>
>> Loading the module shows:
>>
>> i2c_acpi_ec: disagrees about version of symbol struct_module
>> base: 0x18 alert: 0x20
>> i2c-acpi-ec.c: ACPI EC SMBus adapter at 0x18
>
>
> Same here, except for the disagreement.
>
>> corcovado:/home/lea# i2cdetect 1
>> WARNING! This program can confuse your I2C bus, cause data loss and=20
>> worse!
>> I will probe file /dev/i2c-1.
>> I will probe address range 0x03-0x77.
>> Continue? [Y/n]
>> 0 1 2 3 4 5 6 7 8 9 a b c d e f
>> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX
>
>
> Same here (also with a lot of spinlock errors).
>
> Thanks for the good work!
>
> -- Johan
>
Hello everybody,
I also get the same results when I run the smartbattery or the i2cdetect=20
program. Nevertheless, I don't get error in symbol while loading the=20
i2c-acpi-ec module. I only get the base: 0x18 alert: 0x20 message.
Nevertheless thanks a lot for your effort. Unfortunately, I don't have=20
any knowledge in kernel programming so I can't help you to improve the=20
driver.

Sincerely yours,
Fran=E7ois Valenduc


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
