From: Aschwin Marsman <aschwin-FqKuKZ2d1upAfugRpC6u6w@public.gmane.org>
Subject: Re: 2.6.0-test3+bk: ACPI does not switch off the computer
Date: Sun, 24 Aug 2003 10:39:54 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0308241035260.2402-100000@localhost.localdomain>
References: <20030824081008.GA986@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030824081008.GA986-w0aEEaBvYVdBDLzU/O5InQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Riesen <fork0-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Aschwin Marsman <aschwin-FqKuKZ2d1upAfugRpC6u6w@public.gmane.org>, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 24 Aug 2003, Alex Riesen wrote:

> Aschwin Marsman, Sun, Aug 24, 2003 08:35:52 +0200:
> > On Fri, 22 Aug 2003, Alex Riesen wrote:
> > > Actually it started happening from -test3.
> > > The last I see on screen is "Power down." and the system is halted.
> > > CAD reboots it.
> > 
> > The latest acpi disables acpi for all bioses before Januari 1st 2001,
> > I have the same problem with 2.4.22-rc3. It was "solved" by adding:
> > acpi=force
> > to my kernel boot parameters. In /var/log/messages this hint is
> > given if that's the case.
> >  
> 
> Thank you, this is indeed the case. Somehow I didn't notice the messages
> in the syslog.
> 
> Can't say I like that decision: acpi always worked here, at least as far
> as power off was concerned.

I totally agree, but then again, I don't know the details.

> May it make sense to let the parts working for every vendor enabled?
> 
> P.S. Motherboard is ASUS CUV4X, Via Apollo PRO133Z.

My motherboard is a ASUS CUBX-L, Intel 440BX, I only use powerdown (that 
I'm aware of).
 
Have a nice weekend.
 
Aschwin Marsman
 
--
aschwin-FqKuKZ2d1upAfugRpC6u6w@public.gmane.org              http://www.marsman.org



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
