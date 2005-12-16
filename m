From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.14.3 suspend/resume with SMP (HT)
Date: Fri, 16 Dec 2005 10:12:43 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F10120CC53@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Karl H. Beckers" <karl.h.beckers-hi6Y0CQ0nG0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
>
>am a little stuck with suspend/resume on my ubuntu breezy system with a
>vanilla 2.6.14.3 kernel built according to
>http://www.columbia.edu/~ariel/acpi/acpi_howto.html
>
>Can't get it to suspend cleanly in normal runlevels, but when I boot to
>single user mode without vesafb, fbcon etc. and if I stop next to
>everything (NetworkManager, pcmcia, alsa etc.) and then unload all
sorts
>of modules I can get the system to suspend ... though it seems to hang
>with a line "Shutdown: hda" till I hit Enter.
>
>Now, when I resume, I get:
>
>Thawing cpus ...
>Booting processor 1/1 eip 3000
>Initializing CPU#1
>Stuck ??
>Inquiring remote API #1...
>... APIC #1 ID: failed
>... APIC #1 VERSION: failed
>... APIC #1 SPIV: failed
>Error taking cpu 1 up: -22
>Kernel panic - not synching: Not enough cpus
>
>While I tend to agree that I could use some more CPUs I don't panic
about
>it ;)
>
>Anyway, from what I see on this list the code that actually gives this
>output seems to be in some of the required patches mentioned here. Is
it
>safe to assume that 2.6.14.3 includes the patches needed for
>suspend/resume on a P4 with SMP/HT/PREEMPT in the kernel?
I think it's yes.
Could you please try the CPU offline and online in the system?
just do
offline:
echo 0 > /sys/devices/system/cpu/cpu1/online
online:
echo 1 > /sys/devices/system/cpu/cpu1/online
please check if the CPU1 is correctly online after that.

Thanks,
Shaohua


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
