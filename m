From: Mario Giammarco <mgiammarco-gH+WsCr1+wQ1GQ1Ptb7lUw@public.gmane.org>
Subject: Re: Thinkpad r50p: serious slowness at restart.
Date: Sat, 23 Oct 2004 19:38:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098553118.21648.3.camel@r50p>
References: <1098552335.10630.3.camel@r50p>
	 <1098552629.23795.1.camel@sunshine>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1098552629.23795.1.camel@sunshine>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-thinkpad-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 2004-10-23 at 19:30 +0200, Timo Hoenig wrote:
> On Sat, 2004-10-23 at 19:25 +0200, Mario Giammarco wrote:
> [...]
> > I have done some checks and I have discovered with hdparm that when I
> > fresh start my machine I obtain 30mb/s from hard disk. When I
> > suspend/hibernate and I wake up it again I obtain only 3 mb/s.
> 
> Is DMA still on after suspend (hdparm -d /dev/hdX to obtain the status)?
> 
It is off, very very strange because:

1) hdparm -i shows me udma5 active
2) after wake up I restart several times debian hdparm script

Fortunately for me now I have manually set -d 1 and now I regained some
speed!

Thank you very much!



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
