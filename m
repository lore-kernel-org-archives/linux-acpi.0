From: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Subject: 2.6.7-rc2 breaks resume (was Re: S3 broken on a Samsung P30)
Date: Thu, 18 Nov 2004 00:54:26 +0100
Message-ID: <1100735666.5265.10.camel@mhcln03>
References: <1099605010.5191.20.camel@mhcln03>
	 <20041110231802.GA1099@elf.ucw.cz> <1100263919.3523.3.camel@mhcln03>
	 <20041112160435.GC1858@elf.ucw.cz> <1100283009.3608.2.camel@mhcln03>
	 <20041112195530.GA1123@elf.ucw.cz> <1100292909.3499.3.camel@mhcln03>
	 <20041112211659.GD1252@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041112211659.GD1252-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi again,

I did some more testing and found out that the P30 resumes from S3 with
kernel 2.6.1. Only the video is dead, but the notebook itself is
operational.

So i went to look for the patch that broke resume in recent kernels.
Resume works up to (and including) 2.6.7-rc1 ( patch-2.6.6-bk8-bk9.bz2 )

So the problematic code is in 2.6.7-rc2 [1] ( patch-2.6.6-bk9-final
[2] ).
As both patches are relatively huge, i have no idea of what I should
look for.

Is there a place where i can find all the individual patches which went
into 2.6.7-rc2
or patch-2.6.6-bk9-final?

Or does anyone here remember any problematic code in this specific
release?


Thanks for your time.

[1]
http://ftp.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.7-rc2.bz2
[2]
http://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/incr/patch-2.6.6-bk9-final.bz2
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
