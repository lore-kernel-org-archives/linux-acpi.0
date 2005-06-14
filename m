From: Pierpaolo Follia <pierpaolo.follia-J34gnSIbTpJUgOyQZvm8Rg@public.gmane.org>
Subject: Sony Vaio PCG-K195HP
Date: Tue, 14 Jun 2005 16:28:56 +0200
Message-ID: <42AEE9A8.90005@wavegroup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi to all.
About two weeks ago I successfully installed Ubuntu Linux 5.04 on my 
Sony Vaio PCG-K195HP, but I've some problem with the ACPI support of 
this laptop.
First of all I can't see battery information under /proc/acpi: it simply 
say that battery is not present. I tryed teweaking the sonypi driver, 
but nothing.
Second, it seems that my laptop can't hibernate/resume correctly: it 
hibernate, but when I start up the system again I only get garbage on my 
desktop and then the system freeze.
The only thing that seem to work fine is changing the LCD brightness 
using sony_acpi driver written by Stelian Pop.
Do you have some idea on how I can get at least the battery data work? 
Where do I have to "put my hands"?

Thank you very much.

-- 
Pierpaolo Follia
Wave S.r.l. - Vai Benaco 24/B, Bedizzole (BS)
Telefono: +39 030 687561
Fax: +39 030 6875690



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
