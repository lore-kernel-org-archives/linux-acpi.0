From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S4 reboots on resume
Date: Thu, 15 Jan 2004 13:21:42 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040115122142.GC12963@elf.ucw.cz>
References: <1073935225.2106.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1073935225.2106.15.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dirk Meul <dirk.meul-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I tested S4 (pmdisk) with 2.6.1-mm2. After approximately 10 minutes the
> computer powered off. When i resume it will reboot after reading the
> pages from swap and force a journal recovering. Is there a patch i can
> try? This happened with 2.6.x kernel before too.

Try these:

        swsusp/S3 tricks
        ~~~~~~~~~~~~~~~~
Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>

If you want to trick swsusp/S3 into working, you might want to try:

* go with minimal config, turn off drivers like USB, AGP you don't
  really need

* use ext2. At least it has working fsck. [If something seemes to go
  wrong, force fsck when you have a chance]

* turn off modules

* use vga text console, shut down X. [If you really want X, you might
  want to try vesafb later]

* try running as few processes as possible, preferably go to single
  user mode.

* due to video issues, swsusp should be easier to get working than
  S3. Try that first.

When you make it work, try to find out what exactly was it that broke
suspend, and preferably fix that.

Also try using swsusp, not pmdisk.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
