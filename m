From: Gerfried Maier <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Subject: Random shutdowns
Date: Wed, 03 Sep 2003 07:49:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F5580DE.1060904@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dear ACPI-list!

On my notebook (Acer Travelmate 630) I experience random shutdowns when 
using Linux. Everything lokks like if someone called "init 6" or "halt".
(But this is completely impossible; I'm the only user on that machine, 
no internet connection available)

Because there is always a similar sequence of events logged in my 
/var/log/acpid, I think that this is acpi-related.

I hope that somebody can help me making these shutdowns disappear.

Thanhs a lot.
Maier Gerfried

Attached some sequences cut from /var/log/acpid which show entries just 
befroe or during such a shutdown (The kernel-log /var/log/messages does 
not give any specific information; It looks just like a "normal" shutdown):

...
[Mon Aug 25 22:56:28 2003] exiting
[Tue Aug 26 07:15:18 2003] starting up
[Tue Aug 26 07:15:18 2003] 1 rule loaded
[Tue Aug 26 07:21:02 2003] exiting
[Tue Aug 26 18:27:32 2003] starting up
[Tue Aug 26 18:27:32 2003] 1 rule loaded
[Tue Aug 26 19:30:43 2003] received event "thermal_zone THRS 000000f0 
00000001"
[Tue Aug 26 19:30:43 2003] executing action "/usr/sbin/acpid_proxy "
[Tue Aug 26 19:30:43 2003] BEGIN HANDLER MESSAGES
ACPI event
No action defined for ACPI event
[Tue Aug 26 19:30:43 2003] END HANDLER MESSAGES
[Tue Aug 26 19:30:43 2003] action exited with status 0
[Tue Aug 26 19:30:43 2003] completed event "thermal_zone THRS 000000f0 
00000001"
[Tue Aug 26 19:30:43 2003] received event "thermal_zone THRS 000000f0 
00000000"
[Tue Aug 26 19:30:43 2003] executing action "/usr/sbin/acpid_proxy "
[Tue Aug 26 19:30:43 2003] BEGIN HANDLER MESSAGES
ACPI event
No action defined for ACPI event
[Tue Aug 26 19:30:43 2003] END HANDLER MESSAGES
[Tue Aug 26 19:30:43 2003] action exited with status 0
[Tue Aug 26 19:30:43 2003] completed event "thermal_zone THRS 000000f0 
00000000"
[Tue Aug 26 19:30:51 2003] exiting
[Tue Aug 26 19:32:03 2003] starting up
[Tue Aug 26 19:32:03 2003] 1 rule loaded
[Tue Aug 26 20:29:43 2003] received event "thermal_zone THRS 000000f0 
00000001"
[Tue Aug 26 20:29:43 2003] executing action "/usr/sbin/acpid_proxy "
[Tue Aug 26 20:29:43 2003] BEGIN HANDLER MESSAGES
ACPI event
No action defined for ACPI event
[Tue Aug 26 20:29:43 2003] END HANDLER MESSAGES
[Tue Aug 26 20:29:43 2003] action exited with status 0
[Tue Aug 26 20:29:43 2003] completed event "thermal_zone THRS 000000f0 
00000001"
[Tue Aug 26 20:29:50 2003] exiting
[Tue Aug 26 20:31:08 2003] starting up

(two consecutive shutdowns)
...

[Tue Sep  2 12:29:04 2003] 1 rule loaded
[Tue Sep  2 12:32:24 2003] exiting
[Tue Sep  2 18:26:47 2003] starting up
[Tue Sep  2 18:26:47 2003] 1 rule loaded
[Tue Sep  2 20:57:09 2003] received event "thermal_zone THRS 000000f0 
00000001"
[Tue Sep  2 20:57:09 2003] executing action "/usr/sbin/acpid_proxy 
thermal_zone THRS 000000f0 00000001"
[Tue Sep  2 20:57:09 2003] BEGIN HANDLER MESSAGES
ACPI event thermal_zone THRS 000000f0 00000001
No action defined for ACPI event thermal_zone THRS 000000f0 00000001
[Tue Sep  2 20:57:09 2003] END HANDLER MESSAGES
[Tue Sep  2 20:57:09 2003] action exited with status 0
[Tue Sep  2 20:57:09 2003] completed event "thermal_zone THRS 000000f0 
00000001"
[Tue Sep  2 20:57:09 2003] received event "thermal_zone THRS 000000f0 
00000000"
[Tue Sep  2 20:57:09 2003] executing action "/usr/sbin/acpid_proxy 
thermal_zone THRS 000000f0 00000000"
[Tue Sep  2 20:57:09 2003] BEGIN HANDLER MESSAGES
ACPI event thermal_zone THRS 000000f0 00000000
No action defined for ACPI event thermal_zone THRS 000000f0 00000000
[Tue Sep  2 20:57:09 2003] END HANDLER MESSAGES
[Tue Sep  2 20:57:09 2003] action exited with status 0
[Tue Sep  2 20:57:09 2003] completed event "thermal_zone THRS 000000f0 
00000000"
[Tue Sep  2 20:57:19 2003] exiting
[Tue Sep  2 21:01:40 2003] starting up

...


when the first two shutdowns occured, my acpid was broken, so it did not 
call acpid_proxy correctly. But that's already fixed.






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
