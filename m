From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHES] add _CST support
Date: 22 Dec 2004 15:37:32 -0500
Message-ID: <1103747852.17331.237.camel@d845pe>
References: <20041127215118.GA30309@dominikbrodowski.de>
	 <1103698332.17318.170.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1103698332.17318.170.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I removed the D600 from the port replicator, and now
it is able to run in C4 w/o any hacks:

# cat /proc/acpi/processor/CPU0/power
active state:            2
max_cstate:              C3
bus master activity:     02000001
states:
    1:                  type[C1] promotion[2] demotion[-] latency[001]
usage[00111360]
   *2:                  type[C2] promotion[3] demotion[1] latency[001]
usage[00085464]
    3:                  type[C3] promotion[4] demotion[2] latency[085]
usage[00039905]
    4:                  type[C3] promotion[-] demotion[2] latency[185]
usage[00453561]

So a list of things we need comes to mind:
Enable > C1 on SMP
max_cstate able to disable C4 w/o disabling C3
"nocst" flag to compare FADT method w/ _CST
bm_check code fix -- currently has no clue of HZ
	a 100HZ kernel gets into C4 less than
	a 1000HZ kernel, likely because of this.
tick-less idle loop

cheers,
-Len

ps.
I haven't been able to reproduce the rmmod processor failure,
though I did have a console log to show that I wasn't halucinating
at 2AM this morning:

[root@d600 root]# rmmod processor
ERROR: Module processor is in use by thermal
[root@d600 root]# rmmod thermal
[root@d600 root]# rmmod processor
ERROR: Module processor is in use
[root@d600 root]# lsmod
Module                  Size  Used by
video                  20548  0
processor              30504  2
fan                     4228  0
container               4128  0
button                  6608  0
battery                10852  0
ac                      4740  0
[root@d600 root]# rmmod container
[root@d600 root]# rmmod processor
ERROR: Module processor is in use
[root@d600 root]# lsmod
Module                  Size  Used by
video                  20548  0
processor              30504  2
fan                     4228  0
button                  6608  0
battery                10852  0
ac                      4740  0




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
