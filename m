From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] Don't disable interrupts during EC access
Date: Wed, 17 Nov 2004 15:46:48 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC08B@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Spec defined EC-SCI is edge-trigged.
So, I think that is solution sticking with Spec.
Not sure, how many laptop break this rule.

If  wait_event_interruptible_timeout  returns due to timeout,
Can we think it of polling timeout?

So, I suggest Dmitry to complete  that to include
level-trigged situation.

Thanks
Luming=20

>-----Original Message-----
>From: Li, Shaohua=20
>Sent: 2004=C4=EA11=D4=C217=C8=D5 15:10
>To: Dmitry Torokhov; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Cc: Andi Kleen; Yu, Luming; Matthew Wilcox; Fu, Michael;=20
>Brown, Len; Moore, Robert
>Subject: RE: [ACPI] [PATCH] Don't disable interrupts during EC access
>
>>On Tuesday 16 November 2004 10:37 am, Andi Kleen wrote:
>>> > For detail, please refer to ACPI spec :
>>> > 12 ? ACPI Embedded Controller Interface Specification.
>>>
>>> Ok. But the problem is not the actual write, but the waiting
>>> for the event which takes extremly long on these machines
>>> (it's not a single broken machine, but has been observed
>>> on several VIA based laptops). Would it work to only disable
>>> interrupts during the register write/read, but not during the
>>> polling delay?
>>
>>Actually, the proper solution would be to get rid of polling entirely,
>>like in the patch below. Could anyone with a box with EC verify that
>>it works?
>>
>>Btw, what's up with initializing every variable in ACPI code? It is
>>not free after all...
>>
>I agree the right solution should be to stop polling, but did=20
>you look at the comments in ec.c (line 361)? It said some=20
>systems can't work with asynchronous mode.
>
>Thanks,
>Shaohua
>


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
