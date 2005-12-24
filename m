From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Toshiba Satellite P10 [Solved]
Date: Sat, 24 Dec 2005 14:57:56 +0100
Message-ID: <20051224135756.GI26351@elf.ucw.cz>
References: <20051224002527.GA16285@elf.ucw.cz> <43AC97E7.1030800@kroon.co.za> <20051224003808.GB16285@elf.ucw.cz> <43AD0AC6.9060904@kroon.co.za> <43AD2676.10703@roarinelk.homelinux.net> <43AD2F3F.7010003@kroon.co.za> <20051224114758.GD26351@elf.ucw.cz> <43AD407A.5020708@kroon.co.za> <20051224124903.GH26351@elf.ucw.cz> <43AD49A8.3010708@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43AD49A8.3010708-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jaco Kroon <jaco-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Cc: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On So 24-12-05 15:14:16, Jaco Kroon wrote:
> Pavel Machek wrote:
> 
> >>Now, with APIC, but no IO-APIC there is a bug notice during resume.
> >>Going to type it over (from dmesg):
> >>
> >>Back to C!
> >>Debug: sleeping function called from invalid context at mm/slab.c:2472
> >>in_atomic():0, irqs_disabled():1
> >> __might_sleep+0x9e/0xa6
> >> acpi_os_allocate+0x15/0x26
> >> kmem_cache_alloc+0x95/0xad
> >> acpi_ut_callocate+0x37/0x79
> > 
> > I know, it is scary, but it is also known and harmless. You can ignore
> > this one.
> 
> Now _that_ made me raise an eyebrow.  Even more than the fact that my
> DSDT insists on checking for the version of Microsoft Windows I'm
> running!

See archives. Len even had a fix at some point, but it was too ugly
IIRC.

> Not right now.  The festive season awaits (yay ...).  So in that spirit,
> Merry Christmas and a Happy New Year!

Merry Christmas!

> > Oh and thanks for video.txt diff, applied.
> 
> Shees.  That is my second accepted patch in a week.  Also my first two
> accepted patches.  LOL.  Hopefully there will be more to come.  Now I

:-).
								Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
