From: Alberto <albeclemit-whZMOeQn8C0@public.gmane.org>
Subject: Re: ACPI S3 resume only reboots
Date: Mon, 4 Oct 2004 21:12:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041004211224.703e1982.albeclemit@yahoo.it>
References: <20041004133340.76ba05ba.albeclemit@yahoo.it>
	<1096907923.11326.15.camel@elrond.flymine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1096907923.11326.15.camel-Xmbc1Sz64/5pghhO6/9/sx2eb7JE58TQ@public.gmane.org>
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

On Mon, 04 Oct 2004 17:38:43 +0100
Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org> wrote:

> On Mon, 2004-10-04 at 13:33 +0200, Alberto wrote:
> 
> > When i do
> > cat -n "mem" > /sys/power/state
> > the system seems to go down fine in S3 state...
> > when i hit the power button it looks like trying to resume (fan starts again, noises from harddisk and cdrom) then it just reboots....
> 
> Do you have a /proc/acpi/wakeup_devices ? If so, what's in it?

Yes i have a /proc/acpi/wakeup

$ cat /proc/acpi/wakeup
Device  Sleep state     Status
PCI0       4            disabled
USB1       0            disabled
USB2       0            disabled
USB3       0            disabled
EHCI       0            disabled
 EC0       4            disabled
 LID       4            *enabled
 AC9       4            disabled
 MC9       4            disabled
ILAN       4            disabled
SLPB       4            *enabled

Pressing the lid button to simulate lid opening happens the same as above...


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
