From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: P2120 ACPI 2.5.64bk7
Date: 14 Mar 2003 10:22:50 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1047633770.14099.3.camel@dutidad>
References: <200303130904.03589.listman@garbett.org>
	 <m3znnzp7c9.fsf@pcpenn04.cern.ch> <1047574104.3234.4.camel@dutidad>
	 <ebwy93imhv4.fsf@pcedu3.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <ebwy93imhv4.fsf-e5kh7Nd5fja2ozzinb8jHw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ole Rohne <ole.rohne-vJEk5272eHo@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2003-03-14 at 10:12, Ole Rohne wrote:
> "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org> writes:
> 
> > You POST the Radeon at VT enter... is this a problem during normal (i.e.
> > non resume vt switches) operation? 
> 
> It just takes longer... POSTing on VT enter is certainly not the right
> thing, eventually it should be integrated with the normal X pm (which
> still needs integration with ACPI).

Actually, that's debatable.  A VT switch gets called at suspend/resume
by the existing PM code in anycase.  In addition, one should actually be
able to restore the graphics hardware from any kind of insane state when
switching back to X, so POSTing (or performing some kind of low-level
init) at VT switch back is probably not all that far-fetched.

> > My Radeon dri-resume stuff also does its magic at VT enter, but
> > fortunately does no harm at non-resume switches.
> 
> I haven't tried the DRI stuff - obviously there could be crosstalk, I
> guess getting it right is a matter of doing things in the right order
> and not make assumptions about preserved state across VT switches.

My DRI resume stuff does everything required AFTER mode switch to get
the card back into shape, e.g. reloading of microcode onto the chip,
reconfiguration of the AGP, etc.

> > Did you have any problems waking up your laptop from S3?  Mine goes into
> > standby (power-led flashing) but I can't get it out of that state no
> > matter what I try.
> 
> No, I never had problems waking up... I always had the disk spin up
> and the caps/num/scroll symbols flashing - but that would often be the
> end of it, eg if USB was loaded.

Durn.

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
