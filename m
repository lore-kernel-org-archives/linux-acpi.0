From: wwp <subscript-GANU6spQydw@public.gmane.org>
Subject: Re: 2.4.24 patch apply failed on vanilla kernel
Date: Wed, 7 Jan 2004 17:38:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040107173858.543b22c5@tethys>
References: <20040107134658.5afa9142.acpi@thermoman.de>
	<20040107152540.574f5882@tethys>
	<20040107160711.GB12275@luna.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040107160711.GB12275-4cxDFgrrBECgSpxsJD1C4w@public.gmane.org>
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

Hi Micha Feigin,


On Wed, 7 Jan 2004 18:07:11 +0200 Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org> wrote:

[snip]
> > > patching file arch/i386/kernel/acpi.c
> > > patching file arch/i386/kernel/mpparse.c
> > > patching file arch/i386/kernel/smpboot.c
> > > Hunk #1 FAILED at 1106.
> > > 1 out of 1 hunk FAILED -- saving rejects to file
> > > arch/i386/kernel/smpboot.c.rej patching file arch/x86_64/kernel/acpi.c
> > > patching file drivers/acpi/Config.in
> > > patching file drivers/acpi/bus.c
> > > 
> > > Please CC me on replies.
> > 
> > Same here, you're not alone in the dark:
> > Hunk #1 FAILED at 1106.
> > 1 out of 1 hunk FAILED -- saving rejects to file arch/i386/kernel/smpboot.c.rej
> > 
> > 
> 
> I don't know what is the right solution, but its trying to replace
> - 	for (bit = 0; bit < BITS_PER_LONG; bit++) {
> with
> + 	for (bit = 0; bit < MAX_APICS; bit++) {
> While the line actually reads:
> 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
> 
> I left it as is and for now its working.

Currently, 2.4.24 uses NR_CPUS, and the fixes in the uv patch
(http://www.hardrock.org/kernel/current-updates/) uses BITS_PER_LONG.

Currently, the acpi patch tries to replace BITS_PER_LONG.
That's a bit confusing :-). That's why we need an answer from the ACPI guy
who manage this part of the patch, IMO.


Regards,

-- 
wwp


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
