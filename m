From: "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: reading files in /proc/acpi hangs machine for a short time
Date: Fri, 25 Jun 2004 23:57:33 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opr95ql7ja4evsfm@smtp.pacific.net.th>
References: <20040625082929.45335181@tethys.solarsys.org> <opr95d74mf4evsfm@smtp.pacific.net.th> <20040625135036.23f487a0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040625135036.23f487a0-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: wwp <subscript-GANU6spQydw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 25 Jun 2004 13:50:36 +0200, wwp <subscript-GANU6spQydw@public.gmane.org> wrote:

> Hello Michael,
>
>
> On Fri, 25 Jun 2004 19:29:54 +0800 "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org> =
wrote:
>
>> On Fri, 25 Jun 2004 08:29:29 +0200, wwp <subscript-GANU6spQydw@public.gmane.org> wrote:
>>
>> > Hi there,
>> >
>> > many acpi programs that show the battery/etc. usage that I tested ar=
e making
>> > my system not to respond for a very short while, but periodically. F=
or
>> > instance, the mouse is being locked for 1/n of a second, which is no=
t a big
>> > loss of performance, but it really damn itchy for a normal (intensiv=
e) usage
>> > of my Dell Inspiron 8200 laptop (kernel 2.4.26). I do remember of so=
me
>> > programs that were not producing such itchyness a long time ago (may=
be
>> > because the kernel things were different?).
>> >
>> > I've found that if I some files from /proc/acpi (let's say battery s=
tate), I
>> > get the same behaviour.
>> >
>> > So my questions are:
>> > - is this a known issue?
>> > - program/kernel/dsdt/what-else issued?
>> > - are there known workarounds?
>> > - is it possible to get the acpi states from another place that /pro=
c (if only it
>> > doesn't show the same problem)?
>> >
>>
>> First figure out whether it is the PM app or ACPI.
>>
>> 1) Disable all PM apps touching /proc/acpi.
>>
>> 2) In a seperate terminal or VT run a script like
>>
>> while :; do cat /proc/acpi/xxx/xxx/what_you_want_to_test > /dev/null; =
usleep 300000; done
>>
>> Example sleeps 300ms (300000us) after every read, try various settings
>>  from as low as 100ms to 10s and see how you system behaves.
>>
>> If you don't have usleep sleep will do in 1s increments...
>>
>> Note also can try cat /proc/acpi/battery/*/*
>>
>> Run it continuously in the background and hopefully the test will show=
 problems
>> due to ACPI proc accesses. If not, the PM  apps are the problem - are =
these running
>> big scripts or impose high system load somehow?
>
> Thanks for your reply :-).
>
> Excepted acpid 1.0.3, no (known) tool is playing with ACPI. When I run
> wmpower/wmacpi or some other ACPI-aware PM tools, or if I do cat
> /proc/acpi/battery/*/* by myself, then I can see the slowlyness (the pe=
riod
> depends on the wmpower refresh rate, or how often I do cat /proc/acpi/.=
..).
>
> Without any of these attempts (wmpower or cat /proc/acpi/...), my syste=
m
> behaves normally. So it seems to me that accessing to files ini
> /proc/acpi/bla/bla from C code or script behaves the same, it slows dow=
n the
> machine for a very short while, because of CPU eating.
>

Should not be like that. I have not encountered it on 2.4

Suggest you file a bug report in kernel bugzilla with details of you HW
so it gets looked into. Get some details of which files cause the problem=
s
using the script and enclose the script as well.

	Regards


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
