From: Andre Eisenbach <int2str-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: S3 resume and other ACPI questions
Date: Fri, 18 Mar 2005 19:33:48 -0800
Message-ID: <7f800d9f050318193340df70a9@mail.gmail.com>
References: <7f800d9f05022815286a10ddf6@mail.gmail.com>
	 <20050308095722.GA16798@elf.ucw.cz>
Reply-To: Andre Eisenbach <int2str-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050308095722.GA16798-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 8 Mar 2005 10:57:22 +0100, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> Read Doc*/power/video.txt. Send me a patch when you get it working.

Hello Pavel, all,

I've read video.txt and it got me further actually. Thanks for that.

I've recompiled the kernel without any fbcon etc. and use the "radeon"
display driver within X windows (Gentoo patched version). This way I
can actually resume from S3 now, and get right back into X. Really
quickly, too.

However, the hard drive does not seem to fair so well. The hdd
activity LED remains on and the drive does not seem responsive (but
spinning). The laptop slows to a crawl and any executable that causes
disc access (i.e. it's not cached or reads config files etc). Won't
execute.

dmesg seems to work, but doesn't really show anything. After the
"stopping tasks" I get a weird "Back from C!" message, but that's
about it.

What could I try from here?

I tried the suspend patch offered on the Acer TM 800 page linked in
video.txt, but it did not make a difference.

Side note:
I'm sorry there is no patch attached to this email, or probably any
email in the near future. I am trying to work myself into the subject,
but - as you know - it's very hard. And asides from the ACPI specs,
there doesn't even seem to be a good document describing how it's
supposed to work and which elements have to be in which place for this
all to work.
However, I hope I can help debugging and contribute to your well
appreciated efforts at least a little bit. Hey, maybe one day I'll
even have a patch to attach - even if it only fixes a typo ;).

Thanks,
    Andre


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
