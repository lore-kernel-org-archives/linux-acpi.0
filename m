From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] Stall semantics
Date: Tue, 30 Sep 2003 15:04:35 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D3A3AA459175A44CB5326F26DA7A189C1C3DAF@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I'm questioning whether it is appropriate to *ever* call sleep since
this behavior seems to violate the spec.


-----Original Message-----
From: Nate Lawson [mailto:nate-Y6VGUYTwhu0@public.gmane.org]=20
Sent: Tuesday, September 30, 2003 2:45 PM
To: Moore, Robert
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: RE: [ACPI] [PATCH] Stall semantics

On Tue, 30 Sep 2003, Moore, Robert wrote:
> The ACPI spec says this:
>
> 16.2.3.4.1.15  Stall (Stall for a Short Time)

Yes, this is what I was referring to.

> StallTerm	:=3D Stall(
> 	MicroSecs	//TermArg=3D>Integer
> )
> The Stall term is used to implement short-term timing requirements.
> Execution is delayed for at least the required number of microseconds.
> The implementation of Stall is OS-specific, but must not relinquish
> control of the processor. Because of this, delays longer than 100
> microseconds must use Sleep instead of Stall.
-----
>
> This seems to imply that sleep() cannot be used to implement long
> "stalls" because it can relinquish the cpu.

Please read the patch and the last sentence you quoted from the spec.
Your code already calls Sleep instead of Stall for values > 1000 us.  I
simply made it stick to the spec of > 100 us.

-Nate


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
