From: Alex Riesen <fork0-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: 2.6.0-test3+bk: ACPI does not switch off the computer
Date: Sun, 24 Aug 2003 10:10:08 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030824081008.GA986@steel.home>
References: <20030822062945.GA1128@steel.home> <Pine.LNX.4.44.0308240832530.4017-100000@localhost.localdomain>
Reply-To: Alex Riesen <fork0-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308240832530.4017-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Aschwin Marsman <aschwin-FqKuKZ2d1upAfugRpC6u6w@public.gmane.org>
Cc: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Aschwin Marsman, Sun, Aug 24, 2003 08:35:52 +0200:
> On Fri, 22 Aug 2003, Alex Riesen wrote:
> > Actually it started happening from -test3.
> > The last I see on screen is "Power down." and the system is halted.
> > CAD reboots it.
> 
> The latest acpi disables acpi for all bioses before Januari 1st 2001,
> I have the same problem with 2.4.22-rc3. It was "solved" by adding:
> acpi=force
> to my kernel boot parameters. In /var/log/messages this hint is
> given if that's the case.
>  

Thank you, this is indeed the case. Somehow I didn't notice the messages
in the syslog.

Can't say I like that decision: acpi always worked here, at least as far
as power off was concerned.
May it make sense to let the parts working for every vendor enabled?

P.S. Motherboard is ASUS CUV4X, Via Apollo PRO133Z.




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
