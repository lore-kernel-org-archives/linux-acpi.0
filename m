From: Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>
Subject: Re: strange buzzing sound after the 2.6.10 patch
Date: Fri, 25 Feb 2005 12:03:28 +0100
Message-ID: <200502251203.28438.jos.delbar@ugent.be>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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

Jing,

Chances are that your laptop has imperfect electrical components that will 
oscillate and cause a buzzing sound under certain conditions. An example of 
such a condition is when ACPI promotes the processor to a higher C state in 
order to save power. This is why you only notice the buzzing sound when the 
processor is idle.

With recent ACPI patches you can control the maximum C state through 
the /sys/module/processor/parameters/max_cstate file. For example:

echo 2 > /sys/module/processor/parameters/max_cstate

To get an idea of which C states are causing the buzzing sound, watch the 
"usage" fields in the /proc/acpi/processor/CPU0/power file.

You can also set the limit using the processor module parameter max_cstate at 
boot time (or module load time).

-- 

- Jos Delbar
  jos.delbar-Cru1EgDzd7c@public.gmane.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
