From: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Subject: Re: S3 broken on a Samsung P30
Date: Sat, 13 Nov 2004 11:53:48 +0100
Message-ID: <1100343228.3483.3.camel@mhcln03>
References: <88056F38E9E48644A0F562A38C64FB6003569022@scsmsx403.amr.corp.intel.com>
	 <20041112223209.GI1252@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041112223209.GI1252-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

Am Freitag, den 12.11.2004, 23:32 +0100 schrieb Pavel Machek:
> Hi!
> 
> > >> Tried again with 2.6.10-rc1-bk22 (latest ACPI patches IIRC) and the
> > >> patched wakeup.S
> > >> Still no beep :(
> > >
> > >Too bad, I do not know how to debug this further. It is possible that
> > >those patches are not yet merged into mainline, I'm not sure, it was
> > >something like "correcting wakeup address".
> > >
> > 
> > Are you referring to virtual v/s physical address patch from Shaohua?
> > http://bugme.osdl.org/show_bug.cgi?id=3390
> > I think it is already there in latest acpi-test.
> 
> Yes, but Matthias is using 2.6.10-rc1-bk22. Matthias, please try patch
> in above url (id=3851).
> 								Pavel

cat /home/mhentges/download/sources/sleep.patch |patch -p1 --dry-run
patching file drivers/acpi/sleep/main.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
+root@mhcln03:/usr/src/linux
>cat /home/mhentges/download/sources/sleep.patch |patch -R -p1 --dry-run
patching file drivers/acpi/sleep/main.c

Looks like this patch is already applied in -rc1-bk22

BTW: I did an "echo 0xFFFFFFFF > debug_layer ; echo 0xFFFFFFFF >
debug_level" and entered S3. It took quiet some time to suspend with
this debug verbosity ;)

Anyways, upon wakeup, there were no messages printed to the serial
console :(

Thanks for all you help
-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
