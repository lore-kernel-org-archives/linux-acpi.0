From: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Subject: bus master activity must be polled?
Date: Tue, 03 May 2005 14:08:43 +0200
Message-ID: <427769CB.4050802@renninger.de>
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
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I searched the APCI spec up and down, but couldn't find
anything where bus master activity can be read out
through interrupts?

Even something is listed under Fixed ACPI Events as bus master request,
what sounds like some kind of notification through hardware (p.137, spec 3.0),
I think it is not possible to get notified?

Is this right, that bm_sts always needs to be polled, then?
If I understand things right, this is how it is (must be?) done:

  - check bm_sts bit on every idle() call
  - if bm_sts bit is set wait at least xy ms (32 ms (100Hz), 40 ms (1000Hz))
    before triggering deeper sleeping states (C3, ...).
  - this is because bm_sts bit will be set when a bus master transaction
    started. When it is stopped cannot be detected, therefore it is assumed (cannot not
    be assured?) that the transaction finished after at least 30 ms. If bm_sts
    is not set again -> no bm activity -> trigger C3 or deeper states.


Playing around a bit with C-states I recognised that bm activity appears to
be set quite often.
If there would be the possibility of a notification if all bm transactions finished,
the efficiency of C-states could probably increased significantly (e.g. a realistic
average of bm activity appearing on my machine is ~100ms, waiting 40ms means the machine can be in
deeper sleeping states not more than 60% of total time, even if idle).
Maybe there are other ways to detect bus master activity than using ACPI interface?

Could somebody confirm whether this is right or whether I am wrong in some points, please?
Does somebody have any idea how this could be tweaked?

Thanks,

     Thomas


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
