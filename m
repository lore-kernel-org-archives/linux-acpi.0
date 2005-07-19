From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Compaq Deskpro EN SFF P500 DSDT Compile Error 1022
Date: Tue, 19 Jul 2005 16:50:30 +0200
Message-ID: <20050719145030.GH2715@poupinou.org>
References: <11957.137.71.23.54.1121461356.squirrel@www.briarhood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <11957.137.71.23.54.1121461356.squirrel-/xmnpVUFZ0+a+sir6i7KpgC/G2K4zDHf@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jared Jones <jared.jones-2fML+01oaiNBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 15, 2005 at 05:02:36PM -0400, Jared Jones wrote:
> I am trying to debug two issues on my machine:
> 1) WOL not working in Linux; maybe ACPI screws it up
> 2) Poweroff only occurs when acpi=force in Linux kernel option

Which means your BIOS is before 2001 or have been blacklisted
for whatever reason.

Is there a bios upgrade availble or are you running the latest one?

> So I wanted to check the machine's DSDT, which, go figure, was compiled
> using the Microsoft compiler and fails with the Intel compiler.  Can
> anyone please assist me in editing the DSDT?  I have never done this
> before.  Thanks!

I don't see no real reason yet to replace DSDT.  Or I missed something?

BTW, it would be fine to post somewhere the full dump of the acpidump
tool (see another post by me).

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
