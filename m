From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Help! I lost my C4 states :-)
Date: Mon, 21 Feb 2005 09:12:26 +0100
Message-ID: <20050221081225.GA10848@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi,

Just curious:
i'm tracking Linus-bk-head quite closely. In (late?) January,
i was able to get my DELL D600 into C4. It worked fine and it
even got me an estimated 15-30 extra minutes out of the battery
(usually it lasts ~3.5 hours, the projected time with C4 was more
like almost 4 hours). Although this is great (it is more than i
ever got from laptop_mode and spinning down the harddisk), it
suddenly stopped working in February. Now the machine almost
always stays in C2, it hardly enters C3 or C4.

seife@strolchi:~> cat /proc/acpi/processor/CPU0/power
active state:            C2
max_cstate:              C8
bus master activity:     10000500
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[001] usage[00000010]
   *C2:                  type[C2] promotion[C3] demotion[C1] latency[001] usage[107659165]
    C3:                  type[C3] promotion[C4] demotion[C2] latency[085] usage[03505424]
    C4:                  type[C3] promotion[--] demotion[C3] latency[185] usage[06231087]

There is always some bus master activity which i have not been able to track
down. I tried unloading almost all modules, but it did not help. Of course
there is no sound running, no USB mouse attached etc. I have quiesced the
harddisk with laptop_mode and mounting filesystems noatime and commit=300.

The only thing that i can think of what has changed in my setup is that we
changed to modular IDE device drivers, but i cannot really imagine how that
would produce more bus master activity.

Any hints on how to track down what is causing bus master activity all the
time?
Has the calculation algorithm changed? Any default settings i could tweak?
-- 
Stefan Seyfried



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
