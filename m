From: Stephen L Johnson <sjohnson-WpdXj7kV/NVg9hUCZPvPmw@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: 07 Sep 2002 00:02:13 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1031374944.1530.44.camel@rodan.monsters.org>
References: <Pine.LNX.4.44.0209061411390.1021-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0209061411390.1021-100000-yZQdDDOm3n9ZQn2sFP3R7eTW4wlIGRCZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "'P. Christeas'" <p_christ-U04EIuiosng@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2002-09-06 at 16:40, Patrick Mochel wrote:
> 
> On Fri, 6 Sep 2002, Pavel Machek wrote:
> 
> > Hi!
> > 
> > > Right now I am leaning towards no. We don't have a runlevel for APM's
> > > suspend, why would we for ACPI sleep?
> > 
> > I believe we should have it for APM, too.
> > 
> > umounting nfs seems like good idea, and no ammount of drivers will fix that.
> >
> > > I think we'll know better once we have working device power management if a
> > > new runlevel is needed or not.
> > 
> > I believe 3 of them are needed - S1, S3 and S4. 
> 
> I agree that we need to do some amount of user-level work before we go to 
> sleep, but I'm not sure that a runlevel is the proper way to implement it. 
> 
> Unless you implemented a new runlevel for every possible sleep state for 
> every possible platform suspend mechanism, how would pass what suspend 
> state you wanted to enter? 
> 
> You don't really want to have a different one for S1, S3, and S4 because 
> they are ACPI specific, both in terms of their names and what they mean. 
> I don't think you could create a clean, sensible solution like that, that 
> worked for all platforms...
> 
> You could have one runlevel, and pass the state we're entering somehow. 
> But, we would need to get that from init(8) to reboot(2) [1]. That way we 
> could use standard rc scripts for doing all the dirty little things we 
> need to before we sleep. 
> 

Hi all. I'm new to the list.

I've been involved with the Linux on PDAs/handheld computers over at
http://www.handhelds.org/. They have to deal with the exact same issues
suspend/resumes issues with drivers and user-space issues. Although they
major concern is just with suspending in memory.

Over the past several versions of Familiar (a linux distrubution for
handhelds) a method for dealing with user space suspend and resume
issues have been developer. It is working quite well. 

The kernel calls a user space program called pmhelper with a "suspend"
or "resume" parameter. On a suspend, pmhelper is called before the
kernel  suspends the drivers. And on a resume it's called after the
kernel resumes the drivers. 

The pmhelper program on familiar calls a series of scripts in
/etc/suspend-scripts/ or /etc/resume-scripts/ (depending on the pending
state). The scripts are run in a SysV boot-script way. The scripts are
named nnScriptName where nn are numbers. 

I'm sure that this pmhelper/scripts method could easily be adapted for
ACPI/APM usage. Just my .02 cent.

--
Stephe L Johnson <sjohnson-WpdXj7kV/NVg9hUCZPvPmw@public.gmane.org>




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
