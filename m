From: Michael Wahlbrink <linux.wali-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: How to add DSDT in 2.4.21-rc1?
Date: Wed, 23 Apr 2003 13:59:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030423135907.68438480.linux.wali@gmx.de>
References: <21604.64.164.111.254.1051045324.squirrel@benham.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <21604.64.164.111.254.1051045324.squirrel-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
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

On Tue, 22 Apr 2003 14:02:04 -0700 (PDT)
"Darren Benham" <dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org> wrote:

> Ok, so maybe my last subject wasn't descriptive enough to get those that
> know to answer....
> 
> I gleefully went to compile the 2.4.21-rc1 source and everything went well
> until I tried to patch osl.c to include my custom DSDT (needed for my
> compaq laptop).  It's gone!  I tried "grep" for the override function
> we've all be patching and it's not there either.
> 
> What is the new "approved" (or hacked) way to include an override DSDT table?
Hi darren,
I think you had also to add a acpi patch to your kernel tree, cause without this you'll have only some old acpi-stuff in the kernel. Try the patch for the pre6 ... . But at all start to understand what you've done the time before you used acpi ... ;-)
hth
micha


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
