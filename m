From: elbg <elbg-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: Re: Acpica problem and explanations !
Date: Mon, 30 Jun 2003 21:29:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F008FA5.1070502@laposte.net>
References: <3F0066B0.90101@laposte.net>  <3F0075A2.9070107@laposte.net> <1056997730.3204.8.camel@darkstar.portugal>
Reply-To: elbg-QFKgK+z4sOrR7s880joybQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: Quoted-Printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1056997730.3204.8.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

S=E9rgio Monteiro Basto a =E9crit :

> On Mon, 2003-06-30 at 18:38, elbg wrote:
> =20
>
>> Hi,
>> Somebody can say to me if it is good what I have just said.!
>> Thank You !
>>
>> elbg a =E9crit :
>>
>>  =20
>>
>>> Hi,
>>> Can be that I badly understood ?
>>>
>>> - ACPICA is a product INTEL for the support of the ACPI ?
>>> - I must delete a ACPI drivers in "=20
>>> /usr/src/kernel-souce/drivers/acpi/ " well to be able to use in=20
>>> place ACPICA ?
>>>    =20
>>
>
> no,

I said that because I read it on the Intel web-site, installation=20
instrucion : =20
"http://developer.intel.com/technology/iapc/acpi/downloads.htm"


> =20
>
>>> - But or must I put it this ACPICA ?
>>> - I also put the ASLCompiler " IASL " in the directory=20
>>> "/usr/src/acpica-unix-20030619/compiler/"
>>>    =20
>>
> anywhere just do: tar zxvf acpica-unix-20030619.tar.gz

Ok ! Thank

>
> =20
>
>>> - When I launch MAKE in "/usr/src/acpica-unix-20030619/compiler/" I=20
>>> have this message :
>>> " bison -v -d -y -pAslCompiler aslcompiler.y "
>>> " aslcompiler.y:190.12-41: type redeclaration for=20
>>> PARSEOP_ACCESSATTRIB_WORLD_CALL "
>>> " make: *** [aslcompilerparse.c] Error 1 "
>>>
>>> I'm doing something wrong  ?
>>>    =20
>>
>
> I don't had any problem compiling aslcompiler
> can you clean up everything and doit again ?
> if it fail again tell me what version of bison are you using, and some
> more information about your OS ok?

Bison -version : 1.875a
OS : Linux/Debian Unstable Kernel 2.4.18
Gcc -version : 3.3.1 20030626 Debian Prerelease
Make -version : 3.80

You need another thing.?
Thank S=E9rgio,

>
> =20
>
>>> Thank,
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>> -------------------------------------------------------
>>> This SF.Net email sponsored by: Free pre-built ASP.NET sites includin=
g
>>> Data Reports, E-commerce, Portals, and Forums are available now.
>>> Download today and enter to win an XBOX or Visual Studio .NET.
>>> http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01=
/01=20
>>>
>>> _______________________________________________
>>> Acpi-devel mailing list
>>> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>>    =20
>>
>>
>>
>>
>> -------------------------------------------------------
>> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
>> Data Reports, E-commerce, Portals, and Forums are available now.
>> Download today and enter to win an XBOX or Visual Studio .NET.
>> http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/=
01
>> _______________________________________________
>> Acpi-devel mailing list
>> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>  =20
>




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
