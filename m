From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI Lock after resume from S3 [2.5.59+latest ACPI]
Date: Thu, 6 Feb 2003 21:47:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030206204719.GU1205@poup.poupinou.org>
References: <3E42AA7A.1030207@alvie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E42AA7A.1030207-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alvaro Lopes <alvieboy-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 06, 2003 at 06:33:30PM +0000, Alvaro Lopes wrote:
> Hi list
> 
> here's the problem:
> 
> My toshiba enters S3 via acpi_enter_sleep_state(). It goes to sleep 
> right after writing PM1A_CONTROL with SLP_ENABLE.  It resumes then to 
> the caller  [acpi_suspend()] and then calls acpi_restore_system_state() 
> and finally acpi_leave_sleep_state().
> 
> The problem is that it enters a deadlock because:
> 
>    1- When setting PM1A_CONTROL with flag ACPI_MTX_LOCK, the hardware 
> mutex is locked, the system enters sleep right after writing the 
> register and never unlocks the mutex, because it resumes to a different 
> point;

Good point.
In fact, I am wondering why we have to acquire the hardware lock at all here.
(We should be the only thread allowed to be scheduled, here.)

> 
>    2- in acpi_leave_sleep_state() we disable BM artbitration, and here 
> it locks forever, waiting a hardware mutex release.

The comment is wrong.  In fact we ensure that BM arbitration is on.

> Disabling APCI_MTX_LOCK on the 1st point seems to go around the problem, 
> and the system resumes almost OK, only HDD DMA is disabled:
> 
> Feb  6 18:19:26 supernova kernel: hda: status timeout: status=0x80 { Busy }
> Feb  6 18:19:26 supernova kernel: hda: DMA disabled
> Feb  6 18:19:26 supernova kernel: hda: drive not ready for command
> Feb  6 18:19:27 supernova kernel: ide0: reset: master: error (0x00?)

Problem with the ide bridge resume path perhaps ?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
