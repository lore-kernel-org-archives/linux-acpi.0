From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: /proc/battery empty on Gateway 400VTX
Date: Wed, 8 Oct 2003 12:01:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031008100137.GE11391@poupinou.org>
References: <Pine.LNX.4.44.0310071538370.24003-301000@data.upl.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310071538370.24003-301000-j0XSImJ06nG869pVMd/zofZ8FUJU4vz8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Casey Harkins <charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 07, 2003 at 04:04:11PM -0500, Casey Harkins wrote:
> 
> Looking for help with getting ACPI battery monitoring to work on this
> laptop. I'm running SourceMage GNU/Linux with:
> 
> 	vanilla linux 2.4.22
> 	acpi 20030916 patch for 2.4.22
> 	dsdt-initrd patch v0.3 for 2.4.22
> 
> All other acpi functions seem to work (haven't tried suspending). Nothing
> is reported when the battery module loads (it is being loaded between the
> ac_adapter and button modules) and the /proc/battery directory exists but
> is empty.
> 
> I tried dumping and fixing the dsdt. There was only 1 warning:
> 
>    dsdt.asl   281: Method(_WAK, 1) {
>    Warning  2026 -           ^ Reserved method must return a value (_WAK)
> 
> I fixed this according to Richard Black's HOWTO and loaded it via the
> initrd method using the dsdt-initrd patch listed above, though it seemed
> to have no effect on the system.
> 

Are you sure you have compiled embedded controller *not* as a module?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
