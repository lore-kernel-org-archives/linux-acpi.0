From: Tomasz Kojm <tk-/1co0IagGzoYDkwjdqtpGQ@public.gmane.org>
Subject: Re: LCD does not wake up
Date: Sat, 9 Apr 2005 23:43:02 +0200
Message-ID: <20050409234302.418a18c0@Wierszokleta.pl>
References: <20050409213110.GA26933@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050409213110.GA26933-kdZ+H/N/Ve2ELgA04lAiVw@public.gmane.org>
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

On Sat, 9 Apr 2005 23:31:10 +0200
Hadmut Danisch <hadmut-kdZ+H/N/Ve2ELgA04lAiVw@public.gmane.org> wrote:

> I have an MSI S260 (Intel chipset) with
> kernel 2.6.11.7. 
> 
> An  echo mem > /sys/power/state  works well, 
> the machine goes into suspend state and wakes up 
> properly

Oh, lucky you! Mine is a sleepyhead and doesn't want to wake up at all
:-(

> except for one thing: The LCD remains black, backlight is not turned
> on.
> 
> How can I turn the display on?

Try `dpms on`. You can find the tool here:
http://www.srcf.ucam.org/~mjg59/laptops/

-- 
   oo    .....         Tomasz Kojm <tkojm-Vl9ZkupcxcOsTnJN9+BGXg@public.gmane.org>
  (\/)\.........         http://www.ClamAV.net/gpg/tkojm.gpg
     \..........._         0DCA5A08407D5288279DB43454822DC8985A444B
       //\   /\              Sat Apr  9 23:37:08 CEST 2005



-- 
   oo    .....         Tomasz Kojm <tkojm-Vl9ZkupcxcOsTnJN9+BGXg@public.gmane.org>
  (\/)\.........         http://www.ClamAV.net/gpg/tkojm.gpg
     \..........._         0DCA5A08407D5288279DB43454822DC8985A444B
       //\   /\              Sat Apr  9 23:42:00 CEST 2005


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
