From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: RE: Store(Local0, Local0) behavior?
Date: Fri, 3 Oct 2003 18:01:36 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031003180107.Y92654@root.org>
References: <D3A3AA459175A44CB5326F26DA7A189C1C3DD6@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <D3A3AA459175A44CB5326F26DA7A189C1C3DD6-sBd4vmA9Se58QrAoInS571DQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thank you!  Here's a snippet of ASL from my BP6:

Scope(\_SI_) {
    Method(_MSG, 1) {
        Store(Local0, Local0)
    }

-Nate

On Fri, 3 Oct 2003, Moore, Robert wrote:
> I will re-address this issue (in the case where Local0 is
> uninitialized.)
>
> -----Original Message-----
> From: Nate Lawson [mailto:nate-Y6VGUYTwhu0@public.gmane.org]
> Sent: Monday, September 29, 2003 12:50 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: Moore, Robert
> Subject: Store(Local0, Local0) behavior?
>
> Sometime around 0619, executing an opcode of Store(Local0, Local0)
> started
> generating an error instead of just being a no-op.  In reading the 2.0b
> spec, there is no evidence that this is an illegal operation.  Could
> someone restore the previous behavior?  What part of ACPICA handles the
> Store opcode?
>
> -Nate
>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
