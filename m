From: =?ISO-8859-15?Q?Peter_M=FCnster?= <pmlists-GANU6spQydw@public.gmane.org>
Subject: wrong system time after wakeup
Date: Mon, 10 Jan 2005 20:39:14 +0100
Message-ID: <Pine.LNX.4.58.0501102008270.22897@gaston.free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Hello,
when resuming from S1, the system-time is completely wrong: about 22h
instead of 11h.
The system goes to sleep the day before at about 22h30 with the following
commands:
modprobe genrtc
sleep 5
echo 2005-01-11 11:10:00 >/proc/acpi/alarm
sleep 5
echo 1 >/proc/acpi/sleep

What could be wrong?
I'm using Linux-2.6.10 and ASUS A7N8X-X ACPI BIOS Rev 1006.

Thanks in advance for any help! Please tell me, if you need more information.
Kind regards, Peter

-- 
http://pmrb.free.fr/contact/
------------------------------------
Film Search site: http://f-s.sf.net/



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
