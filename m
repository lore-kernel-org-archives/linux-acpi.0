From: Alejandro Bonilla Beeche <abonilla-N/cRWR3FREN3ZuITGxAgx9i2O/JbrIOy@public.gmane.org>
Subject: ACPI errors on dmesg
Date: Mon, 17 Oct 2005 19:09:32 -0600
Message-ID: <43544B4C.4000703@linuxwireless.org>
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

Hi,

    I have debian Sid with 2.6.14-rc4-git. IBM T42. Please keep me on 
replys, I'm not in the ML.

I think that whenever I put my PC on xlock(matrix screensaver BTW) for 
too long and then I come back, I see my gnome 2.10 battery icon says N/A.

Then, dmesg is full of these messages.

    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed 
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c14cd4c0), AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed 
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c14cd4c0), AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed 
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c14cd4c0), AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed 
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c14cd4c0), AE_AML_METHOD_LIMIT

abonilla@debian:~$ apt-cache show acpi | grep Version
Version: 0.09-1
abonilla@debian:~$ apt-cache show acpid | grep Version
Version: 1.0.4-3

/etc/init.d/acpid restart has no effect.

abonilla@debian:~$ acpi -V
     Thermal 1: ok, 40.0 degrees C
  AC Adapter 1: off-line

It is just not showing the battery information.

Thanks,

.Alejandro


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
