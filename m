From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ASL fixing questions
Date: Thu, 12 Feb 2004 22:26:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040212212649.GX13262@poupinou.org>
References: <402AF9FF.3020706@zopatista.com> <20040212093732.GP13262@poupinou.org> <402B9313.9000701@zopatista.com> <402BAABC.5040706@zopatista.com> <20040212204335.GU13262@poupinou.org> <402BE889.5090502@zopatista.com> <402BEE34.9050908@zopatista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <402BEE34.9050908-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Martijn Pieters <mj-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 12, 2004 at 04:20:52PM -0500, Martijn Pieters wrote:
> Martijn Pieters wrote:
> >Not enough experience with hand disassembly, that is. That is me not 
> >realizing that the bytes are in the other order. And that 0E is my typo.
> >
> >iasl just refuses to disassemble the SSDT table, maybe because 
> >\_SB._PR.CPU0 should be declared an external?
> 
> Make that \_PR.CPU0.
> 
> Attached a cleaned up version where I also used another font on khexedit 
> to avoid mistaking 'B' for '8'.
> 
> Now I only still have questions about the other errors in the DSDT in my 
> earlier emails.
> 
> Martijn

Make much more sens now.  Or else the powernow-acpi patch I send this
week to the cpufreq mailing list will be broken ;)

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
