From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: flood of errors in dmesg, loss of some battery information
Date: Thu, 24 Nov 2005 22:50:42 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC22E@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
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
To: gmishkin-jxCPH4jmHUs@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

What's your laptop model?
Does kernel option: acpi_serialize help?
If not , please file a bug on bugzilla.

Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Geoff Mishkin
>Sent: 2005=C4=EA11=D4=C224=C8=D5 22:41
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] flood of errors in dmesg, loss of some battery=20
>information
>
>(Please CC in replies)
>
>I am able to reproduce this on a completely vanilla 2.6.14.2=20
>kernel.  After=20
>running for a few minutes, I begin to see a flood of=20
>ACPI-related errors in=20
>the kernel log, and I am then unable to get battery=20
>information with acpi -b.
>
>If I cd to /proc/acpi/battery/BAT0, I can cat alarm and state=20
>and they look=20
>fine, but if I cat info I get:
>
>present:                 yes
>ERROR: Unable to read battery information
>
>Reloading the battery module doesn't help, rebooting is the=20
>only thing that=20
>works.  I linked the log because it's really long and I wanted=20
>to include all=20
>the messages to help, but it's just plain text.  You can see it at=20
>http://gmishkin.home.comcast.net/acpi_log.txt.
>
>Here's a list of modules I have loaded.
>
>arc4                    1600  1
>ieee80211_crypt_wep     3776  1
>ipw2200                69864  0
>ieee80211              20232  1 ipw2200
>ieee80211_crypt         4036  2 ieee80211_crypt_wep,ieee80211
>ipt_state               1536  1
>iptable_filter          2304  1
>iptable_nat             6724  0
>ip_nat                 15860  1 iptable_nat
>ip_conntrack           44912  3 ipt_state,iptable_nat,ip_nat
>iptable_mangle          2240  0
>ip_tables              18432  4=20
>ipt_state,iptable_filter,iptable_nat,iptable_man
>gle
>pcmcia                 32036  4
>yenta_socket           24588  4
>rsrc_nonstatic         11968  1 yenta_socket
>pcmcia_core            35792  3 pcmcia,yenta_socket,rsrc_nonstatic
>snd_pcm_oss            48096  0
>snd_mixer_oss          17088  1 snd_pcm_oss
>snd_seq_dummy           2692  0
>snd_seq_oss            31744  0
>snd_seq_midi_event      5568  1 snd_seq_oss
>snd_seq                47824  5=20
>snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
>snd_seq_device          6988  3 snd_seq_dummy,snd_seq_oss,snd_seq
>snd_intel8x0           29728  1
>snd_ac97_codec         93692  1 snd_intel8x0
>snd_ac97_bus            1856  1 snd_ac97_codec
>snd_pcm                80328  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
>snd_timer              20548  2 snd_seq,snd_pcm
>snd                    44772  11=20
>snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,sn
>d_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
>soundcore               7200  1 snd
>snd_page_alloc          8584  2 snd_intel8x0,snd_pcm
>nls_iso8859_1           3840  1
>ntfs                  101744  1
>nls_base                6144  2 nls_iso8859_1,ntfs
>nvram                   6856  2
>usbhid                 28292  0
>usb_storage            30980  0
>ehci_hcd               29256  0
>uhci_hcd               30608  0
>usbcore               108224  5 usbhid,usb_storage,ehci_hcd,uhci_hcd
>tun                     8768  0
>e1000                 102388  0
>evdev                   7488  1
>psmouse                36740  0
>radeon                105472  0
>drm                    64532  1 radeon
>intel_agp              20316  1
>agpgart                29576  2 drm,intel_agp
>rtc                     9784  0
>speedstep_centrino      4692  1
>freq_table              3460  1 speedstep_centrino
>ibm_acpi               24896  0
>hdaps                   9584  0
>video                  14148  0
>thermal                10888  0
>processor              18940  2 speedstep_centrino,thermal
>fan                     3204  0
>button                  4880  0
>battery                 8260  0
>ac                      3396  0
>
>I only had this problem since I upgraded from 2.6.12.5.
>
>			--Geoff Mishkin <gmishkin-jxCPH4jmHUs@public.gmane.org>
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
