From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: smp support for s3 (not yet working)
Date: Tue, 6 Jul 2004 14:10:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040706121009.GA31488@elf.ucw.cz>
References: <20040706120513.GA26356@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040706120513.GA26356-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> Supporting SMP on S3 will be harder than SMP on swsusp... For swsusp,
> all cpus are initialized by kernel doing the resume, so we can just
> stop them and restart them. For S3, we'll have to kick start cpus by
> hand :-(.
> 
> If you remove code in acpi_restore_state_mem, it will actually resume,
> enable to type commands into bash, but die very soon because second
> cpu is not active.
> 
> If there's easy way to kick c to life, let me know...

Oh and Intel please fix your mailservers...

								Pavel

To: postmaster-ZPG494wuoPznoz6Kjl9f4RL4W9x8LtSr@public.gmane.org
To: pavel-+ZI9xUNit7I@public.gmane.org
Subject: Returned mail: see transcript for details
Auto-Submitted: auto-generated (failure)
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on
        atrey.karlin.mff.cuni.cz
X-Spam-Status: No, hits=0.0 required=5.0 tests=none autolearn=no
version=2.63
X-Spam-Level:
X-CRM114-Status: Good  ( pR: 105.9352 )

[-- Attachment #1 --]
[-- Type: text/plain, Encoding: 7bit, Size: 0.4K --]

The original message was received at Tue, 6 Jul 2004 12:05:35 GMT
from gprs214-134.eurotel.cz [160.218.214.134]

   ----- The following addresses had permanent fatal errors -----
<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
<shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
