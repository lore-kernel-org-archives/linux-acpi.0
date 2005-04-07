From: Tomasz Kojm <tk-/1co0IagGzoYDkwjdqtpGQ@public.gmane.org>
Subject: Suspend2ram on Toshiba Tecra A3
Date: Thu, 7 Apr 2005 03:20:29 +0200
Message-ID: <20050407032029.4b0c9fea@Wierszokleta.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Dear power experts,

I'm fighting with S3 on Toshiba Tecra A3 without success for a few days
now. I've tried all combinations of acpi_sleep on various kernels
(including -mm ones) down to 2.6.8 and the effect is always the same:
laptop properly(?) suspends but on resume it doesn't initialize graphics
(LCD is off) and seem to be hanged (at least the keyboard, because the
system doesn't react on any commands, including ctrl+alt+del). The
computer is based on the Intel 915 GM chipset with integrated graphics.

I hope someone can drive me in a good direction. For the last three
years I was successfully using suspend2ram (via APM) on my old and good
Portege notebook and now suspend to disk doesn't look as a good
alternative from my point of view.

Thank you in advance,

-- 
   oo    .....         Tomasz Kojm <tkojm-Vl9ZkupcxcOsTnJN9+BGXg@public.gmane.org>
  (\/)\.........         http://www.ClamAV.net/gpg/tkojm.gpg
     \..........._         0DCA5A08407D5288279DB43454822DC8985A444B
       //\   /\              Thu Apr  7 03:18:42 CEST 2005


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
