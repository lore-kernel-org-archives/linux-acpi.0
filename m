From: Paulo Marques <pmarques-TSnNRl9vlf1Wk0Htik3J/w@public.gmane.org>
Subject: New error in dmesg between 2.6.10-bk1 and 2.6.10-bk2
Date: Thu, 24 Mar 2005 18:34:15 +0000
Message-ID: <42430827.20803@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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


Hi,

I have a machine that since 2.6.10-bk2 gives the following output in dmesg:

ACPI-1138: *** Error: Method execution failed [\MCTH] (Node c6dcee80), 
AE_AML_BUFFER_LIMIT
ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node 
c10f9840), AE_AML_BUFFER_LIMIT

Maybe because of this, after rebooting, the machine hangs before the 
BIOS is able to load LILO.

There are a lot of ACPI changes in this patchset, so it is hard to track 
down the exact change that made this happen :(

Do you think this is a bug in the DSDT that the kernel now doesn't 
tolerate, or is this a bug introduced in 2.6.10-bk2?

TIA,

P.S. - please CC me in any replies as I'm not subscribed to this list

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
