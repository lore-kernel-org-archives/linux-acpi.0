From: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>
Subject: Re: acpi problem with nforce motherboards and ethernet
Date: Thu, 05 Feb 2004 20:25:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <402298C7.5050405@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

(sorry with my sucking english)

ok, let me know if you know for me to test something with this newer mm=20
kernels.

by the way, yes, I'm experiencing the lockups. Not with heavy io, but=20
almost when I boot and enter X. The system gets completly frozzened and=20
the HD led keps on. When I reboot with a sane kernel, I found several=20
files from my /home directory are deleted or filled with garbage.

Now, I patch each kernel I use with the two patches Andrew sent to me=20
and I'm having no problems.

Actually i'm running 2.6.2-ck1 + nforce-patches and the temperature of=20
the system is 55=BA while idle, and 631 while compiling (only cpu fan, no=
=20
case fans). I don't know if it's high (some people reported high=20
temperatures with this patches) but it runs very well this way.

If you want for me to test some patches or something, please drop me a no=
te.

Thanks a lot...

Luis Miguel Garc=EDa

P.S.: by the way, why am I getting strage "arabesque" characters when I=20
reply to your emails? Perhaps something with wrong encoding?

>This is interesting, I will test it myself later on. At one point Len
>admitted to owning "foreign hardware :p" so maybe this could get resolve=
d.
>
>Personally I haven't tried kernels with newer forcedeth drivers, because=
 I
>can no longer explicitely set the power state of the NIC to D3. The
>machine complains about irqs (new debugging code since forcedeth v.20 or
>so) and will not powerdown.
>
>On another note, have you noticed lockups of your system with heavy io?
>Think of fsck'ing, burning cdroms, du on large dirs etc? Maybe it is
>helpful to set up a list of boards and document what works or doesn't wo=
rk
>with which kernel. For instance the lockups with heavy io seem to be
>resolved here if I leave APIC from my kernel.
>
>Arjen
>
>On Thu, 5 Feb 2004, [ISO-8859-15] Luis Miguel Garc?a wrote:
>
> =20
>
>>> Hi:
>>>
>>> Since Andrew Morton picked up latest acpi bk updates, nforce motherbo=
ards have problems, mainly with ethernet adapters. Reporters say that wit=
h acpi=3Doff, the problm gets fixed, so we think the problem could be acp=
i. Some more useful info:
>>>
>>>
>>>
>>> On Tue, 3 Feb 2004, [ISO-8859-1] Luis Miguel Garc?a wrote:
>>>
>>>
>>   =20
>>
>>>>> >> When I try to boot with latest mm series (such as actual rc3-mm1=
 or
>>>>> >> rc2-mm2), my nforce ethernet device doesn't works. It worked in =
the past
>>>>> >> with the forcedeth reverse engineered driver but now it keeps fo=
r 30 or
>>>>> >> more seconds halted (at boot) and then the network device dosn't=
 run.
>>>>> >>
>>>>> >> Here is the dmesg of rc3-mm1. Do you want for me to test somethi=
ng? Thanks!
>>>>> >>
>>>>> >> P.S.:   The ACPI related messages are larger that in rc3.
>>>>       =20
>>>>
>>>> >
>>>> >
>>>     =20
>>>
>>>
>>> My e100 on an nforce2 won't work in rc3-mm1.
>>> The "acpi=3Doff" boot parameter makes it go.
>>>
>>>
>>> And for the record, I can boot with that kernel and save one dmesg fo=
r you if you want. Only send me a request and I'll send it to you.
>>>
>>> P.S.: Sent any messages you want directly to me as i'm not subscribed=
 to acpi-devel.
>>>
>>> Thanks,
>>>
>>> Luis Miguel Garc?a
>>>
>>>
>>>
>>>
>>>
>>   =20
>>
>>>> >Which part of nforce support are you talking about luis?
>>>     =20
>>>
>>>
>>   =20
>>
>>>> >On Thu, 5 Feb 2004, Andrew Morton wrote:
>>>     =20
>>>
>>>
>>>
>>   =20
>>
>>>>> >> Luis Miguel Garc?a <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org> wrote:
>>>>       =20
>>>>
>>>> >
>>>> >
>>>     =20
>>>
>>>>>>> >>> >
>>>>>>> >>> > Andrew Morton wrote:
>>>>>>> >>> >
>>>>>>           =20
>>>>>>
>>>>> >>
>>>>> >>
>>>>       =20
>>>>
>>>>>>>>> >>>> > >
>>>>>>>>               =20
>>>>>>>>
>>>>>> >>>
>>>>>> >>>
>>>>>         =20
>>>>>
>>>>>>>>>>> >>>>> > >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/=
patches/2.6/2.6.2/2.6.2-mm1/
>>>>>>>>>>> >>>>> > >>
>>>>>>>>>>> >>>>> > >>
>>>>>>>>>>> >>>>> > >>
>>>>>>>>>>> >>>>> > >> - Merged some page reclaim fixes from Nick and Nik=
ita.  These yield some
>>>>>>>>>>> >>>>> > >>  performance improvements in low memory and heavy =
paging situations.
>>>>>>>>>>> >>>>> > >>
>>>>>>>>>>> >>>>> > >>
>>>>>>>>>>                   =20
>>>>>>>>>>
>>>>>>> >>>>
>>>>>>> >>>>
>>>>>>> >>> >
>>>>>>> >>> > Andrew, do you know if this acpi pull down has nforce suppo=
rt fixed?
>>>>>>           =20
>>>>>>
>>>>> >>
>>>>> >>
>>>>> >>
>>>>> >> It doesn't appear that way.
>>>>> >>
>>>>       =20
>>>>
>>>> >
>>>> >
>>>     =20
>>>
>>>>>>> >>> > Or perhaps it's even unnotified to the acpi team?
>>>>>>           =20
>>>>>>
>>>>> >>
>>>>> >>
>>>>> >>
>>>>> >> I do not know.  Sending them a bugzilla ID would help, if such a=
 thing exists.
>>>>> >>
>>>>> >>
>>>>> >>
>>>>> >> -------------------------------------------------------
>>>>> >> The SF.Net email is sponsored by EclipseCon 2004
>>>>> >> Premiere Conference on Open Tools Development and Integration
>>>>> >> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
>>>>> >> http://www.eclipsecon.org/osdn
>>>>> >> _______________________________________________
>>>>> >> Acpi-devel mailing list
>>>>> >> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>>>> >> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>>>> >>
>>>>> >>
>>>>       =20
>>>>
>>>> >
>>>> >
>>>     =20
>>>
>>>
>>>
>>> -------------------------------------------------------
>>> The SF.Net email is sponsored by EclipseCon 2004
>>> Premiere Conference on Open Tools Development and Integration
>>> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
>>> http://www.eclipsecon.org/osdn
>>> _______________________________________________
>>> Acpi-devel mailing list
>>> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>>
>>   =20
>>
>
>
> =20
>


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
