From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: IBM R40 FFixedHW register?
Date: Wed, 22 Oct 2003 11:56:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031022095656.GN13989@poupinou.org>
References: <20031021153556.B56816@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031021153556.B56816-Y6VGUYTwhu0@public.gmane.org>
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

On Tue, Oct 21, 2003 at 03:39:55PM -0700, Nate Lawson wrote:
> I'm testing out my new cpu driver for FreeBSD and came across an
> interesting case in supporting Px states.  They work great on several
> laptops but the R40 can't set Px states.  I looked at the ASL and found
> that the control/status register pair is FFixedHW.
> 
>             Return (Package (0x02)
>             {
>                 ResourceTemplate ()
>                 {
>                     Register (FFixedHW, 0x40, 0x00, 0x0000000000000199)
>                 },
> 
>                 ResourceTemplate ()
>                 {
>                     Register (FFixedHW, 0x10, 0x00, 0x0000000000000198)
>                 }
>             }
> 
> I guess I have to find the datasheet for that model to figure out how to
> access those registers.  Anyone come across this before?  What space are
> those actually in (IO, Memory, ??).  The register widths are also strange
> (64 and 16 bits).
> 

They are MSRs for Pentium-M found in Centrino platforms, but acpi spec would
only say you that you have to contact the CPU vendor.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
