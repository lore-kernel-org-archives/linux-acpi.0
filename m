From: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Subject: Re: i855-based ThinkPad STR: Graphics device stays in =?iso-8859-6?q?D3=09after?= resume
Date: Wed, 13 Apr 2005 08:08:50 -0400
Message-ID: <200504130808.50773.barr.156@osu.edu>
References: <200504122032.36053.barr.156@osu.edu> <1113353440.10110.96.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1113353440.10110.96.camel@tyrosine>
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
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 12 April 2005 08:50 pm, Matthew Garrett wrote:
> Hmm. Interesting. There's no code that will actually have bound to the
> PCI device (well, other than the drm driver, but that's different in
> magical ways), so the kernel won't attempt to reenable it on resume.
>
> We really should be doing something about devices that the kernel has no
> drivers for - at the moment, unless there's a driver loaded, we don't
> power down the device at all. However, I'm not entirely clear on /what/
> we should be doing.

I've made some promising progress in getting suspend-to-RAM working. The 
following commands return me to the bash prompt after suspend-to-RAM. I 
haven't had time to try this within X.org:

cat /sys/bus/pci/devices/0000:00:02.0/config > /var/tmp/pci.config
echo -n mem > /sys/power/state
(resume; ssh into the machine)
cat /var/tmp/pci.config > /proc/bus/pci/00/02.0
video_post

This is without any acpi_sleep parameters. Writing the saved config space back 
to sysfs didn't work--the device stayed in D3. Using /proc/bus/pci returned 
it to D0. I don't know why. I'll be testing this in X.org later on today.


--
Andrew Barr
Student, Ohio State University

[firstname][lastname] at columbus rr com | [lastname].156 at osu edu
http://home.columbus.rr.com/andrewbarr

"Everyone is entitled to their own opinions, but not their own facts."
	- Daniel Patrick Moynihan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
