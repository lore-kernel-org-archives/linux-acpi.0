From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: ACPI-merges in 2.6.10-rc1-bk14 or 15 broke resume on
	Thinkpads
Date: Tue, 16 Nov 2004 01:05:27 +0000
Message-ID: <1100567127.30092.108.camel@tyrosine>
References: <20041113021105.GN29980@khan.acc.umu.se>
	 <1100537587.5876.953.camel@d845pe> <20041116003318.GS29980@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041116003318.GS29980-Qla6irXeAv31G4Ig9pEGJw@public.gmane.org>
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

On Tue, 2004-11-16 at 01:33 +0100, David Weinehall wrote:

> However, I've done some more debugging, and it turns out that if I
> remove snd_intel8x0 before suspending the first time, resume works
> properly.  Even if I have it loaded the next time I suspend.  A most
> interesting phenomenon, wouldn't you agree.

I've seen the same behaviour on a Thinkpad X40 - resume works fine if I
don't load any modules, works fine if I unload the sound module and then
reload it, but fails if I load it and don't remove it. 2.6.9 is fine, I
haven't had time to do a binary search.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
