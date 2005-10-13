From: GregR <acpi-aFpS7BbXdM5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: ACPI problem
Date: Thu, 13 Oct 2005 18:13:13 +0000 (UTC)
Message-ID: <loom.20051013T201056-110@post.gmane.org>
References: <3ebbb09c0510061554h5c19610al9d0ecfabf9707312@mail.gmail.com> <4346530E.1070500@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Thomas Renninger <trenn@...
> You could use the cpufreqd (now called cpuspeed?) package that only scales 
> cpufreq or you can try to adopt the powersaved (that also includes a lot 
> additional features) to Knoppix (CVS hosted on forge.novell.com), be sure you 
> get help on the mailing list there.

I had a similar problem, except it would only overheat when compiling the 
kernel, (which takes a long time, and it would just overheat about 3/4 the way 
through).

I use cpufreq, and set the max to 90%. No more problems...

g





-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
