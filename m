From: Jason Dagit <dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org>
Subject: Re: Driver Testing
Date: Fri, 18 Mar 2005 10:55:11 -0800
Message-ID: <871xaciy28.fsf@www.codersbase.com>
References: <20050318175743.66629.qmail@web31406.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050318175743.66629.qmail-0gFffodynuCvuULXzWHTWIglqE1Y4D90QQ4Iyu8u01E@public.gmane.org> (nicdev05-/E1597aS9LQAvxtiuMwx3w@public.gmane.org's
 message of "Fri, 18 Mar 2005 09:57:43 -0800 (PST)")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: nicdev05 nic <nicdev05-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

nicdev05 nic <nicdev05-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> writes:

> Playing around more on the below problem, it appears that a ACPI
> module (button.ko) seems to have some issues and it causes the
> reboot. I am yet to dig deeper into what the exact issue might be, but
> removing this module before going into a suspend mode and then
> following with a resume works fine i.e. there is no reboot of the
> system on resume. Again this is on Fedora-2 system (with 2.6.5 kernel)
> -Nic

Ah, that's wonderful news.  I use button.ko and I haven't tried
unloading it.  I'll try this ASAP (so probably this weekend).  If you
learn anymore please send another update.

Thanks,
Jason


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
