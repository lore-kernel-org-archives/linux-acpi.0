From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: ACPI source patches updated (20021101)
Date: Mon, 4 Nov 2002 13:17:51 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B8BE@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Jan Rychter' <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Jan,

We have discovered a possible situation where an Acquire() with an infinite
wait (0xFFFF) could in fact timeout without obtaining the mutex.  This may
be the root of the problem you are seeing.

Andy is preparing a patch.
Bob


-----Original Message-----
From: Jan Rychter [mailto:jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org] 
Sent: Sunday, November 03, 2002 3:31 AM
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Subject: [ACPI] Re: ACPI source patches updated (20021101)

I wrote:
> I could then gather the information that Bob and Andy requested,
> necessary to fix the issues with thermal management on my machine.
> 
> Andy, Bob, here's the name of the mutex that causes problems:
> 
>     ACPI-0242: *** Error: Thread 61D cannot release Mutex [MEC0] acquired
by thread 6FE
>     ACPI-1154: *** Error: Method execution failed, AE_AML_NOT_OWNER
>     ACPI-0815: *** Error: AE_AML_NOT_OWNER while evaluating GPE18 method
>     ACPI-0242: *** Error: Thread 73F cannot release Mutex [MEC0] acquired
by thread 44B
>     ACPI-1154: *** Error: Method execution failed, AE_AML_NOT_OWNER
>     ACPI-0815: *** Error: AE_AML_NOT_OWNER while evaluating GPE18 method
>     ACPI-0242: *** Error: Thread 743 cannot release Mutex [MEC0] acquired
by thread 44B
>     ACPI-1154: *** Error: Method execution failed, AE_AML_NOT_OWNER
>     ACPI-0815: *** Error: AE_AML_NOT_OWNER while evaluating GPE18 method
>     ACPI-0242: *** Error: Thread 744 cannot release Mutex [MEC0] acquired
by thread 44B
>     ACPI-1154: *** Error: Method execution failed, AE_AML_NOT_OWNER
>     ACPI-0815: *** Error: AE_AML_NOT_OWNER while evaluating GPE18 method
[...]

To follow up, I get the following at bootup if the fan runs when the box
is booted:

[...]
    ACPI-0226: *** Error: Cannot release Mutex [MEC0], not acquired
    ACPI-1154: *** Error: Method execution failed, AE_AML_MUTEX_NOT_ACQUIRED
    ACPI-1154: *** Error: Method execution failed, AE_AML_MUTEX_NOT_ACQUIRED
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN1] (off)
ACPI: Fan [FAN2] (off)
ACPI: Fan [FAN3] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (55 C)
[...]

Maybe this will help.

--J.


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
