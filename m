From: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Subject: Re: Weirdness in arch/i386/kernel/acpi_wakeup.S
Date: Mon, 10 Feb 2003 23:29:25 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302102320580.3580-100000@godzilla.axis.se>
References: <20030210131601.GF25625@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030210131601.GF25625-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 10 Feb 2003, Ducrot Bruno wrote:
> On Mon, Feb 10, 2003 at 01:43:54PM +0100, Bjorn Wesen wrote:
> > The acpi.c code in the same directory insists on wakeup_end - wakeup_start 
> > being less than a page big, but in the .S file, the org statements force 
> > them to be at least 3 pages apart :)  (2.5.59 with latest ACPI patches)
> 
> Simple.  You can have only one physical page allowed for the wakup code.
> If you make something bigger, or point the stack outside, you will
> get memory corruption.

That's what I figured, but since the code was so blatantly wrong in that 
case it seemed more probable that I had missed something :) In the 2.4 
series of the ACPI patches, the org's are at 300 and 400 instead of 2000 and 
3000 I think so that made more sense.

> I have send some time ago a patch to prevent that.  Don't know why
> it is still not included.

Maybe it's in the ACPI cvs. I only checked the .tgz release.

Do you know if the S3 resume code is supposed to work wrgds to video 
restoration ?

/Bjorn




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
