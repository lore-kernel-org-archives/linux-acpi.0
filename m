From: martin f.krafft <madduck-JX/+c5DPh7vR7s880joybQ@public.gmane.org>
Subject: Re: swsusp fails with "FATAL: cannot find swap device, try swapon -a!"
Date: Mon, 28 Feb 2005 13:50:12 +0000 (UTC)
Message-ID: <loom.20050228T144836-994@post.gmane.org>
References: <42225F85.1000302@gmx.net> <20050228000401.GK1441@elf.ucw.cz> <4222640C.7090706@gmx.net> <42227FE9.1080400@gmx.net> <42228A3D.6080907@gmx.net>
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

Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@...> writes:
> is_resume_device: checking 3:6 against resume_device 0:0
> [...]
> So resume_file has a non-zero length, but resume_device is 0:0.
> How can that happen?

Hi,

A friend pointed me to this list. I came to the same conclusion:

http://marc.theaimsgroup.com/?t=110789542400001&r=1&w=2

I will now see if 2.6.11-rcX fix this.

martin



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
