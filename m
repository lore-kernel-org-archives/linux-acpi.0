From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: swsusp with 2.5.33
Date: Fri, 13 Sep 2002 19:28:44 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020913172843.GD7096@elf.ucw.cz>
References: <Pine.SOL.4.21.0209082337150.3487-100000@neptun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.21.0209082337150.3487-100000-gIrQFgUln/g@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: kneumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> lately I observed problems with swsusp. Only if I am suspending from
> console right after the boot there are enough pages free....I did some
> research on the net and found that the rmap things does not free enough
> pages. 

Then either rmap is seriously broken or we are not calling it the
right way.

> AFAIU when suspending to disk the kernel (respective the vm) is asked to
> swap as many pages out as possible and creates an image from the remaining
> pages and writes that to disk. While that seems to be at first a great
> idea it depends - by design - upon the ability to free more than half of
> the ram. Why can one not stop all processes, lock the kernel, and write
> all pages to an image in swap space? 

It is far easier to fix VM than do that.
								Pavel 
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
