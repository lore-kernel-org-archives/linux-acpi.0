From: Ultrakorne <ultrakorne-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
Subject: Re: Re: Centrino speedstep
Date: Wed, 29 Dec 2004 20:40:50 +0100
Message-ID: <41D30842.4040204@paranoici.org>
References: <m2zmzyw4e7.fsf@phoenix.squirrel.nl>	<20041228212653.GA8436@dominikbrodowski.de> <m2vfalc53k.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2vfalc53k.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
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
Cc: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Johan Vromans wrote:
> The acpi-cpufreq driver loads, and the cpufreq tools seem to do
> something. But do they actually work? E.g. cpufreq-info reports that
> the limits are 1.6G - 600M, and cpufreq-set accepts 1.6G (confirmed by
> /proc/cpuinfo) but my CPU is only 1.5G...
> 
> -- Johan
> 

the same thing happen to my centrino, i have a 1.5g , and acpi-cpufreq
set min 600 max 1.6G ... i manually echoed a new maximum of 1.5 ...
the scaling seems to work fine, it automatically switch from 600 to 1500


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
