From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: asus M5636NBP fan always on
Date: Tue, 29 Nov 2005 23:09:25 +0100
Message-ID: <20051129220925.GA23356@message-id.gmane0305.slipkontur.de>
References: <20051127161922.GM24446@sgala.com> <20051128150221.GA2983@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051128150221.GA2983-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

On Mon, Nov 28, 2005 at 04:02:21PM +0100, Pavel Machek wrote:
> On Ne 27-11-05 17:19:22, Matteo Sgalaberni wrote:
 
> > cat /proc/acpi/thermal_zone/THRM/trip_points
> > critical (S5):           115 C
> > passive:                 105 C: tc1=2 tc2=10 tsp=100 devices=0xc14706a0
> > active[0]:               20 C: devices=0xc1477480
> > 
> > I tryed to change this settings echoing new values but no feedback by 
> > the fan..
> 
> try echo -n "1:2:3:4:5" > trip_points.

or more specific:
echo -n "115:0:105:xx:0" > trip_points
the values are "critical:hot:passive:active0:active1:active2:..." and you
need to give at least 5 values, even though this machine has no "hot" and
no "active[1]" trip point.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
