From: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>
Subject: Re: acpi problem with nforce motherboards and ethernet
Date: Thu, 05 Feb 2004 22:27:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4022B55B.1090309@wanadoo.es>
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40229D2C.20701-qokYbnrgTHEgsBAKwltoeQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: David Ford <david+challenge-response-qokYbnrgTHEgsBAKwltoeQ@public.gmane.org>
Cc: akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

David Ford wrote:

> I have the same problem.  I "solved" it a while ago by mucking with=20
> the AGP stuff.  IIRC, it was turning off AGP fast writes or 8x or=20
> something similar in cmos.  Went from incredibly broken to stable=20
> instantly.  I'll check my cmos settings in a bit and refresh my memory.
>
> What patches are you using?


I'm using nforce2-apic.patch and nforce2-disconnect-quirk.patch that=20
Andrew Morton have sent to me. I think they have been included in=20
previous mm kernels but now are droped because they caused some=20
temperature problems for some people with no nforce motherboards.

If you want it, I can send it to you.

By the way, is anyone involved in solving the IO-APIC thing in nforce=20
motherboards? Anyone trying a different approach? Anyone contacting=20
nvidia about this problem?


> p.s. reiserfs is pretty useless against crashes.  hundreds of files=20
> around the harddrive get messed up everytime the machine locks=20
> up...files that haven't been used in weeks, as well as files opened=20
> read-only, i.e. libraries.

I don't think this could be a reiserfs problem, because all the computer=20
gets frezzed and locked, but perhaps someone at Namesys can realize why=20
files gets deleted all over the hard disc.



Thanks.

Luis Miguel Garcia


>
> p.s. reiserfs is pretty useless against crashes.  hundreds of files=20
> around the harddrive get messed up everytime the machine locks=20
> up...files that haven't been used in weeks, as well as files opened=20
> read-only, i.e. libraries.
>
> Luis Miguel Garc=EDa wrote:
>
>> (sorry with my sucking english)
>>
>> ok, let me know if you know for me to test something with this newer=20
>> mm kernels.
>>
>> by the way, yes, I'm experiencing the lockups. Not with heavy io, but=20
>> almost when I boot and enter X. The system gets completly frozzened=20
>> and the HD led keps on. When I reboot with a sane kernel, I found=20
>> several files from my /home directory are deleted or filled with=20
>> garbage.
>>
>> Now, I patch each kernel I use with the two patches Andrew sent to me=20
>> and I'm having no problems.
>>
>> Actually i'm running 2.6.2-ck1 + nforce-patches and the temperature=20
>> of the system is 55=BA while idle, and 631 while compiling (only cpu=20
>> fan, no case fans). I don't know if it's high (some people reported=20
>> high temperatures with this patches) but it runs very well this way.
>>
>> If you want for me to test some patches or something, please drop me=20
>> a note.
>>
>> Thanks a lot...
>>
>> Luis Miguel Garc=EDa
>>
>> P.S.: by the way, why am I getting strage "arabesque" characters when=20
>> I reply to your emails? Perhaps something with wrong encoding?
>>
>>> This is interesting, I will test it myself later on. At one point Len
>>> admitted to owning "foreign hardware :p" so maybe this could get=20
>>> resolved.
>>>
>>> Personally I haven't tried kernels with newer forcedeth drivers,=20
>>> because I
>>> can no longer explicitely set the power state of the NIC to D3. The
>>> machine complains about irqs (new debugging code since forcedeth=20
>>> v.20 or
>>> so) and will not powerdown.
>>>
>>> On another note, have you noticed lockups of your system with heavy i=
o?
>>> Think of fsck'ing, burning cdroms, du on large dirs etc? Maybe it is
>>> helpful to set up a list of boards and document what works or=20
>>> doesn't work
>>> with which kernel. For instance the lockups with heavy io seem to be
>>> resolved here if I leave APIC from my kernel.
>>>
>>> Arjen
>>>
>>> On Thu, 5 Feb 2004, [ISO-8859-15] Luis Miguel Garc?a wrote:
>>>
>>> =20
>>>
>>>>> Hi:
>>>>>
>>>>> Since Andrew Morton picked up latest acpi bk updates, nforce=20
>>>>> motherboards have problems, mainly with ethernet adapters.=20
>>>>> Reporters say that with acpi=3Doff, the problm gets fixed, so we=20
>>>>> think the problem could be acpi. Some more useful info:
>>>>>
>>>>>
>>>>>
>>>>> On Tue, 3 Feb 2004, [ISO-8859-1] Luis Miguel Garc?a wrote:
>>>>>
>>>> =20
>>>>
>>>>>>> >> When I try to boot with latest mm series (such as actual=20
>>>>>>> rc3-mm1 or
>>>>>>> >> rc2-mm2), my nforce ethernet device doesn't works. It worked=20
>>>>>>> in the past
>>>>>>> >> with the forcedeth reverse engineered driver but now it keeps=20
>>>>>>> for 30 or
>>>>>>> >> more seconds halted (at boot) and then the network device=20
>>>>>>> dosn't run.
>>>>>>> >>
>>>>>>> >> Here is the dmesg of rc3-mm1. Do you want for me to test=20
>>>>>>> something? Thanks!
>>>>>>> >>
>>>>>>> >> P.S.:   The ACPI related messages are larger that in rc3.
>>>>>>
>>>>>>
>>>>>   =20
>>>>> My e100 on an nforce2 won't work in rc3-mm1.
>>>>> The "acpi=3Doff" boot parameter makes it go.
>>>>>
>>>>>
>>>>> And for the record, I can boot with that kernel and save one dmesg=20
>>>>> for you if you want. Only send me a request and I'll send it to you.
>>>>>
>>>>> P.S.: Sent any messages you want directly to me as i'm not=20
>>>>> subscribed to acpi-devel.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Luis Miguel Garc?a
>>>>>
>>>>>
>>>>>
>>>> =20
>>>>
>>>>>> >Which part of nforce support are you talking about luis?
>>>>>
>>>>
>>>>>> >On Thu, 5 Feb 2004, Andrew Morton wrote:
>>>>>
>>>> =20
>>>>
>>>>>>> >> Luis Miguel Garc?a <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org> wrote:
>>>>>>
>>>>>
>>>>>>>>> >>> >
>>>>>>>>> >>> > Andrew Morton wrote:
>>>>>>>>> >>> >
>>>>>>>>
>>>>>>> >>>>> > >>=20
>>>>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6=
.2/2.6.2-mm1/=20
>>>>>>>
>>>>>>>
>>>>>>>>>>>>> >>>>> > >>
>>>>>>>>>>>>> >>>>> > >>
>>>>>>>>>>>>> >>>>> > >>
>>>>>>>>>>>>> >>>>> > >> - Merged some page reclaim fixes from Nick and=20
>>>>>>>>>>>>> Nikita.  These yield some
>>>>>>>>>>>>> >>>>> > >>  performance improvements in low memory and=20
>>>>>>>>>>>>> heavy paging situations.
>>>>>>>>>>>>> >>>>> > >>
>>>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> >>> >
>>>>>>>>> >>> > Andrew, do you know if this acpi pull down has nforce=20
>>>>>>>>> support fixed?
>>>>>>>>
>>>>>>>
>>>>>>> >>
>>>>>>> >> It doesn't appear that way.
>>>>>>> >>
>>>>>>
>>>>>  =20
>>>>>
>>>>>>>>> >>> > Or perhaps it's even unnotified to the acpi team?
>>>>>>>>
>>>>>>>
>>>>>>> >>
>>>>>>> >> I do not know.  Sending them a bugzilla ID would help, if=20
>>>>>>> such a thing exists.
>>>>>>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
