From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Help wanted with IRQ routing.
Date: Mon, 14 Feb 2005 19:59:34 +1100
Message-ID: <1108371574.12611.61.camel@desktop.cunningham.myip.net.au>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
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
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi all.

(Get to play the customer for once!)

While visiting the US, I purchased a Netgear 511T card for my laptop.
It's being a pain to set up, and so I'm wanting to ask for some help.
(For the record, I set up a 311 on my desktop machine, so I believe I
know what I'm doing in general).

The problem I see is that when I start wpa_supplicant (ie actually start
to use the card), everything freezes up. If I pop the card out quickly,
I see that a couple of thousand interrupts have occurred in the couple
of seconds. If I'm too slow, I have to restart the machine.

I've spent a fair while Googling with the result that I think my problem
might be solved by getting the card on an interrupt line all by itself
(feel free to tell me I'm wrong!). I'm not sure how to achieve that
though. I've tried using setpci, but I don't have enough knowledge to do
anything useful.

Can someone help? I can provide the output dump_pirq, lspci and whatever
else you want if you tell me what will be helpful.

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
