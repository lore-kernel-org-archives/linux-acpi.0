From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: powernow & ACPI & 2.6.9
Date: Fri, 19 Nov 2004 09:59:00 +0100
Message-ID: <20041119085900.GD31422@poupinou.org>
References: <20041119083851.GB2908@mithrandir.dakordnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041119083851.GB2908-+E7KM1FDEuMaM1llmaQI7GCN55ObvEZU@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Giuseppe Martino <denever-GaUfNO9RBHfsrOwW+9ziJQ@public.gmane.org>
Cc: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 19, 2004 at 09:38:51AM +0100, Giuseppe Martino wrote:
> Hi to All,
> Output on Kernel 2.6.9 patched with acpi-20041105-26-latest-release.diff.bz2:
> 
> powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
> powernow: No PST tables match this cpuid (0x7a0)
> powernow: This is indicative of a broken BIOS.
> powernow: Trying ACPI perflib
> powernow: Minimum speed 298 MHz. Maximum speed 796 MHz.
> 
> The kernel 2.6.9 isn't able to catch my DSDT?

Could you please test those patches:
http://www.poupinou.org/cpufreq/powernow-k7/recalibrate_cpu_khz/powernow-k7.recalibrate-cpu_khz.diff
and
http://www.poupinou.org/cpufreq/powernow-k7/recalibrate_cpu_khz/timers-recalibrate_cpu_khz.diff

You need the two patches.

They have been already submitted to the cpufreq-dev mailing-list (which
is the appropriate place for discussing this kind of issue btw).

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
