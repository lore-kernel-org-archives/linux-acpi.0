From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: Plea for help
Date: Fri, 19 Dec 2003 16:28:59 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031219142858.GC7009@luna.mooo.com>
References: <3FE28F79.601@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FE28F79.601-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 18, 2003 at 11:41:13PM -0600, Ian Pilcher wrote:
> I posted a couple of weeks ago about a kernel panic that shows up when I
> boot my Abit VP6 (dual-PIII) with ACPI turned on.  It turns out that the
> kernel boots just fine with ACPI on when I build it with
> CONFIG_DEBUG_SLAB=y.
> 
> Alan Cox suggested that this is probably due to code that kmallocs
> memory and then relies on its content without clearing it, but I never
> received any response to my request for suggestions on how to identify
> the offending code.
> 
> I've just spent several hours adding printk statements to the ACPI code,
> and I've reached a point where the oops message is overwriting portions
> of my printk messages.  I have the sinking feeling that this indicates
> that the process executing the ACPI code is not the one that's oops'ing.
> 
> I'm stuck.  How can a relative newbie debug a problem like this, or at
> least gather enough information to enable someone with more expertise to
> do so?
> 

If you say that CONFIG_DEBUG_SLAB=y solves the problem, you could start
by grepping in the kernel for CONFIG_DEBUG_SLAB and see what its doing.
This sounds like one of two things.
Either CONFIG_DEBUG_SLAB=y clears some memory which isn't cleared
properly somewhere else (there are quite a few kernel structures that
are allocated as slabs iirc), or its a timing problem that
CONFIG_DEBUG_SLAB solves by adding a printk somewhere that causes a
short delay (the second one will probably be a lot harder to solve).
I'll see if I have some time to look at it later.

> TIA.
> -- 
> ========================================================================
> Ian Pilcher                                        i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org
> ========================================================================
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
