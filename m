From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: RE: acpi-20031203-2.6.0.diff brokes the battery status
 readings with 2.6.0 in DELL Inspiron 8500
Date: Wed, 31 Dec 2003 17:43:40 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031231174230.R3326@root.org>
References: <3ACA40606221794F80A5670F0AF15F8401720C69@PDSMSX403.ccr.corp.intel.com>
 <3FF31FB6.7040306@videotron.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FF31FB6.7040306-XzQKRVe1yT0V+D8aMU/kSg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Mark M." <maalox-XzQKRVe1yT0V+D8aMU/kSg@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I can confirm success for one FreeBSD user with a broken Inspiron also.
Thanks for your work and I hope you can come up with a proper fix and
import it soon!

On Wed, 31 Dec 2003, Mark M. wrote:
> Success! I used the patch below and things seem to be working again.
> Actually, I manually edited my (2.6.0-mm)
> /usr/src/linux/drivers/acpi/dispatcher/dsmthdat.c
> because i don't think the paths in the patch would have worked. I just
> recompiled the kernel and rebooted.
>
> As a side note, I didn't include the before last line of the patch
> "new_obj_desc;", because it wasn't in my version of the file.

We removed that line from FreeBSD since it appears to be a typo.  Patch
was submitted back to Intel.

-Nate


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
