From: boltmelots <boltmelots-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Error-5 Could not suspend Device 0000: 00: ld. 7
Date: Thu, 2 Dec 2004 17:45:04 +1100
Message-ID: <9ed79ee0041201224525d402cd@mail.gmail.com>
Reply-To: boltmelots <boltmelots-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi all:

I have just recently after much trouble installed acpi with kernel
2.6.7 running debian unstable.  The laptop is Dell inspiron 500m.

I am having trouble putting the thing on standby.  I try 

           'echo 1 > /proc/acpi/sleep'

but it produces the following message and just comes back to normal. 
Does anyone know what it means and how I can fix it.  I will
appreciate any suggestions I can try.

PM: Preparing system for suspend
Stopping tasks: =====================================================|
PCI: Setting latency timer of device 0000:00:1d.7 to 64
Could not suspend device 0000:00:1d.7: error -5
PCI: Enabling device 0000:00:1f.5 (0000 -> 0003)
i810_audio: Primary codec has ID 0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7650 (Unknown)
PCI: Setting latency timer of device 0000:00:1f.6 to 64
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
Restarting tasks... done
apm: BIOS not found

Thanks and Kind Regards,
--
Bolt.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
