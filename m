From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: HP nw8000 never wakes up from acpi suspend
Date: Mon, 11 Oct 2004 18:24:02 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041011162402.GA1097@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8405BD1223@pdsmsx403> <E1CGJ5Z-0000X8-00@smtp.tt-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1CGJ5Z-0000X8-00-TxxZIs+w8t4JvtFkdXX2HpqQE7yCjDx5@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vadim Zeitlin <vadim-oE/GLL+f5xMgsBAKwltoeQ@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> YL> S1 is less important than S3 and S4.
> YL> So, please verify S4 is ok, then S3. 
> YL> S1 is nice-to-have.
> 
>  Thank you for your reply! I realize that S1 is less important, I'd mostly
> like to have S3 work.
> 
> YL> try command " echo -n 4 > /proc/acpi/sleep" for s4
> YL> echo -n 3 > /proc/acpi/sleep" for  s3
> YL> echo -n 1 > /proc/acpi/sleep"  for s1.
> 
>  Hmm, all of these commands do nothing here. I.e. the command succeeds
> without any observable effect.

s4 really should work. Unload usb and read
Documentation/power/swsusp.txt. You need to pass commandline parameter
etc.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
