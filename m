From: =?ISO-8859-15?Q?Luis_Miguel_Garc=EDa?= <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>
Subject: acpi problem with nforce motherboards and ethernet
Date: Thu, 05 Feb 2004 18:41:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40228038.1070003@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi:

Since Andrew Morton picked up latest acpi bk updates, nforce motherboards=
 have problems, mainly with ethernet adapters. Reporters say that with ac=
pi=3Doff, the problm gets fixed, so we think the problem could be acpi. S=
ome more useful info:



On Tue, 3 Feb 2004, [ISO-8859-1] Luis Miguel Garc=EDa wrote:


>> When I try to boot with latest mm series (such as actual rc3-mm1 or
>> rc2-mm2), my nforce ethernet device doesn't works. It worked in the pa=
st
>> with the forcedeth reverse engineered driver but now it keeps for 30 o=
r
>> more seconds halted (at boot) and then the network device dosn't run.
>>
>> Here is the dmesg of rc3-mm1. Do you want for me to test something? Th=
anks!
>>
>> P.S.:   The ACPI related messages are larger that in rc3.
> =20
>

My e100 on an nforce2 won't work in rc3-mm1.
The "acpi=3Doff" boot parameter makes it go.


And for the record, I can boot with that kernel and save one dmesg for yo=
u if you want. Only send me a request and I'll send it to you.

P.S.: Sent any messages you want directly to me as i'm not subscribed to =
acpi-devel.

Thanks,

Luis Miguel Garc=EDa





>Which part of nforce support are you talking about luis?

>On Thu, 5 Feb 2004, Andrew Morton wrote:


>> Luis Miguel Garc?a <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org> wrote:
> =20
>
>>> >
>>> > Andrew Morton wrote:
>>> >
>>   =20
>>
>>>> > >
>>>     =20
>>>
>>>>> > >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/=
2.6.2/2.6.2-mm1/
>>>>> > >>
>>>>> > >>
>>>>> > >>
>>>>> > >> - Merged some page reclaim fixes from Nick and Nikita.  These =
yield some
>>>>> > >>  performance improvements in low memory and heavy paging situa=
tions.
>>>>> > >>
>>>>> > >>
>>>>       =20
>>>>
>>> >
>>> > Andrew, do you know if this acpi pull down has nforce support fixed=
?
>>   =20
>>
>>
>> It doesn't appear that way.
>>
> =20
>
>>> > Or perhaps it's even unnotified to the acpi team?
>>   =20
>>
>>
>> I do not know.  Sending them a bugzilla ID would help, if such a thing=
 exists.
>>
>>
>>
>> -------------------------------------------------------
>> The SF.Net email is sponsored by EclipseCon 2004
>> Premiere Conference on Open Tools Development and Integration
>> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
>> http://www.eclipsecon.org/osdn
>> _______________________________________________
>> Acpi-devel mailing list
>> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>
>>
> =20
>


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
