From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Video BIOS reset?
Date: Thu, 18 Sep 2003 01:47:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030917234711.GA321@elf.ucw.cz>
References: <20030917095045.K12240@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030917095045.K12240-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

[Greetings to root.org. There's root.cz in our country, and I have
some friends there].

> I am looking into a common problem on FreeBSD.  Whenever I resume, the
> console is messed up.  X works fine.  When data is printed to the console,
> it scrolls diagonally and skips lines.  My first thought was that the VESA
> display was not in linear mode.
> 
> I looked at the Linux code and noted two parts that seem to be intended to
> address this:
> 
> 1. lcall 0xc0000,$3
> 2. int 0x10, func 0x4f02

> The first one appears to only be a read of the current VESA mode
> register.

The first one is "init VGA rom". 

> The second is Set Mode.  I tried adding this manually to our resume code
> but there is no change.  I also looked at vgacon.c to see if our console
> resume code wasn't complete but nothing jumped out at me.  Any ideas what
> we might be missing?

Notice that both lcall and int 0x10 are extremely ugly hacks, that are
not guaranteed to work, and have to be enabled manually by
commmand-line option. It does not work on all machines, either (there
are machines where neither 1. nor 2. works). Its a mess. Unfortunately
anything better needs video driver that knows how to bring up video
card from resume :-(.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
