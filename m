From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: can't switch CPU frequency while running on batterypower
Date: Wed, 7 Jan 2004 16:55:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040107155520.GP14031@poupinou.org>
References: <20040106103944.Q26693@root.org> <32785.192.168.36.2.1073420997.squirrel@defiant.homedns.org> <20040106133725.E27491@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040106133725.E27491-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: Defiant <mail-4AGA6j5e2AhmdDG0eupGX0B+6BGkLq7r@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 06, 2004 at 01:39:44PM -0800, Nate Lawson wrote:
> On Tue, 6 Jan 2004, Defiant wrote:
> > Nate Lawson wrote:
> > > This is most likely a problem with re-evaluation of _PSS after it has been
> > > changed.  I don't remember if Linux uses the notify on the processor
> > > object to re-evaluate _PSS.  If Linux does this correctly, it may be that
> > > the underlying firmware has a bug and you should use a more specific
> > > cpufreq driver (i.e. SpeedStep or whatever).  Some systems have a problem
> > > where they don't properly export firmware information to the ACPI
> > > performance states interface.
> >
> > uhm, I don't know why, but it is working now, using
> > CONFIG_X86_P4_CLOCKMOD instead of CONFIG_X86_SPEEDSTEP_ICH, even it is a
> > Pentium 4m, not Pentium 4.
> 
> Sure.  In general, it's better to use a hw-specific cpufreq driver instead
> of the generic ACPI one, even if the latter seems to work.  Many chipsets
> don't export the hw-specific information to ACPI correctly and thus ACPI
> performance states cpufreq should be a last resort.  If they still don't
> work, you should try multiple hw-specific drivers, as you did.
> 

What is strange though is that speedstep-ich is a non-acpi driver.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
