From: Andreas Dieling <adieling-cGBD8117FJM@public.gmane.org>
Subject: Re: Fan spinning speed
Date: Sun, 12 Sep 2004 11:33:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <414417FC.1010607@tzi.de>
References: <20040912021310.0838.SFNET-MAIL@melkor.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040912021310.0838.SFNET-MAIL-8gZPSnQ9TUZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Melkor <sfnet-mail-8gZPSnQ9TUZeoWH0uzbU5w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> By itself, lm-sensors works perfectly but there's a drawback. When the module "w83627hf"
> is loaded (modprobe w83627hf) the fan switches to max speed and never
> decreases again (tested on about 1 hour delay).
> 
> Has anyone already experienced a similar issue and would be in position to
> give any clue ? I've tried lots of configurations (removing ACPI 2.0 support
> in BIOS, removing thermal_zone support in kernel) but nothing seems to have
> any influence on this behaviour !

I had the exact same issue with my Asus M6N notebook. Try 2.6.9rc with 
"acpi_serialize" option, maybe this helps...

Andreas


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
