From: Neil Brown <neilb-YbfuJp6tym7X/JP9YwkgDA@public.gmane.org>
Subject: Reading /proc/acpi/battery/BAT0/info causes high latency on
 Dell Lattitude D800
Date: Sat, 26 Mar 2005 23:03:38 +1100
Message-ID: <16965.20378.943639.574357@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
 I have (another) problem with ACPI on my D800.
I have an applet (xacpi) which reports my battery status etc, and
every time it reads /proc/acpi/battery/BAT0/info (or .../BAT1/info),
any music that I am listening to 'skips'.
Below is an strace that shows nearly a 900ms pause in reading /info.
There is also a smaller pause while reading /state. This doesn't seem to
cause problems when playing music.

What can I do to try to get to the bottom of this problem and
(hopefully) fix it.

I am using 
	2.6.12-rc1-mm3
which includes
        ACPI: Subsystem revision 20050309

though this is not a new problem.

Thanks,
NeilBrown

1111838175.178580 open("/proc/acpi/battery/BAT0/info", O_RDONLY) = 5
1111838175.179059 fstat64(5, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
1111838175.179552 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f81000
1111838175.180195 read(5, "present:                 yes\ndes"..., 1024) = 432
1111838176.041591 read(5, "", 1024)     = 0
1111838176.042034 close(5)              = 0
1111838176.042468 munmap(0xb7f81000, 4096) = 0
1111838176.043018 open("/proc/acpi/battery/BAT0/state", O_RDONLY) = 5
1111838176.043506 fstat64(5, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
1111838176.043998 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f81000
1111838176.044595 read(5, "present:                 yes\ncap"..., 1024) = 192
1111838176.227703 read(5, "", 1024)     = 0
1111838176.228149 close(5)              = 0
1111838176.228580 munmap(0xb7f81000, 4096) = 0


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
