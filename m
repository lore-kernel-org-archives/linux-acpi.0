From: Lukasz <peryklez-5tc4TXWwyLM@public.gmane.org>
Subject: fan - problem
Date: Tue, 20 Sep 2005 23:02:19 +0200
Message-ID: <433078DB.6000807@wp.pl>
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

I'm running Fedora Core 4 on my Fujitsu-Siemens Amilo L1310G laptop.
I have downloaded vanilla 2.6.13 from kernel.org, patched it with 
acpi-20050902-2.6.13.diff.gz, modified DSDT (iasl reported a warning: 
"Reserved method must return a value (_WAK)") and compiled it into the 
kernel. I have also tried acpi_os_name kernel parameter... and nothing 
helps:/

The problem is that fan either works non-stop or doesn't work at all...

And even when the fan is not working both /proc/acpi/fan/FAN0/state and 
/proc/acpi/fan/FAN1/state read "status: on".

However, /proc/acpi/thermal_zone/THRM/state is changing correctly 
according to temperature changes and current setting in trip_points... 
but it has nothing to do with the fan.

Any suggestions, please?



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
