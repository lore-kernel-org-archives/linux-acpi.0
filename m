From: Martin Ginkel <mginkel-VDBW1ITIq+y+DWMCimbbknqWYbMAw+HU@public.gmane.org>
Subject: Wrong AC state
Date: Tue, 25 May 2004 15:15:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40B346FC.9090908@mpi-magdeburg.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dear ACPI-Folks,

I am trying to debug the code for reading the ac_adapter state.
On my laptop (Fujitsu-Siemens Amilo D 8830) this seems to be partially 
broken.
The /proc/ac_adapter/AC0/state has a value on-line or off-line from 
boot-time and doesn't change later on.
I already switched on debugging in the ac-module and the
acpi_ac_get_state function gets called every time I cat the state-file.
But it obviously reads the same value again and again.

Anyways: plugging the AC in and out get's recognized by the hardware:
The display dims up and down, using Windows the correct state is shown
and in Linux ACPI is getting 2 IRQs (according to /proc/interrupts).

Does anyone have suggestions where to start debugging?

	Best regards
	Martin





-- 
+-[Martin Ginkel]-------------[mailto:mginkel(at)mpi-magdeburg.mpg.de]-+
| MPI Magdeburg, Zi S2.09    Sandtorstr. 1, D-39106 Magdeburg, Germany |
|                                                                      |
|                                                                      |
+-[tel/fax: +49 391 6110 482/529]----[http://www.mpi-magdeburg.mpg.de]-+


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
