From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Via 694X based SMB boards (Apollo Pro133A)
Date: Thu, 15 Jan 2004 15:39:32 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040115153450.J73140@root.org>
References: <LAW11-OE34hRDT6Z3Ls000131c1@hotmail.com> <20040115141018.F72769@root.org>
 <Law11-OE71YaEv1Kq2E0000cace@hotmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Law11-OE71YaEv1Kq2E0000cace-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dino Klein <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 15 Jan 2004, Dino Klein wrote:
> > If you're looking to do throttling, some SMP boards support it.  The most
> > common way is with a shared P_BLK.  Either both Processor objects in the
> > ASL will have the same P_BLK or one will have it and the other will have a
> > NULL entry.  Either way, setting throttling through the P_BLK _ONCE_ (not
> > once per processor) sets the throttling level.
>
> Actually, I did play with the throttling, but not through the ACPI
> driver. I wrote directly to the register, and the system was reduced to
> ~5% (according to the datasheets) of it's former glory. I did that with
> both CPUs on the board, which makes me wonder - is there some way to
> figure out what is the clock speed of a particular CPU? maybe this way I
> can figure out whether my actions operate on both CPUs or only one one.

What are your Processor objects?  Here's a dual processor Xeon board with
a duplicated P_BLK.  The extra two objects are for the hyperthreading
logical CPUs.

IntelSE7501BR2.asl:        Processor (CPU1, 0x01, 0x00000410, 0x06) {}
IntelSE7501BR2.asl:        Processor (CPU2, 0x02, 0x00000410, 0x06) {}
IntelSE7501BR2.asl:        Processor (CPU3, 0x06, 0x00000410, 0x06) {}
IntelSE7501BR2.asl:        Processor (CPU4, 0x07, 0x00000410, 0x06) {}

No idea how to check clock speed of a particular CPU.  Try running a
benchmark pinned to one CPU and then the other.  I don't know the Linux
command for setting CPU affinity.  You could also run two tasks in
parallel that are a CPU benchmark.  Since throttling is linear, if you set
50% throttling and you get both tasks taking twice the time with
throttling as without, both CPUs are throttled.  If both tasks finish in
25% of the time, one processor is not throttled.

-Nate


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
