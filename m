From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: [PATCH] unneeded memory barrier
Date: Fri, 12 Sep 2003 13:12:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030912111253.GL3944@openzaurus.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A8470255EF0F@orsmsx401.jf.intel.com> <3F60EA55.90008@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3F60EA55.90008-y7mWNqJcIDpfJ/NunPodnw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Felipe W Damasio <felipewd-y7mWNqJcIDpfJ/NunPodnw@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, mochel-3NddpPZAyC0@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >>	Patch against 2.6-test5 to remove an, IMHO, unneeded 
> >>memory barrier 
> >>on acpi/bus.c. Feel free to tell me I'm totally wrong, though :)
> >>
> >>	If it looks good, please consider applying.
> >
> >
> >-		set_current_state(TASK_RUNNING);
> >+		__set_current_state(TASK_RUNNING);
> >
> >My understanding of functions starting with __ was "use them but you
> >better know what you're doing". This patch may be technically correct
> >but does the unneeded barrier really hurt anything? If not then I 
> >think
> >the regular version is ok.
> 
> 	I don't think it hurts in terms of "enforcing ordering too 
> 	much", but that barrier isn't needed at all since it sets the state 
> to TASK_RUNNING...

If setting to TASK_RUNNING never requires barier, I guess some
__builtin_constant and ==TASK_RUNNING check in 
set_task_state is better idea.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
