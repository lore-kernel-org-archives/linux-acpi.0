From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3 (fwd)
Date: Fri, 18 Feb 2005 01:09:11 +0100
Message-ID: <42153227.9060800@gmx.net>
References: <20050217232719.GB12638@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050217232719.GB12638-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: vojtech-AlSwsSmVLrQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Pavel Machek schrieb:
> 
>>>I'm not sure if you can push the whole industry at once.
>>
>>The goal is to know what to tell the system vendors
>>interested in supporting Linux what they should do
>>with their BIOS on future platforms.
>>
>>I believe our message should be:
>>1. BIOS should save/restore video in S3
> 
> Actually, that'd expect too much of BIOS writers. I believe right
> solution is "POST video as you do during normal boot in S3 resume".

Why not leave the choice to the BIOS writers? If some are able to
save/restore video state by themselves, we shoudln't stop them.
As long as the state after resume accepts setting the mode without
lockup, we should be fine.


>>2. Use Intel's ACPICA ASL compiler -- if not for production,
>>then at least as a static source code checker for validation.
> 
> 
> 3. Try to boot linux (here's live cd). If it complains about bios bugs
> (dmesg | grep ...), try to see if it is not indeed your bug.

That could even be automated more. A live cd which boots, performs
a few tests, displays the results on screen and offers an option
to save these results to usbstick/network/disk/whatever.
After saving the boot results, it will perform a S3 suspend and
resume and display/save the results of that, too. If Intel have
enough money, they could provide the functionality on a hard
disk and it would have the benefit that S4 could be tested as well.
If the disk has a FAT32 partition, the results can be saved there.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
