From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: suspend.c vs driver-model.txt
Date: Wed, 24 Jul 2002 12:43:13 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <59885C5E3098D511AD690002A5072D3C07990D78@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: 'Patrick Mochel' <mochel-3NddpPZAyC0@public.gmane.org>, Lyle <lwspm-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Patrick Mochel [mailto:mochel-3NddpPZAyC0@public.gmane.org] 

> The ACPI code that is in there is relatively close. I did 
> that on purpose, 
> thinking that this stuff will be generalized someday. 
> However, whatever 
> end solution that exists _must_ not be designed the behavior 
> of ACPI. In 
> fact, I am hesitant talking about this general model on this 
> list for fear 
> that someone that is already brainwashed by the Great 
> Firmware Abomination 
> will say either "We can already do this!" or "I'll do it (in 
> ACPI first 
> and generalize it)." 

linux-pm-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org was created to have a non-ACPI-specific PM
forum. Nobody has used that, but it's there, and I'm subscribed just in case
anyone does. ;-)

People interested in other arches need to step up and make sure their
platform's requirements are met. Failing that, IA32 is the HW that most
people have so that's what is going to be mde to work first. Linux itself
was not a cross-platform OS from day one -- the generalization came later.

> <harshness>
> The ACPI subsystem has a tendency to duplicate existing 
> interfaces, or 
> come up with completely new ones, intending to be applicable 
> to the rest 
> of the kernel. The are highly ACPI-centric, yet they expect 
> them to be 
> standard. They aren't publicized or discussed on any list but 
> this one. 
> But, they're left to be fixed up and cleaned up by the other 
> people in the 
> community. 

I agree that any time ACPI can use an existing interface over defining a new
one that's good, but for a lot of things existing interfaces didn't exist.
In 2.5 we now are starting to see std interfaces for device enum (thanks to
you) and processor performance control (the cpufreq project) but thermal,
battery, etc do not yet have arch-neutral interfaces for ACPI to plug into.
Are these the interface you are referring to, or different ones?

> I refuse to lay blame on anyone for my inability to work 
> faster or harder. 
> But, a lot of people complain that I've been working on this 
> for a year, 
> and they still can't suspend their laptop. My rebuttal is 
> that if I had 
> actually gotten cooperation and compromise at the source 
> level, in many 
> areas, we probably wouldn't still be dealing with this. 

If anyone complains about the lack of progress then they don't understand
the scope of the work. I think *that* is why we're not there yet, instead of
a lack of cooperation.

The only criticism I have is that driverfs etc. has grown to be much more
than PM. I know you've been working with Greg, but it's still too much,
IMHO. -EPLATEFULL, indeed.

> So, someone needs to do it. I don't have time. And, I don't 
> trust anyone 
> related to ACPI to do it right (except maybe Andy in a 
> different context, 
> but he's overworked as it is). 

Ben sounds willing. ;-)

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
