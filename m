From: Daniel Solsona <dani-fQczH/8Hd3rnGZpH1ro7E16hYfS7NtTn@public.gmane.org>
Subject: Re: DSDT Problems with Acer Aspire 1691WLMi
Date: Fri, 03 Jun 2005 11:35:45 +0200
Message-ID: <1117791345.7363.18.camel@localhost.localdomain>
References: <1117711110.7363.9.camel@localhost.localdomain>
	 <429F1315.80600@altern.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <429F1315.80600-whniv8GeeGkdnm+yROfE0A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Ok, I got a version of iasl taht compiled with no errors the custom dsdt
that I got from acpi.sourceforge

I put it on initrd as I read somewhere and restarted computer after
changing grub menu to get the new initrd.

But there is no change, I have the same problems as before. There is any
way I can confirm that the new dsdt is loaded correctly? maybe getting
dsdt from /proc/acpi/dsdt, decompiling and seeing if its the same as the
custom dsdt?





-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
