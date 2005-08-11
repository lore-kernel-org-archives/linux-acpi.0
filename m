From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Acer battery problem
Date: Thu, 11 Aug 2005 08:30:54 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8409172ED4@pdsmsx403>
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
To: Pablo Bullian <pablo.bullian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Please try 2.6.13-rc6 and option ec_burst=3D1
The patch at http://bugzilla.kernel.org/show_bug.cgi?id=3D3851=20
could help.

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Pablo Bullian
>Sent: 2005=C4=EA8=D4=C211=C8=D5 8:13
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] Acer battery problem
>
>no one can help me with that???
>
>On 8/8/05, Pablo Bullian <pablo.bullian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi!, well I'm new here, and i have a problem i bought a Acer Aspire
>> 3002LCi and I install a Mandrake or Mandriva 10.1, the thing is that
>> my Xserver don't work if I use the laptop with the battery, it frezze
>> when it start, and also my battery monitor doesn't work if i have the
>> laptop plugged in, otherwise, like i said before it doesn't start X.
>> when I put:
>> # cat /proc/acpi/battery/BAT1/state
>> present:                 yes
>> ERROR: Unable to read battery status
>>=20
>> the info is:
>> # cat /proc/acpi/battery/BAT1/info
>> present:                 yes
>> design capacity:         2000 mAh
>> last full capacity:      1798 mAh
>> battery technology:      rechargeable
>> design voltage:          14800 mV
>> design capacity warning: 200 mAh
>> design capacity low:     71 mAh
>> capacity granularity 1:  32 mAh
>> capacity granularity 2:  32 mAh
>> model number:            11ZL
>> serial number:           3027
>> battery type:            LION
>> OEM info:                SIMPLO
>>=20
>> can someone help me? :(
>>
>
>
>-------------------------------------------------------
>SF.Net email is Sponsored by the Better Software Conference & EXPO
>September 19-22, 2005 * San Francisco, CA * Development=20
>Lifecycle Practices
>Agile & Plan-Driven Development * Managing Projects & Teams *=20
>Testing & QA
>Security * Process Improvement & Measurement *=20
>http://www.sqe.com/bsce5sf
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
