From: chirag <nisha_rajyaguru-xFOqZoH7zVZ4Eiagz67IpQ@public.gmane.org>
Subject: lid closer generates adapter event
Date: Fri, 24 Dec 2004 00:03:55 +0900
Message-ID: <1103814235.11379.10.camel@YahooBB219031151015.bbtec.net>
Reply-To: chirag-9dAiHs7qY9HTsWAM89vZ1+0/RLrZM5er@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
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

Hi!

I am having Dell inspiron 5150 with latest A37 bios with Mandrake 10.1
official installed. I am running 2.6.8.1-20mdk kernel. Although there
are no power button events and AC Adapter events logged
in /var/log/acpid, when I close my lid, computer goes into suspend,
which I have configured using klaptop. Upon resuming, I see that acpid
log shows 

[Thu Dec 23 21:03:20 2004]received event "ac_adapter AC 00000080
00000001"
[Thu Dec 23 21:03:20 2004] executing action
"/etc/acpi/actions/battery.sh"
[Thu Dec 23 21:03:20 2004] BEGIN HANDLER MESSAGES
Switching to on line battery mode
Stopping laptop_mode.
Setting CPU throttling to 0
[Thu Dec 23 21:03:20 2004] END HANDLER MESSAGES
[Thu Dec 23 21:03:20 2004] action exited with status 0
[Thu Dec 23 21:03:20 2004] completed event "ac_adapter AC 00000080
00000001"
[Thu Dec 23 23:23:13 2004] exiting

Initial 7 lines corresponds to lid closer event and rest are logged when
computer resumes. Interestingly both times acpid sees as if ac adapter
was plugged in. Running acpid in debug mode also does not show any power
or ac adapter events. I am looking at my dsdt.dsl file but I am not
getting any clue. 

Please help.....



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
