From: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Z600 screen restore
Date: Mon, 27 Sep 2004 13:35:43 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <88056F38E9E48644A0F562A38C64FB6002F917C4@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ivor Hewitt <ivor-rtBon1mkn18@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>-----Original Message-----
>From: Ivor Hewitt [mailto:ivor-rtBon1mkn18@public.gmane.org]=20
>Sent: Monday, September 27, 2004 1:06 PM
>To: Pallipadi, Venkatesh
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] Z600 screen restore
>
>On Monday 27 Sep 2004 18:25, Pallipadi, Venkatesh wrote:
>> This is probably the acpid shutting down the system after successful
>> wakeup. As it thinks the button event was for shut down.
>>
>> Check whether you have acpid installed.
>> Check the acpid config file, whether it has anything like this.
>>  event=3Dbutton/power.*
>>  action=3D/sbin/shutdown -h now
>>
>> Comment it if it is there and try again.
>>
>
>No no acpid running.
>
>Also.. the machine isn't shutting down... it's running just=20
>fine. I can type=20
>commands... it's just that the screen isn't powered up... and=20
>commenting=20
>those lines out 'fixes' the problem.
>

OK. Sorry, I didn't read your original mail carefully enough,
before responding.

Actually, commenting those lines is equivalent to passing
"acpi_sleep=3Ds3_bios acpi_sleep=3Ds3_mode". So, even that=20
should work for you.

Thanks,
Venki



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
