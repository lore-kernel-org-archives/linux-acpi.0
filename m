From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: BIOS bug?
Date: Sun, 20 Nov 2005 23:18:37 +0000
Message-ID: <20051120231837.GF2556@spitz.ucw.cz>
References: <437E528D.5070305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <437E528D.5070305-S0/GAf8tV78@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rathgeb Markus <maggu2810-S0/GAf8tV78@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri 18-11-05 23:15:41, Rathgeb Markus wrote:
> i tested a few thing, why s3 will not work with new kernels for me 
> (blank screen).
> can someone have a look at a cut-out from my /var/log/messages
> 
> i have execute also
> # lspci -vxxx > before
> before i go to s3 and
> # lspci -vxxx > after
> after the machine waked up (via ssh-console)
> 
> for example:
> before:
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 
> [Mobility Radeon 9600 M10] (prog-if 00 [VGA])
> 	Subsystem: Rioworks: Unknown device 2032
> 
> after:
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 
> [Mobility Radeon 9600 M10] (prog-if 00 [VGA])
> 	Subsystem: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10]

What is "new kernel", and what was last kernel that worked? See Doc*/power/video.txt.

									Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
