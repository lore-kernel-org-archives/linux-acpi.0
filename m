From: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: [SoftwareSuspend-devel] One more ACPI event glitch
Date: Sat, 20 Nov 2004 09:29:06 +1100
Message-ID: <1100903319.25900.20.camel@desktop.cunninghams>
References: <200411191841.08206.lists@vizzzion.org>
Reply-To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200411191841.08206.lists-rLvmVVbSMWNg9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sebastian =?ISO-8859-1?Q?K=FCgler?= <lists-rLvmVVbSMWNg9hUCZPvPmw@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: SoftwareSuspend Development <softwaresuspend-devel-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Sat, 2004-11-20 at 04:41, Sebastian Kügler wrote:
> Hi!
> 
> I got hangs during resume, every second or third time I try to. Enabling 
> debugging show the following error written over and over again:
> ----------
> ACPI-0681: *** Error: acpi_ev_gpe_dispatch: Unable to queue handler for 
> GPE[ 0], event is disabled
> ----------
> Usually, if I hard-reset, then try to resume again, telling suspend2 not 
> to wipe out the image but resume from it, it works fine.
> 
> Is there something I can do about it? 

I suppose the simple solution for the moment is to comment out the error
line in drivers/acpi/events/evgpe.c. ACPI guys, is there a better
solution? (Should we be hitting this line in the first place?).

> Should I bug the ACPI people? 

Done :>

> Might this even be [1] in yet another fashion?

I'll leave that one to the ACPI guys :>

> Should 2.1.5.6 fix this problem?

It won't make a difference.

> Here's my debug_info:
> - SUSPEND core   : 2.1.5
> - Kernel Version : 2.6.9-ck3-suspend2
> - Compiler vers. : 3.3
> - Modules loaded : uhci_hcd usb_storage snd_pcm_oss snd_mixer_oss ipv6 
> ipt_state ipt_limit ipt_REJECT ipt_LOG ipt_MASQUERADE iptable_mangle 
> iptable_nat ip_conntrack iptable_filter ip_tables eth1394 ohci1394 
> ieee1394 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc 
> snd_mpu401_uart snd_rawmidi snd_seq_device snd usbhid intel_agp joydev 
> evdev orinoco_cs ds orinoco hermes yenta_socket pcmcia_core radeon 
> agpgart
> - Attempt number : 16
> - Parameters     : 0 2048 0 0 400 8192 5
> - Limits         : 131066 pages RAM. Initial boot: 126835.
> - Overall expected compression percentage: 0.
> - LZF Compressor enabled.
>   Compressed 418541568 bytes into 204863655 (51 percent compression).
> - Swapwriter active.
>   Swap available for image: 204936 pages.
> - Debugging compiled in.
> - I/O speed: Write 29 MB/s, Read 33 MB/s.
> 
> (I've also patched my kernel with Con Kolivas patchset [2], as you might 
> notice, also bootsplash is used. My .config can be found at [3])
> 
> [1] http://bugme.osdl.org/show_bug.cgi?id=1847
> [2] http://members.optusnet.com.au/ckolivas/kernel/
> [3] http://vizzzion.org/~sebas/config.gz

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
