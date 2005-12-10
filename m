From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [stable] [PATCH] Fix oops in asus_acpi.c on Samsung P30/P35 Laptops
Date: Sat, 10 Dec 2005 01:39:39 +0100
Message-ID: <439A23CB.50102@gmx.net>
References: <4395D945.6080108@gmx.net> <20051206192136.GA22615@kroah.com> <4395F0AB.1080408@gmx.net> <20051208033841.GA25008@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051208033841.GA25008-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Dear ACPI maintainers,

could you please comment on the following patch?


From: Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
Subject: [PATCH] acpi: Fix oops in asus_acpi.c on Samsung P30/P35 Laptops
Date: 2005-09-23 23:36:25 GMT

Samsung P35's INIT returns an integer (instead of a string or a
plain buffer), which caused an oops when the result was treated as
string in asus_hotk_get_info() (since an invalid pointer got
dereferenced).

This patch explicitly checks for ACPI_TYPE_INTEGER and for the
return values possible on the P30/P35.

Signed-off-by: Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
---

   drivers/acpi/asus_acpi.c |   31 ++++++++++++++++++++++++++++---
   1 files changed, 28 insertions(+), 3 deletions(-)

c51f431351c648519a9b91de3c5e1d636246d7bc
diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -1006,6 +1006,24 @@ static int __init asus_hotk_get_info(voi
   	}

   	model = (union acpi_object *)buffer.pointer;
+
+	/* INIT on Samsung's P35 returns an integer, possible return
+	 * values are tested below */
+	if (model->type == ACPI_TYPE_INTEGER) {
+		if (model->integer.value == -1 ||
+			model->integer.value == 0x58 ||
+			model->integer.value == 0x38) {
+			hotk->model = P30;
+			printk(KERN_NOTICE
+				       "  Samsung P35 detected, supported\n");
+			goto out_known;
+		} else {
+			printk(KERN_WARNING
+				"  unknown integer returned by INIT\n");
+			goto out_unknown;
+		}
+	}
+
   	if (model->type == ACPI_TYPE_STRING) {
   		printk(KERN_NOTICE "  %s model detected, ",
   		       model->string.pointer);
@@ -1057,9 +1075,7 @@ static int __init asus_hotk_get_info(voi
   		hotk->model = L5x;

   	if (hotk->model == END_MODEL) {
-		printk("unsupported, trying default values, supply the "
-		       "developers with your DSDT\n");
-		hotk->model = M2E;
+		goto out_unknown;
   	} else {
   		printk("supported\n");
   	}
@@ -1088,6 +1104,15 @@ static int __init asus_hotk_get_info(voi
   	acpi_os_free(model);

   	return AE_OK;
+
+out_unknown:
+	printk(KERN_WARNING "  unsupported, trying default values, "
+			"supply the developers with your DSDT\n");
+	hotk->model = M2E;
+out_known:
+	hotk->methods = &model_conf[hotk->model];
+	acpi_os_free(model);
+	return AE_OK;
   }

   static int __init asus_hotk_check(void)


Greg KH schrieb:
> On Tue, Dec 06, 2005 at 09:12:27PM +0100, Carl-Daniel Hailfinger wrote:
> 
>>Greg KH schrieb:
>>
>>>On Tue, Dec 06, 2005 at 07:32:37PM +0100, Carl-Daniel Hailfinger wrote:
>>>
>>>
>>>>Hi,
>>>>
>>>>on insmod of asus_acpi on my Samsung P35 laptop I get the following
>>>>Oops (perfectly reproducible):
>>>>
>>>>Asus Laptop ACPI Extras version 0.29
>>>>Unable to handle kernel NULL pointer dereference at virtual address 
>>>>00000000
>>>>printing eip:
>>>>e1dfc362
>>>>*pde = 00000000
>>>>Oops: 0000 [#1]
>>>>Modules linked in: asus_acpi thermal processor fan button battery ac 
>>>>snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97_bus 
>>>>snd_pcm snd_timer snd soundcore
>>>>snd_page_alloc ipt_TOS ipt_LOG ipt_limit ipt_pkttype pcmcia 
>>>>firmware_class ipt_state ip6t_REJECT ipt_REJECT iptable_mangle 
>>>>iptable_nat iptable_filter ip6table_mangle
>>>>ip_nat_ftp ip_nat ip_conntrack_ftp ip_conntrack nfnetlink ip_tables 
>>>>ip6table_filter ip6_tables ipv6 evdev sg sd_mod sr_mod scsi_mod intel_agp 
>>>>agpgart ohci1394 ieee1394
>>>>yenta_socket rsrc_nonstatic pcmcia_core ehci_hcd uhci_hcd i2c_i801 joydev 
>>>>dm_mod usbcore 8139too mii reiserfs ide_cd cdrom ide_disk piix ide_core
>>>>CPU:    0
>>>>EIP:    0060:[<e1dfc362>]    Not tainted VLI
>>>>EFLAGS: 00010203   (2.6.15-rc5)
>>>>EIP is at asus_hotk_get_info+0x17f/0x76c [asus_acpi]
>>>>eax: def75000   ebx: de8aaf54   ecx: 00000002   edx: 00000003
>>>>esi: 00000000   edi: e1e82a9c   ebp: dde2fea0   esp: de8aaf48
>>>>ds: 007b   es: 007b   ss: 0068
>>>>Process modprobe (pid: 6566, threadinfo=de8aa000 task=ddac05b0)
>>>>Stack: 00000000 00005105 deef8000 00000010 dde2fea0 dfeddc00 e1e83196 
>>>>dfeddc84
>>>>     dfedd820 e1dfc982 e1dfca11 dfeddc00 e1e849e0 00000000 c021c2fa 
>>>>     dfeddc00
>>>>     e1e849e0 c021c39e e1e84b00 0805bc08 00000028 de8aa000 e1dfcb20 
>>>>     c0133b32
>>>>Call Trace:
>>>>[<e1dfc982>] asus_hotk_check+0x33/0x34 [asus_acpi]
>>>>[<e1dfca11>] asus_hotk_add+0x8e/0x148 [asus_acpi]
>>>>[<c021c2fa>] acpi_bus_driver_init+0x2e/0x57
>>>>[<c021c39e>] acpi_driver_attach+0x3e/0x63
>>>>[<e1dfcb20>] asus_acpi_init+0x55/0x7d [asus_acpi]
>>>>[<c0133b32>] sys_init_module+0xf2/0x180
>>>>[<c0102e6f>] sysenter_past_esp+0x54/0x75
>>>>Code: 08 68 7f 30 e8 e1 e8 0e f2 31 de 58 5a a1 10 4d e8 e1 ba 03 00 00 
>>>>00 bf 9c 2a e8 e1 89 d1 c7 40 14 12 00 00 00 8b 75 08 49 78 08 <ac> ae 75 
>>>>08 84 c0 75 f5 31 c0 eb 04
>>>>19 c0 0c 01 85 c0 75 11 a1
>>>>
>>>>
>>>>This oops affects all kernels since 2.6.12. Patch follows.
>>>>Please apply.
>>>
>>>
>>>Is this patch accepted by the acpi maintainers yet?
>>
>>No, although it was posted to acpi-devel, it did not generate any
>>comment. The problem itself has been posted to acpi-devel many times
>>over. The first patch by Christian Aichinger did generate some
>>feedback and the patch I sent was his newest version which nobody
>>commented upon. This patch is also the last patch from
>>http://bugzilla.kernel.org/show_bug.cgi?id=5067
>>Only users commented on the patch, not any maintainer.
>>
>>However, since this oops has been unfixed for over 5 months and
>>nobody seems to care, I submitted the patch to stable@ in the
>>hope somebody would at least look at it.
> 
> 
> I'd recommend bugging the acpi maintainers, as they are the ones who can
> comment on this the best.  Have you sent it to them yet?
> 
> thanks,
> greg k-h

Thanks,
Carl-Daniel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
