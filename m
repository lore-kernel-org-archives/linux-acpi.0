From: "Paulo Vitor Magacho da Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: EC Confusion
Date: Wed, 03 Aug 2005 11:25:39 -0300
Message-ID: <BAY12-F92E5A9FC6DBB288D14EC8A8C50@phx.gbl>
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

I am trying one more time to see if I can get ACPI working without any 
problems in my laptop. When I hit Fn+F4 (Sleep button) nothing happens. If I 
hit several times it starts working. If I hit Fn+F5 (to turn off the LCD) it 
confuses with Fn+F4. And if I hit a few times it starts to work.
The last working kernel versions I had were kernel 2.6.7 and kernel 
2.6.12-rc2-mm2, but both of them present problems when resuming. The first 
one resumes but the ethernet card doesn't work properly and the second one 
reboots when resuming (it's a problem in the wakeup.S file that I couldn't 
figure out where yet).
I've also tryed kernel 2.6.12 with the latest patches posted this week in 
the mailing list. Still the same problem.

Thanks,
Paulo

_________________________________________________________________
MSN Messenger: converse online com seus amigos .  
http://messenger.msn.com.br



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
