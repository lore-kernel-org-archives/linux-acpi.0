From: =?ISO-8859-15?Q?Peter_M=FCnster?= <pmlists-GANU6spQydw@public.gmane.org>
Subject: system does not wake up sometimes
Date: Thu, 27 Jan 2005 18:40:33 +0100
Message-ID: <Pine.LNX.4.58.0501271837150.29216@gaston.free.fr>
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
very often, my system does not wake up at the specified time. I need to
press a key to resume.
The system goes to sleep the day before at about 22h30 with the following
commands:
modprobe genrtc
sleep 5
echo 2005-01-28 11:10:00 >/proc/acpi/alarm
sleep 5
echo 1 >/proc/acpi/sleep

What could be wrong?
I'm using Linux-2.6.10 and ASUS A7N8X-X ACPI BIOS Rev 1006.

Thanks in advance for any help! Please tell me, if you need more information.
Kind regards, Peter

-- 
email: pmrb at free.fr
http://pmrb.free.fr/contact/



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
