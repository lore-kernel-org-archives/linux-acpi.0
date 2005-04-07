From: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Subject: C2/C3 state not entered AMD64 FSC Amilo A 1630
Date: Thu, 07 Apr 2005 19:10:07 +0200
Message-ID: <4255696F.3050707@renninger.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030103000301080308050204"
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
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030103000301080308050204
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

It seems as if the C-states are never entered successfully on this machine.
Sleep time is negative or zero after trying to go into C2/C3.

The machine has no _CST function defined and tries to trigger
C2/C3 states over pblk address:

Apr  7 08:38:29 linux kernel:  acpi_ec-0380 [206] acpi_ec_gpe_query     : Evaluating _Q30
Apr  7 08:40:06 linux kernel:  acpi_ec-0380 [217] acpi_ec_gpe_query     : Evaluating _Q30
Apr  7 08:40:10 linux kernel: acpi_processor-0439 [222] acpi_processor_get_inf: Bus mastering arbitration control present
Apr  7 08:40:10 linux kernel: acpi_processor-0490 [222] acpi_processor_get_inf: Processor [0:1]
Apr  7 08:40:10 linux kernel: Execute Method: [\_PR_.CPU1._PPC] (Node ffff81001fdc06b0)
Apr  7 08:40:10 linux kernel: acpi_processor-0192 [223] acpi_processor_get_thr: pblk_address[0x00000810] duty_offset[0] duty_width[0]
Apr  7 08:40:10 linux kernel: acpi_processor-0204 [223] acpi_processor_get_thr: No throttling states
Apr  7 08:40:10 linux kernel: acpi_processor-0546 [224] acpi_processor_get_pow: No _CST, giving up
Apr  7 08:40:10 linux kernel: acpi_processor-0518 [224] acpi_processor_get_pow: lvl2[0x00000814] lvl3[0x00000815]
Apr  7 08:40:10 linux kernel: ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
Apr  7 08:40:10 linux kernel:     scan-0555 [219] acpi_driver_attach    : Found driver [ACPI Processor Driver] for device [CPU1]

With the patch (pasted in the end) I get following output in /proc/acpi/processor/*/power
(sleep_ticks is always negative):

active state:            C2
max_cstate:              C8
bus master activity:     00000003
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[000] usage[00000010]
                         failed[00000000]
   *C2:                  type[C2] promotion[C3] demotion[C1] latency[080] usage[135559613]
                         *failed[135559613]*
    C3:                  type[C3] promotion[--] demotion[C2] latency[800] usage[00386088]
                         *failed[00386088]*


Anyone an idea what could go wrong here?
Could the patch be applied and failed transitions be displayed like above? Without it's not possible
to tell whether the states where really entered successfully.

Thanks,

         Thomas
________________________________________________
Patch shows failed C2/C3/Cn transitions in
/proc/acpi/processor/*/power

--- x/include/acpi/processor.h  2005-03-19 07:34:55.000000000 +0100
+++ y/include/acpi/processor.h  2005-04-07 10:15:09.000000000 +0200
@@ -48,6 +48,7 @@
        u32                     latency_ticks;
        u32                     power;
        u32                     usage;
+       u32                     failed;
        struct acpi_processor_cx_policy promotion;
        struct acpi_processor_cx_policy demotion;
 };
--- x/drivers/acpi/processor_idle.c     2005-03-19 07:35:03.000000000 +0100
+++ y/drivers/acpi/processor_idle.c     2005-04-07 15:59:58.000000000 +0200
@@ -278,7 +278,7 @@
                 *      go to an ISR rather than here.  Need to instrument
                 *      base interrupt handler.
                 */
-               sleep_ticks = 0xFFFFFFFF;
+               sleep_ticks = 0xFFFFFFF;
                break;

        case ACPI_STATE_C2:
@@ -319,6 +319,8 @@
                local_irq_enable();
                return;
        }
+       if (sleep_ticks < 0)
+               cx->failed++;

        next_state = pr->power.state;

@@ -910,6 +912,8 @@
                seq_printf(seq, "latency[%03d] usage[%08d]\n",
                        pr->power.states[i].latency,
                        pr->power.states[i].usage);
+               seq_printf(seq, "                         failed[%08d]\n",
+                       pr->power.states[i].failed);
        }

 end:

--------------030103000301080308050204
Content-Type: application/octet-stream;
 name="amilo_A_1630_fadt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="amilo_A_1630_fadt"

RkFDUPQAAAACG0EgTSBJIE9FTUZBQ1AgBwQAEk1TRlSXAAAAAPD9H/AD/R8BAAoASAgAAOEe
AAAACAAAAAAAAAQIAAAAAAAAFggAAAgIAAAgCAAAMAgAAAQCAQQEBBAAUAAgAwAEEAAAAA0A
AAEAACUAAAAAAAAAAAAAAAAAAAAAAAAAAPD9HwAAAADwA/0fAAAAAAEEAAAACAAAAAAAAAEE
AAAAAAAAAAAAAAECAAAECAAAAAAAAAECAAAAAAAAAAAAAAEBAAAWCAAAAAAAAAEEAAAICAAA
AAAAAAEAAAAgCAAAAAAAAAEAAAAwCAAAAAAAAA==
--------------030103000301080308050204--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
