From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: bug report: multi-byte access in indexfields broken
Date: Mon, 22 Sep 2003 16:02:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030922140256.GK11391@poupinou.org>
References: <20030921200525.GB2968@krikkit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030921200525.GB2968-duT3ICHXG/I@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Robert Vollmert <rvollmert-lists-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Sep 21, 2003 at 10:05:25PM +0200, Robert Vollmert wrote:
> Hello,
> 
> it appears the problems I mailed about earlier are due to a bug in the
> ACPI code. Reading from multi-byte fields in a ByteAccess-IndexField
> seems to be broken.
> 
> When I replace
> 
> IndexField (EIND, EDAT, ByteAcc, NoLock, Preserve)
> {
>     Offset (0x10), 
>     IKFG,   8, 
>     FRPN,   16, 
>     RAMB,   32,
>     AVOL,   8, 
> ...
> }
> 
> Method (CRMB, 0, NotSerialized)
> {
>     Return (RAMB)
> }
> 

After some testing, I found that this bug happens with word access
as well, and only when the field is not aligned with 8 (in case
of dword), which do not make sence as a buggy ASL due to the ByteAcc.

I consider that bug being critical.  I'm not sure if that happens for
other types other than Index one (that piece of code being shared between
4 kind of OR).

Anyway, most of use done by IndexField is to access CMOS data.  I prefer
not to think what happens if a write is done, and if the write is buggy
as well.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
