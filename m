From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: RE: suspend.c vs driver-model.txt
Date: Mon, 29 Jul 2002 15:50:29 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0207291542260.22697-100000@cherise.pdx.osdl.net>
References: <59885C5E3098D511AD690002A5072D3C07990D78@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C07990D78-OU+JdkIUtvcLll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> linux-pm-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org was created to have a non-ACPI-specific PM
> forum. Nobody has used that, but it's there, and I'm subscribed just in case
> anyone does. ;-)

Yeah, it's been kinda dead for a while. Splinter mail lists always fizzle 
out, probably because coming up with the design always gets preempted by 
doing real work. ;)

> People interested in other arches need to step up and make sure their
> platform's requirements are met. Failing that, IA32 is the HW that most
> people have so that's what is going to be mde to work first. Linux itself
> was not a cross-platform OS from day one -- the generalization came later.

I love these arguments of yours; I get a big kick out of them. Like your 
defense of "premature optimization is the root of all evil." Sure it is, 
but that's no excuse to write inefficient algorithms. 

Just like it's no excuse to create a general scheme based on one platform. 
c.f. the original Linux Driver Model that you guys posted one year ago. 
That is the epitome of my argument. I'm not worked up about it, but you 
guys have done that kinda stuff more than you should, and I'm glad you're 
in the business of designing general APIs any more. 

> The only criticism I have is that driverfs etc. has grown to be much more
> than PM. I know you've been working with Greg, but it's still too much,
> IMHO. -EPLATEFULL, indeed.

driverfs was never about PM. It was about exposing kernel infrastructure 
to userspace. I gave you the device tree and power management hooks first. 
I apologize that I have not had a chance to follow through and actually 
implement the hooks for the drivers, but there turned out to be a lot more 
cool stuff to play with.. :)

	-pat



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
