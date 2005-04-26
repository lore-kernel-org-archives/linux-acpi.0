From: Dave Royal <Dave-dq3oWbSUDswS+FvcfC7Uqw@public.gmane.org>
Subject: Albatron PX845PE - can't turn fan off
Date: Tue, 26 Apr 2005 06:20:36 +0100
Message-ID: <426DCFA4.3000308@DaveRoyal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Albatron PX845PE Pro II, Celeron 2.2, running Linux 2.6.8-24.14 (SuSE 
9.2) ACPI release 20040715
Problem: The CPU fan is always on - doing echo -n 3 > 
/proc/acpi/fan/FAN/state has no effect.

I have solved one problem with the DSDT: ACPI was seeing the wrong 
temperature: using sensor 2 from the Winbond W83627hf rather than sensor 
3. I have fixed that. ACPI now sees the correct CPU temperature (usually 
< 30 C) and I can set the trip points. But fan state is always on. 
Cooling mode is active. Fan speed is correct.

I wonder whether (a) there is code missing in the DSDT or (b) ACPI is 
being overridden by the BIOS. What code should be present in the DSDT 
for fan control to work? The only method apparent under Device (FAN)is 
_INI.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
