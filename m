From: David Weinehall <tao-Z3oqqNSG8ADLoDKTGw+V6w@public.gmane.org>
Subject: Re: [BUG][2.6.10-rc2-bk1] ACPI S3 suspend to RAM broken (may be USB unable to resume)
Date: Wed, 17 Nov 2004 01:32:48 +0100
Message-ID: <20041117003248.GA5226@khan.acc.umu.se>
References: <200411161838.28344.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200411161838.28344.shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 16, 2004 at 06:38:27PM -0500, Shawn Starr wrote:
> 
> As of 2.6.10-rc1 + I can no longer resume from S3 (suspend-to-RAM),  When it 
> begins to resume, it seems to get stuck with USB (going to confirm).. The 
> laptop stays in a stuck state (cresent-moon remains lit).

I experience the same problem, but if I remove the snd_intel8x0 driver
before suspending, resume works properly.  This problem started with
-rc1-bk15 for me; which is interesting since there doesn't seem to be
any changes to snd_intel8x0 between -bk13 and -bk15...

> I have IBM-ACPI extras turned on (compiled in).
> 
> Anyone else report this?


Regards: David Weinehall
-- 
 /) David Weinehall <tao-Z3oqqNSG8ADLoDKTGw+V6w@public.gmane.org> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
