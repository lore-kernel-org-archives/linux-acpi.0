From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: AML disassembler questions.
Date: Thu, 8 Aug 2002 12:50:25 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B6D0@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: 'Ducrot Bruno' <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Black, Richard" <Richard.Black-VXdhtT5mjnY@public.gmane.org>, "KOCHI, Takayoshi" <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Go ahead and try the disassembler in iASL.  I know for a fact that it
disassembles lots of files that AD chokes on.

Bob


-----Original Message-----
From: Ducrot Bruno [mailto:ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org]
Sent: Thursday, August 08, 2002 3:09 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Black, Richard; KOCHI, Takayoshi
Subject: [ACPI] AML disassembler questions.


Hi all.

Since Phoenix seems to not support anymore their disassembler, I am
wondering which tools we can use for this purpose.

For now, we can use :

- the pacpidump tool, made by a FreeBSD guy, which compile cleanly under
Linux,
- the new option '-d' of iasl.

pacpidump seems for me to be OK, but it was written for F-BSD.  For
me, it is not a real problem, because I use sometime a FBSD-current.
I think, though, that some debugging, etc. was made, but this is only
present for the current version of acpidump under FBSD-current,
not the one we can have under Linux.  For example, it lack the output
of the RessourceTemplate (should be ok, though, only a 'cosmetic' change,
but for debugging purpose, it is somewhat needed), but under F-BSD, it
was added (with an option).

iasl, as a disassembler, should be OK.  As stated by the change log, it
was tested intensively.  But it have perhaps some little bugs that
have to be discovered, since this feature seems to be only added the
last month.

Good day,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
