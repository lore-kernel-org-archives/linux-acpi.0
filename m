From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: 2.6.0-test9 regression: panic on Fn+F7 hotkey
Date: Mon, 3 Nov 2003 12:10:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031103111004.GC21970@poupinou.org>
References: <20031027170800.GC11206@hell.org.pl> <3FA621EC.5010000@pca.it> <20031103105802.GB909@wsc-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031103105802.GB909-u75qzGzWA6cb1SvskN2V4Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nikolaus Filus <filus-u75qzGzWA6cb1SvskN2V4Q@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 03, 2003 at 11:58:03AM +0100, Nikolaus Filus wrote:
> On Mon, Nov 03, 2003 at 10:37:48AM +0100, Luca Capello wrote:
> >Hello, maybe it could be useful even if the thread is (quite) old.
> >
> >on 10/27/03 18:08, Karol Kozimor wrote:
> >>Pressing Fn+F7 to turn the LCD on / off causes 2.6.0-test9 to panic.
> >I've an ASUS Centrino M3N, bios 0203A (20030514), Debian 
> >testing/unstable, kernel 2.6.0-test9 w/ ACPI 20031002. When I press 
> >Fn+F7 the LCD correctly switchs on/off and I don't have any kernel panic.
> >
> >Just you to know :-)
> 
> 
> BTW: Is this a general ACPI feature or BIOS-related? I mean, I have a
> Toshiba Satellite 3000-601 and was NEVER able to switch to/from external vga
> using linux (no 2.4 and no 2.6 version!). The display freezes, the fan goes
> on and that was it .... :(
> 

That depend.  For the Satellite 3000-601, this is even the two:
the toshiba will got an acpi event from the embeded controller
and the portion of the AML related to will call a smi handler...

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
