From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Problem with ACPI and vmware
Date: Thu, 21 Nov 2002 16:29:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021121152957.GB1989@poup.poupinou.org>
References: <1037834173.1868.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1037834173.1868.10.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Francis Yom <fyom-NeBS1MF9zuBBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 20, 2002 at 06:16:13PM -0500, Francis Yom wrote:
> Hey guys,
> 
> I'm having a problem with ACPI and VMWare.  I am using ACPI 20021101 and
> VMWare 3.0 on kernel 2.4.19 with xfs and rmap14a.  My laptop is a Compaq
> presario 2700T.
> 
> When I include processor and thermal support in the kernel, I can see my
> battery and thermal zones just fine.  However, My Win2K and openbsd 3.2
> VMWare sessions stutter and are slow.  YES!  I did install the Idle
> patch.  In fact, with 20021101 ACPI it seems this patch is already in
> place.
> 
> When I remove processor and thermal support, I cannot see my battery any
> more, but VMWare sessions run fine without problems.
> 
> I am looking for a solution that will give me my battery support back
> and let me run VMWare without sluggishness.
> 

Please look at:
http://marc.theaimsgroup.com/?l=acpi4linux&m=102017446630814&w=2
and also at:
http://marc.theaimsgroup.com/?l=acpi4linux&m=102018451910031&w=2

My opinion is the same as Andy Groover.  Basically, it is a bug in
vmware, so vmware people have to fix that.  Since anybody here
have the source (apart the kernel modules), no one here can help
you.

The only possible workaround at this time for you if really you
want both acpi and vmware is to take a look at:
http://marc.theaimsgroup.com/?l=acpi4linux&m=101554163709698&w=2

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
