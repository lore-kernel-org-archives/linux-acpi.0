From: "Paulo Vitor Magacho da Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: EC confusion
Date: Wed, 08 Jun 2005 19:04:13 -0300
Message-ID: <BAY1-F127B656D271A56CE966C54A8FD0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
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

Hi,

  I know this subject has been alredy addressed but I still couldn't get my 
laptop to work. If hit Fn+F4 (Sleep button) nothing happens. If I hit 
several times it starts working. If I hit Fn+F5 (to turn off the LCD) it 
confuses with Fn+F4. And if I hit a few times it starts to work.
  The last working kernel version I had was 2.6.7, but this kernel has some 
problems with usb and my network card driver after resume.
  I am trying to use kernel 2.6.11.11, with the following patches:
  - ACPI DSDT in initrd from http://gaugusch.at/kernel.shtml
  - EC patches from http://bugme.osdl.org/show_bug.cgi?id=4124, one from 
04/02/2005 and the other from 04/04/2005. I can't exactly tell which they 
are because the bugme.osdl.org webpage is down at the moment.
  I've also tryed the S3 test patch of Shaohua Li. No problems found.
  My laptop is Acer Aspire 1613Lmi.

Thanks,
Paulo

_________________________________________________________________
Chegou o que faltava: MSN Acesso Grátis. Instale Já! 
http://www.msn.com.br/discador



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
