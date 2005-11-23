From: Yu Luming <luming.yu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: FW: [PATCH] Fix ACPI passive thermal management
Date: Wed, 23 Nov 2005 21:13:39 +0800
Message-ID: <200511232113.40650.luming.yu@gmail.com>
References: <3ACA40606221794F80A5670F0AF15F84041AC228@pdsmsx403> <200511221131.57603.luming.yu@gmail.com> <20051122204519.24ce7769.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051122204519.24ce7769.akpm-3NddpPZAyC0@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: pavel-AlSwsSmVLrQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, konstantin.a.karasyov-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 23 November 2005 12:45, Andrew Morton wrote:
> Yu Luming <luming.yu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > Hi!
> > >
> >  > > Fix issue: passive mode is not left, once entered
> >  > > http://bugzilla.kernel.org/show_bug.cgi?id=3410
> >  >
> >  > For this big patch, I believe you should provide longer description.
> >
> >  Oops, I forget this:
> >
> >  From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> >  Subject: [ACPI] Leave thermal passive cooling when machine cooled down
> >  References: 98178
> >
> >  Patch to leave thermal passive cooling when machine cooled down.
> >  Without this patch the polling frequency will always stay at
> >  passive cooling trip point polling frequency (tsp - BIOS) instead of
> >  tzp value (BIOS) or the possibly overridden value by
> >  /proc/acpi/thermal_zone/*/polling_frequency.
> >
> >  This will cause critical shutdowns on hot machines with a high tsp
> >  value exported by BIOS (e.g. the debugged machine (Thinkpad) exported
> >  a value of 600 which means in passive mode the temperature is only
> > polled each 60 seconds).
> >
> >  Acked-by: okir-l3A5Bk7waGM@public.gmane.org
>
> Patch was wordwrapped, but I fixed that up.

Sorry, Kmail  Wordwrap option enabled.  

>
> We should have your Signed-off-by: for this patch please, since you were
> in the supply chain.

Signed-off-by: Konstantin Karasyov <konstantin.a.karasyov-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Yu Luming <luming.yu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
