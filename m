From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: bus master activity must be polled?
Date: Wed, 4 May 2005 23:51:28 +0200
Message-ID: <20050504215128.GA7874@isilmar.linta.de>
References: <426CB990.9030306@renninger.de> <427769CB.4050802@renninger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <426CB990.9030306-smMupaH/RwJM7kwft8N7nw@public.gmane.org> <427769CB.4050802-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,


Reading the ICH4-M spec from intel (doc 252337 rev. 01), p. 371 actually
increases the confusion, so I tested it:

a) is the bit _only_ set if the CPU was in C3 and got awakened from there?

ANSWER: No. Even if only C2 is used, this bit is updated.

b) will the bit stay at "1" even if there is no bus master activity going
   on any longer?

ANSWER: Yes. It needs to be re-set by echo'ing "1".

c) if the bus master activity is only continuing (i.e. the transaction just
   hasn't finished yet), is the bus master status set to zero?

ANSWER: No. 

                if (bm_status) {
                        pr->power.bm_activity++;
                        acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
                                1, ACPI_MTX_DO_NOT_LOCK);
                        /* instant re-check */
                        acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
                        &bm_status, ACPI_MTX_DO_NOT_LOCK);
                        if (bm_status)
                                bm_activity2++;
                }

showed that bm_activity2 was always (almost) equal to bm_activity, at least 
when I looked ;)

What does this mean?


On Tue, May 03, 2005 at 02:08:43PM +0200, Thomas Renninger wrote:
>   - this is because bm_sts bit will be set when a bus master transaction
>     started.
No, also when it hasn't finished yet.


I think bm_status should influence how long we disable the idle tick, not
the other way round:

check bm_status
	-> if it is not set, and the other requirements are fulfilled,
		go to C3 or higher
	-> if it is set => only C2, don't sleep for longer than, lets say, 
		10 ms.

	alternatively:
	-> if it is set => only C2, don't sleep for longer than 1 ms, then
	   re-check; if bus mastering is gone and CPU load and bus master
	   load is low (some mask-based "weight", possibly?)
		for (i=0; i<32; i++) {
			weight += (bm_status & (0x1 << i)) * (33 - i);
		}
	   then enter C3 or higher for possibly longer time.

I think we can be more aggressive in entering higher idle states if
bm_status _was_ present but is no more.

Opinions? Ideas? Test results on non-Intel CPUs/chipsets?

	Dominik


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
