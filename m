From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: Re: [Discontig-devel] RE: Cleanup of NUMA support in ACPI
Date: Wed, 14 Aug 2002 11:30:02 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020815032846.DAESC0A82654.59A07363@mvf.biglobe.ne.jp>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DD8B@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DD8B-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, discontig-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

On Wed, 14 Aug 2002 10:54:53 -0700
"Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> > From: KOCHI, Takayoshi [mailto:t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org] 
> > As I promised, I cleaned up NUMA support of ACPI and divided into
> > architecture-dependent part and architecture-independent part.
> > 
> > In this patch, I introduced a new config parameter 'CONFIG_ACPI_NUMA'.
> > At this moment, it is independent of CONFIG_NUMA but can be
> > tristated.  The division is because I'd like to distinguish
> > ACPI-dependent NUMA initialization stuff and
> > others (like SGI or phoney_srat/slit).
> 
> Nice.
> 
> My only comment is that instead of the ifdef CONFIG_ACPI_NUMA chunk in
> tables.c, this should just go in a separate file, say, drivers/acpi/numa.c.

My only concern was that as parsing of MADT and SRAT is mostly common,
we have to change common functions from static to extern to
split numa functions to other file.
But I don't see any problem because these function names are
not invasive to others.

> There are a bunch of other ACPI config options that should be split out like
> this as well, so if you don't want to redo the patch, I'll just take it and
> it can get fixed in a sweep with the others, later.

Erich has worked to clean up some portions and sent to LKML.
I'll split ACPI part from the patch and send to you this afternoon.

> BTW I was thinking I should only take the arch-neutral changes, and let you
> push the rest through David. Does that sound right?

Yes.
It's the dependency that if you won't accept the changes, David won't...

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
