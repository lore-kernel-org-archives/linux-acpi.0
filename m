From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Aspire 1511LMI - Aspire 1513LMI DSDT
Date: Fri, 19 Nov 2004 21:01:29 +0100
Message-ID: <20041119200129.GG31422@poupinou.org>
References: <419E5183.6030405@aliceposta.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <419E5183.6030405-nznwD2ikctv02BlrwmTdfg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: giupil <giupil-nznwD2ikctv02BlrwmTdfg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 19, 2004 at 08:03:15PM +0000, giupil wrote:
> Then I think that the acpidump command and iasl command in Freebsd works
> better that in Linux and that the freebsd error signals are, peraphs, more
> correct.

iasl is the same for both Linux and FreeBSD and is develloped and
maintained by Intel people.  acpidump from FreeBSD is now a wrapper to
iasl.

What produce FreeBSD acpidump is not only the decompiled DSDT, but also
the differents SSDTs if those are presents.  Under FreeBSD, when
a table is overriden, no further SSDT will be loaded by the OS,
whereas SSDTs will be loaded under Linux.

If you take the pmtools packages, then :
./acpidmp SSDT > ssdt
iasl -d ssdt

will produce the difference (the objects for the processor) you
have.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
