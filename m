From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: Sat, 14 Sep 2002 13:23:10 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209141237.g8ECb2d03519@pfn1.pefnos>
References: <Pine.LNX.4.44.0209071232170.1021-100000@cherise.pdx.osdl.net> <3D7C5FDF.4FB4E759@otello.alma.unibo.it> <20020913171338.GC7096@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020913171338.GC7096-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
> > connections. What happens if you are suspending a db server (well,
> > suspending a server is IMHO a really stupid thing, but...) and after
>
> Why?
>
Those are useful questions to ask. Scripts are flexible enough to handle 
special cases, we however have to ensure there are no stiff restrictions to 
those.

> You bought new UPS for your server. How do you install it without
> bringing machine down? Suspend to disk, rearrange power cables,
> resume.
>
> You have your server on UPS. Power died, and UPS is indicating 30
> seconds to failure. What do you do? Suspend to disk.
>
AFAIK there is already a 'low battery' line in 'inittab'. Following from that 
point, we should use that line (for ACPI) instead of directly (from a binary) 
trying to enter S4 or whatever. This way the root will chose how to handle 
such a situation. In some machines S4 may be broken (not ACPI's fault always, 
consider a mis-configured partition), there 'init 0' is the only safe way to 
go down (see S5). Only the root of the machine may know that.
This will certainly be a consideration point if we decide to implement (as a 
de-facto standard) the runlevel.

> Ethernet card in your server died. You want to replace it. Your
> server is not hotplug capable. What do you do? Suspend to disk,
> replace ethernet card, resume. If you are fast your users will not
> even see broken connections.
>
Q. Will that really work?  Won't the change of Ethernet MAC ruin that?
Anyway, everybody should be free to try that.

> [I've created FAQ section in Documentation/swsusp.txt; I'll put this
> question/answer in there in next merge.]
> 								Pavel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
