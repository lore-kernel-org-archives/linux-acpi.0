From: Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Subject: Re: Fixing broken DSDT - code suggestions for comment
	please!
Date: Tue, 18 May 2004 17:30:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1084894210.8613.1.camel@localhost.localdomain>
References: <1084889946.5037.2.camel@laptop.hydeco.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1084889946.5037.2.camel-t0Me6uhKnbVYViWeMKg0xQC/G2K4zDHf@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: marmon-GymH4r+vMzPQT0dZR+AlfA@public.gmane.org
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-05-18 at 16:19, Franklin Marmon wrote:
> I've posted this question before, if its just a question that shall go
> unanswered someone please let me know so I stop reposting it different
> ways:
> 
> Where would start searching for information on debugging a compiled
> DSDT?  The iasl compiler believes it is fine, 0 errors, 0 warnings; but
> I kernel panic in the one_complete_parse phase when booting using the
> custom dsdt table.
> 

Enable debugging in APCI and write down the call trace from syslog. Post
it here and hopefully it will ring a bell.

N.B. You are running a current kernel and using the latest ACPI patches?
Please check that before trying. Because getting the answer that you've
spent the whole night on hunting an old bug is quite frustrating...

Bas.





-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
