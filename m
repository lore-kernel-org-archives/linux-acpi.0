From: "Paulo Vitor Magacho da Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: ACPI key events handling
Date: Tue, 08 Mar 2005 15:55:16 -0300
Message-ID: <BAY1-F15F671E407E4F476D2C957A8500@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
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

Hello,

   I have an ACER 163lmi laptop and I am having problem with some of the Fn 
keys. I don't know if this is related to ACPI or not.
   The problem is that when I press some the Fn keys, like the sleep button 
(Fn+F4), and I look at the /proc/acpi/event, sometimes the key works 
sometimes it doesn't. I did also the check of the Fn keys with the acerhk 
driver. My laptop has the mail, internet, p1, p2, wireless, buttons. And 
when I press those buttons, sometimes I get the correct reading from the 
acerhk driver, sometimes when I press the mail buttons it reads back the 
wireless, or any other key, and sometimes it just reads garbage.
   I've used the kernel 2.6.7 without problems.
   Now I was trying to use the kernel 2.6.11-rc4, and with this kernel I get 
all of these problems. I don't know if the key handling is done by the 
kernel or ACPI, but using a newer version of the kernel started causing this 
problems. If this is not ACPI related, maybe you could point to whom I 
should send this e-mail.
  Thanks.

Regards,
Paulo Silva

_________________________________________________________________
MSN Messenger: converse online com seus amigos .  
http://messenger.msn.com.br



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
