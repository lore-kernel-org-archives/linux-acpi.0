From: Mario Giammarco <mgiammarco-gH+WsCr1+wQ1GQ1Ptb7lUw@public.gmane.org>
Subject: Thinkpad R50P and acpi problems
Date: Mon, 11 Oct 2004 16:39:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1097505589.2892.16.camel@r50p>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
I have just bought a thinkpad r50p.
I am using knoppix/debian. I have tried several kernels: 2.6.7 2.6.8.1
with acpi patches kolivas etc.
 
I have following problems/questions:
 
1) echo "3"> /proc/acpi/sleep makes system sleep (if I remove ehci_hcd).
But sometimes when it rewake it gives this fatal error:

ide: failed opcode was: unknown
hda: task_mulout_intr status 0x51 drive ready seek complete error
hda: task_mulout_intr error 0x04 drive status error


 
2) echo "4" > /proc/acpi/sleep makes system hibernate but is very very
slow. At least it works.
 
3) echo "disk" in /sys/power/state seems to hibernate but then it beeps
and wake up again (yes, I have removed ehci...)

4) Under xwindow I never reach c3 cpu state. Fan goes high. Battery does
not last very much.

5) I need a debian package for xwindow patched with dynamicpm. Where can
I find one?
 
6) How can I also automatically regulate cpu throttling?

8) Fglrx drivers works with acpi?

Wow!  Many questions! Thanks in advance for any reply!
 



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
