From: =?iso-8859-1?Q?Emmanuel_Thom=E9?= <Emmanuel.Thome-/zGXu1G9BXs@public.gmane.org>
Subject: Re: Dell D600: teaching radeonfb how to wake up...
Date: Fri, 21 Nov 2003 15:35:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031121153535.B19564@loria2.loria.fr>
References: <20031119180119.GB22307@tate.loria.fr> <yzo1xs3ijgr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <yzo1xs3ijgr.fsf-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>; from ole.rohne-vJEk5272eHo@public.gmane.org on Thu, Nov 20, 2003 at 08:32:04AM +0100
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Then you've hacked the thing way further than its current state, at
least... Would you mind sharing your code ?

E.

On Thu, Nov 20, 2003 at 08:32:04AM +0100, ole.rohne-vJEk5272eHo@public.gmane.org wrote:
> I've done similar exercises on my Fujitsu P2120 (it's an M6), and I
> concluded that the card needed to go through the BIOS POST sequence,
> but for some reason s3_bios cannot be used. I tried backporting the
> powerbook code, with no result except a hanging computer. I suspect
> even ATI docs wouldn't help as they "provide" the BIOS for this
> purpose.
> 
> I eventuall hacked it using the vm86 emulator that comes with XFree86,
> plugging in a call to BIOS POST when switching virtual console; kind
> of ugly but it worked. I think I also needed some PCI hackery in the
> radeonfb resume code, not sure if that made it back into the 2.6.0
> kernel. I haven't been able to play with it at all lately as my
> machine reboots on S3 resume with recent kernels.
> 
> Regards, Ole


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
