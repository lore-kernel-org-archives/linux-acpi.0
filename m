From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: 2.4.24 patch apply failed on vanilla kernel
Date: Wed, 7 Jan 2004 18:07:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040107160711.GB12275@luna.mooo.com>
References: <20040107134658.5afa9142.acpi@thermoman.de> <20040107152540.574f5882@tethys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040107152540.574f5882-qdKmdXVU2OY@public.gmane.org>
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

On Wed, Jan 07, 2004 at 03:25:40PM +0100, wwp wrote:
> Hi Marcel Meckel,
> 
> 
> On Wed, 7 Jan 2004 13:46:58 +0100 Marcel Meckel <acpi-X2Xph2rMQzhn68oJJulU0Q@public.gmane.org> wrote:
> 
> > trying to patch 2.4.24 patch into a vanilla kernel results in 1
> > reject:
> > 
> > patching file arch/i386/kernel/acpi.c
> > patching file arch/i386/kernel/mpparse.c
> > patching file arch/i386/kernel/smpboot.c
> > Hunk #1 FAILED at 1106.
> > 1 out of 1 hunk FAILED -- saving rejects to file
> > arch/i386/kernel/smpboot.c.rej patching file arch/x86_64/kernel/acpi.c
> > patching file drivers/acpi/Config.in
> > patching file drivers/acpi/bus.c
> > 
> > Please CC me on replies.
> 
> Same here, you're not alone in the dark:
> Hunk #1 FAILED at 1106.
> 1 out of 1 hunk FAILED -- saving rejects to file arch/i386/kernel/smpboot.c.rej
> 
> 

I don't know what is the right solution, but its trying to replace
- 	for (bit = 0; bit < BITS_PER_LONG; bit++) {
with
+ 	for (bit = 0; bit < MAX_APICS; bit++) {
While the line actually reads:
	for (cpu = 0; cpu < NR_CPUS; cpu++) {

I left it as is and for now its working.

> Regards,
> 
> -- 
> wwp
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
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
