From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: unable to set alam using echo to /proc/acpi/alarm
Date: Fri, 16 Dec 2005 20:40:16 +0100
Message-ID: <20051216194016.GA26760@message-id.gmane0305.slipkontur.de>
References: <302c0a190512111329i76e9e214v4aff822d99ae5de5@mail.gmail.com> <20051212152008.GA8748@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051212152008.GA8748-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

On Mon, Dec 12, 2005 at 04:20:08PM +0100, Pavel Machek wrote:
> Hi!
> 
> >    when I try setting the alarm to wake up my pc I get the following
> >    result:

> >    [root@mithrandir acpi]# cat alarm
> >    2005-12-00 17:18:19
> >    [root@mithrandir acpi]#
> >    BTW, nothing happens at the echo'd date/time. Could someone please
> >    give me a clue where to start looking?  I'm running fedora core 4, my
> >    mobo is an ASUS P5S800-VM, the documentation on the motherboard states
> >    that ACPI is supported. There is an option to turn acpi 2.0 on, but no
> >    difference...
> 
> alarm never worked properly, IIRC.

i have seen a thinkpad wake up from S3 at the specified alarm time.
So it works somehow. Although i was never able to figure out if it was
woken up manually or by the alarm.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
